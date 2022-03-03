import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/models/business_overview/customer_report.dart';

class ContactController extends GetxController {
  final employeeList = [].obs;

  final customerList = [].obs;
  final supplierList = [].obs;
  final supplierFoundData = [].obs;
  final customerFoundData = [].obs;
  final employeeFoundData = [].obs;
  final tabIndex = 0.obs;

  ContactController(this.contactRepository);

  final shop = Rxn<Shop>();

  final IContactRepository contactRepository;

  @override
  onInit() {
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
    await getAllSupplier();
    await getAllEmployee();
  }

  void runFilterForSupplier(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = supplierList.value;
    } else {
      results = supplierList.value
          .where((item) =>
          item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI

      supplierFoundData.value = results;

  }

  void runFilterForEmployee(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = employeeList.value;
    } else {
      results = employeeList.value
          .where((item) =>
          item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI

    employeeFoundData.value = results;

  }
  void runFilterForCustomer(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = customerList.value;
    } else {
      results = customerList.value
          .where((item) =>
          item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI

    customerFoundData.value = results;

  }
  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  getAllEmployee() async {
    try {
      var response =
          await contactRepository.getAllEmployee(shopId: shop.value.id);
      employeeList.assignAll(response);
      employeeFoundData.value = employeeList;
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }
  }

  getAllSupplier() async {
    // try {
    var response =
        await contactRepository.getAllSupplier(shopId: shop.value.id);

    supplierList.assignAll(response);
    supplierFoundData.value = supplierList;
    // } catch (e) {
    //   CustomDialog.showStringDialog(e.toString());
    // }
  }

  getAllCustomer() async {
    try {
      var response =
          await contactRepository.getAllCustomer(shopId: shop.value.id);

      customerList.assignAll(response);
      customerFoundData.value = customerList;
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }
  }
}
