import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';

class DueFrontController extends GetxController {
  final shop = Shop().obs;
  var dueList = <Due>[].obs;
  var searchList = <Due>[].obs;
  var classStatus = ["কাস্টমার", "সাপ্লায়ার", "কর্মচারী"].obs;
  var dueStatus = ["পাবো", "দিবো"].obs;
  var selectedClassStatus = 'কাস্টমার'.obs;
  var selectedDueStatus = 'পাবো'.obs;

  var dueToCollect = 0.0.obs;
  var dueToPay = 0.0.obs;
  var numberOfCustomer = 0.obs;
  var numberOfSupplier = 0.obs;
  var numberOfEmployee = 0.obs;
  final selectedStartDate = DateTime.now().obs;
  final selectedEndDate = Rxn<DateTime>();
  var dateDiff = 0.obs;

  final IDueRepository dueRepository;
  DueFrontController(this.dueRepository);

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
  }

  initData() async {
    await getAllDue();
  }

  Future<void> getAllDue() async {
    var filterList = <Due>[];
    final result = await dueRepository.getAllDue(shopId: shop.value.id);
    dueList.assignAll(result.data);
    dueList.forEach((element) {
      if (element.version != null && element.version > 0) {
        filterList.add(element);
      }
    });
    searchList.assignAll(filterList);
    calculateDue(searchList);
    getContactType(searchList);
    //getDayDue(selectedStartDate.value);
  }

  Future<void> searchDue(String searchCustomer) async {
    final result = dueList
        .where((Due due) =>
            due.contactName
                .toString()
                .toLowerCase()
                .contains(searchCustomer.toLowerCase()) ||
            due.contactMobile
                .toString()
                .toLowerCase()
                .contains(searchCustomer.toLowerCase()))
        .toList();
    searchList.assignAll(result);
    calculateDue(result);
  }

  void calculateDue(List<Due> due) {
    num tpDue = 0;
    num tdDue = 0;
    for (int i = 0; i < due.length; i++) {
      if (due[i].dueAmount >= 0) {
        tpDue = tpDue + due[i].dueAmount;
      } else if (due[i].dueAmount < 0) {
        tdDue = tdDue + due[i].dueAmount;
      }
    }
    if (due.isEmpty) {
      dueToCollect.value = 0;
      dueToPay.value = 0;
      print("my due to pay is 1$dueToPay");
    } else {
      dueToCollect.value = tpDue;
      dueToPay.value = -tdDue.toDouble();
      print("my due to pay is $dueToPay");
    }
  }

  getContactType(List<Due> due) {
    num costomer = 0;
    num supplier = 0;
    num employee = 0;
    due.forEach((element) {
      if (element.contactType.toLowerCase() == "customer") {
        costomer = costomer + 1;
      } else if (element.contactType.toLowerCase() == "employee") {
        employee = employee + 1;
      } else {
        supplier = supplier + 1;
      }
    });
    numberOfEmployee.value = employee;
    numberOfSupplier.value = supplier;
    numberOfCustomer.value = costomer;
  }

  getDayDue(DateTime date) {
    num costomer = 0;
    num supplier = 0;
    num employee = 0;
    final result = dueList
        .where((element) =>
            Utility.dateFormat.format(element.updatedAt) ==
            Utility.dateFormat.format(date))
        .toList();
    searchList.assignAll(result);
    calculateDue(searchList);
    searchList.forEach((element) {
      if (element.contactType.toLowerCase() == "customer") {
        costomer = costomer + 1;
      } else if (element.contactType.toLowerCase() == "employee") {
        employee = employee + 1;
      } else {
        supplier = supplier + 1;
      }
    });
    numberOfEmployee.value = employee;
    numberOfSupplier.value = supplier;
    numberOfCustomer.value = costomer;
  }

  customFilter() {
    var dueFor = '';
    if (selectedClassStatus.value == 'কাস্টমার') {
      dueFor = 'CUSTOMER';
    } else if (selectedClassStatus.value == 'সাপ্লায়ার') {
      dueFor = 'SUPPLIER';
    } else {
      dueFor = 'EMPLOYEE';
    }
    final result = dueList
        .where((Due due) =>
            due.contactType
                .toString()
                .toLowerCase()
                .contains(dueFor.toLowerCase()) &&
            (due.updatedAt.isAfter(
                    selectedStartDate.value.subtract(Duration(days: 1))) &&
                due.updatedAt
                    .isBefore(selectedEndDate.value.add(Duration(days: 1)))))
        .toList();
    searchList.assignAll(result);
    getContactType(searchList);
    calculateDue(searchList);
  }
}
