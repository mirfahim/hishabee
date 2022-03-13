import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_item_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_uniq_id.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_unuque_id.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_details_controller.dart';
import 'package:uuid/uuid.dart';

import 'due_list_controller.dart';

class DueEditAddController extends GetxController {
  var classStatus = ["কাস্টমার", "সাপ্লায়ার", "কর্মচারী"].obs;
  var selectedClassStatus = 'কাস্টমার'.obs;
  final employeeList = [].obs;

  final customerList = [].obs;
  final supplierList = [].obs;

  final shopId = 0.obs;
  final shop = Rxn<Shop>();
  final dueType = 0.0.obs;
  final route = 0.obs;
  final dueAmount = 0.0.obs;
  final dueDetails = ''.obs;
  final sms = false.obs;
  final dueDate = DateTime.now().obs;
  final selectedDueItem = GetAllDueItemByUid().obs;

  final due = Due().obs;

  final selectedEmployee = Rxn<Employee>();
  final selectedCustomer = Rxn<Customer>();
  final selectedSupplier = Rxn<Supplier>();

  final formKey = GlobalKey<FormState>();

  final nameTextEditingController = TextEditingController(text: '').obs;
  final numberTextEditingController = TextEditingController(text: '').obs;
  final amountTextEditingController = TextEditingController().obs;

  final IContactRepository contactRepository;
  final IDueRepository dueRepository;
  DueEditAddController(this.contactRepository, this.dueRepository);

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

  getArguments() {
    shopId.value = DataHolder.shopId;
    shop.value = Get.arguments['shop'];
    due.value = Get.arguments['due'];
    nameTextEditingController.value.text = due.value.contactName ?? '';
    numberTextEditingController.value.text = due.value.contactMobile ?? '';
    selectedClassStatus.value = due.value.contactType == null
        ? 'কাস্টমার'
        : due.value.contactType == 'CUSTOMER'
            ? 'কাস্টমার'
            : due.value.contactType == 'EMPLOYEE'
                ? 'কর্মচারী'
                : due.value.contactType == 'SUPPLIER'
                    ? 'সাপ্লায়ার'
                    : 'কাস্টমার';
    dueType.value = Get.arguments['dueType'];
    route.value = Get.arguments['route'];
    selectedDueItem.value = Get.arguments['dueItem'];
    selectedDueItem.value.amount != null
        ? amountTextEditingController.value.text =
            selectedDueItem.value.amount.toString()
        : '';
  }

  getAllEmployee() async {
    try {
      var response =
          await contactRepository.getAllEmployee(shopId: shopId.value);
      employeeList.assignAll(response);
    } catch (e) {}
  }

  getAllSupplier() async {
    var response = await contactRepository.getAllSupplier(shopId: shopId.value);

    supplierList.assignAll(response);
  }

  getAllCustomer() async {
    try {
      var response =
          await contactRepository.getAllCustomer(shopId: shopId.value);

      customerList.assignAll(response);
    } catch (e) {}
  }

  addNewDue() async {
    print("working _________");
    CustomDialog.showLoadingDialog(message: 'Adding Due');
    formKey.currentState.validate();
    formKey.currentState.save();
    var contactType = selectedClassStatus.value == 'কাস্টমার'
        ? 'CUSTOMER'
        : selectedClassStatus.value == 'সাপ্লায়ার'
            ? 'SUPPLIER'
            : 'EMPLOYEE';
    if (due.value.contactName != null &&
        nameTextEditingController.value.text == due.value.contactName) {
      var uuid = Uuid();
      String dUniqueId = shopId.toString() +
          uuid.v1().toString() +
          DateTime.now().microsecondsSinceEpoch.toString();
      AddDueItemRequest dueItemRequest = AddDueItemRequest(
          shopId: due.value.shopId,
          createdAt: DateTime.now().toString(),
          amount: dueType.value == 0.0 ? dueAmount.value : -dueAmount,
          dueUniqueId: due.value.uniqueId,
          uniqueId: selectedDueItem.value.uniqueId ?? dUniqueId,
          version: route.value == 0 || route.value == 1
              ? 0
              : selectedDueItem.value.version + 1,
          updatedAt: DateTime.now().toString(),
          dueLeft: (due.value.dueAmount + dueAmount.value).toInt());
      final response = await dueRepository.addNewDueItem(dueItemRequest);
      Get.back();
      if (response.code == 200) {
        Get.find<DueDetailsController>().getAllDueItem();
        Get.back();
      }
    } else {
      var uuid = Uuid();
      String dUniqueId = shopId.toString() +
          uuid.v1().toString() +
          DateTime.now().microsecondsSinceEpoch.toString();
      AddDueRequest request = AddDueRequest(
          amount: dueType.value == 0 ? dueAmount.value : -dueAmount,
          shopId: shopId.value,
          uniqueId: dUniqueId,
          version: 0,
          createdAt: dueDate.value.toString(),
          updatedAt: dueDate.value.toString(),
          contactType: contactType,
          contactMobile: numberTextEditingController.value.text,
          contactName: nameTextEditingController.value.text);
      String dIUniqueId = shopId.toString() +
          uuid.v1().toString() +
          DateTime.now().microsecondsSinceEpoch.toString();
      AddDueResponse response = await dueRepository.addNewDue(request);
      AddDueItemRequest dueItemRequest = AddDueItemRequest(
          shopId: response.due.shopId,
          createdAt: response.due.createdAt.toString(),
          amount: response.due.dueAmount,
          dueUniqueId: response.due.uniqueId,
          uniqueId: dIUniqueId,
          version: 0,
          updatedAt: response.due.updatedAt.toString(),
          dueLeft: response.due.dueAmount.toInt());
      if (response.code == 200) {
        final responseItem = await dueRepository.addNewDueItem(dueItemRequest);
        if (responseItem.code == 200) {
          Get.back();
          Get.find<DueFrontController>().getAllDue();
          Get.back();
        }
      }
    }
  }
}
