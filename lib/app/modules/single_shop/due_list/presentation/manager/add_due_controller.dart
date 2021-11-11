import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';

class AddDueController extends GetxController {
  final shop = Shop().obs;
  final name = ''.obs;
  final phoneNumber = ''.obs;
  final address = ''.obs;
  final amount = 0.obs;
  final isLoading = false.obs;
  final customerList = <Customer>[].obs;
  final searchCustomerList = <Customer>[].obs;
  final selectedCustomer = Customer().obs;
  var due = Rxn<Due>();

  final differenceOfDay = 0.obs;
  final differenceOfHour = 0.obs;
  final differenceOfMinute = 0.obs;
  final reDate = Rxn<DateTime>();

  final addDueResponse = AddDueResponseModel().obs;
  final IDueRepository dueRepository;
  final IContactRepository contactRepository;

  AddDueController(this.dueRepository, this.contactRepository);

  @override
  void onInit() async {
    getArguments();
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllCustomer();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
    due.value = Get.arguments["due"];
  }

  Future<void> addDue() async {
    isLoading.value = true;
    CustomDialog.showLoadingDialog(message: "Adding Due");
    addDueResponse.value = await dueRepository.addDue(
      shopId: shop.value.id,
      amount: amount.value,
      customerId: selectedCustomer.value.id,
      customerMobile: due.value == null
          ? selectedCustomer.value.mobile
          : due.value.customerMobile,
      customerName: name.value,
      customerAddress: address.value,
    );
    isLoading.value = false;
    if (Get.isDialogOpen) {
      Get.back();
    }
    final dlc = Get.find<DueListController>();
    await dlc.getAllDue();
    /* try {
      final ddc = Get.find<DueDetailsController>();
      ddc.due.value = addDueResponse.value.due;
    } catch (e) {}*/
  }

  Future<void> getAllCustomer() async {
    final result =
        await contactRepository.getAllCustomer(shopId: shop.value.id);
    customerList.assignAll(result);
    searchCustomerList.assignAll(result);
  }

  Future<void> searchCustomer(String searchCustomerName) async {
    if (searchCustomerName.isNotEmpty) {
      final result = customerList
          .where((Customer cu) =>
              cu.name.toLowerCase().contains(searchCustomerName.toLowerCase()))
          .toList();
      searchCustomerList.assignAll(result);
    } else {
      searchCustomerList.assignAll(customerList);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    TimeOfDay time;
    DateTime date;
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    reDate.value = date;
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    String CurrentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    TimeOfDay currentTime = TimeOfDay.now();

    var format = DateFormat("yyyy-MM-dd");
    var one = format.parseStrict(CurrentDate);
    differenceOfDay.value = date.difference(one).inDays;

    var timeformat = DateFormat("HH:mm");
    var Ctime = timeformat.parse(currentTime.format(context));
    var ttwo = timeformat.parse(time.format(context));
    differenceOfHour.value = ttwo.difference(Ctime).inHours;

    var miformat = DateFormat("HH:mm");
    var Mtime = miformat.parse(currentTime.format(context));
    var Mtwo = miformat.parse(time.format(context));
    differenceOfMinute.value = Mtwo.difference(Mtime).inMinutes;

    print("day: ${differenceOfDay.value}");
    print("hour: ${differenceOfHour.value}");
    print("dmin: ${differenceOfMinute.value}");
  }
}
