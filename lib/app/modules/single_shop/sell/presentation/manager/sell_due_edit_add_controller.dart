


import 'dart:math';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:confetti/confetti.dart';
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
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sold_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/quick_sell_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:uuid/uuid.dart';


class SellDueEditAddController extends GetxController{
  var classStatus = ["কাস্টমার", "সাপ্লায়ার", "কর্মচারী"].obs;
  var selectedClassStatus = 'কাস্টমার'.obs;
  final employeeList = [].obs;

  final customerList = [].obs;
  final supplierList = [].obs;

  final shop = Shop().obs;

  final shopId = 0.obs;
  final dueType = 0.0.obs;
  final route = 0.obs;
  final dueAmount = 0.0.obs;
  final totalPrice = 0.0.obs;
  final itemLength = 0.obs;
  final note = ''.obs;
  final dueDetails = ''.obs;
  final sms = false.obs;
  final dueDate = DateTime.now().obs;
  final selectedDueItem =  GetAllDueItemByUid().obs;

  final due = Due().obs;
  final cartList = <Product>[].obs;

  final selectedEmployee = Rxn<Employee>();
  final selectedCustomer = Rxn<Customer>();
  final selectedSupplier = Rxn<Supplier>();

  final formKey = GlobalKey<FormState>();

  final nameTextEditingController = TextEditingController(text: '').obs;
  final numberTextEditingController = TextEditingController(text: '').obs;
  final amountTextEditingController = TextEditingController().obs;

  ConfettiController _controllerCenter =
  ConfettiController(duration: const Duration(microseconds: 100));

  final IContactRepository contactRepository;
  final IDueRepository dueRepository;
  final ITransactionRepository transactionRepository;
  SellDueEditAddController(this.contactRepository, this.dueRepository, this.transactionRepository);

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
    due.value = Get.arguments['due'];
    nameTextEditingController.value.text = due.value.contactName ?? '';
    numberTextEditingController.value.text = due.value.contactMobile ?? '';
    selectedClassStatus.value = due.value.contactType == null ? 'কাস্টমার':
    due.value.contactType == 'CUSTOMER' ? 'কাস্টমার' :
    due.value.contactType == 'EMPLOYEE' ? 'কর্মচারী' :
    due.value.contactType == 'SUPPLIER' ? 'সাপ্লায়ার' : 'কাস্টমার';
    dueType.value = Get.arguments['dueType'];
    route.value = Get.arguments['route'];
    selectedDueItem.value = Get.arguments['dueItem'];
    selectedDueItem.value.amount != null ? amountTextEditingController.value.text = selectedDueItem.value.amount.toString() : '';
    selectedCustomer.value = Get.arguments['customer'];
    selectedDueItem.value.amount = Get.arguments['dueAmount'];
    shop.value = Get.arguments['shop'];
    totalPrice.value = Get.arguments['totalPrice'];
    itemLength.value = Get.arguments['itemLenght'];
    note.value = Get.arguments['note'];
    cartList.assignAll(Get.arguments['cart']);
  }


  getAllEmployee() async {
    try {
      var response =
      await contactRepository.getAllEmployee(shopId: shopId.value);
      employeeList.assignAll(response);
    } catch (e) {

    }
  }

  getAllSupplier() async {
    var response =
    await contactRepository.getAllSupplier(shopId: shopId.value);

    supplierList.assignAll(response);
  }

  getAllCustomer() async {
    try {
      var response =
      await contactRepository.getAllCustomer(shopId: shopId.value);

      customerList.assignAll(response);
    } catch (e) {

    }
  }
  addNewDue() async{
    CustomDialog.showLoadingDialog(message: 'Adding Due');
    formKey.currentState.validate();
    formKey.currentState.save();
    var contactType = selectedClassStatus.value == 'কাস্টমার' ? 'CUSTOMER' : selectedClassStatus.value == 'সাপ্লায়ার' ? 'SUPPLIER' : 'EMPLOYEE';
    var uuid = Uuid();
    String dUniqueId = shopId.toString()+uuid.v1().toString()+DateTime.now().microsecondsSinceEpoch.toString();
    AddDueRequest request = AddDueRequest(
        amount: dueType.value == 0.0 ? dueAmount.value : -dueAmount,
        shopId: shopId.value,
        uniqueId: dUniqueId,
        version: 0,
        createdAt: dueDate.value.toString(),
        updatedAt: dueDate.value.toString(),
        contactType: contactType,
        contactMobile: numberTextEditingController.value.text,
        contactName: nameTextEditingController.value.text
    );
    String dIUniqueId = shopId.toString()+uuid.v1().toString()+DateTime.now().microsecondsSinceEpoch.toString();
    AddDueResponse response = await dueRepository.addNewDue(request);
    if(response.code == 200){
      AddDueItemRequest dueItemRequest = AddDueItemRequest(
        shopId: response.due.shopId,
        createdAt: response.due.createdAt.toString(),
        amount: response.due.dueAmount,
        dueUniqueId: response.due.uniqueId,
        uniqueId: dIUniqueId,
        version: 0,
        updatedAt:response.due.updatedAt.toString(),
        dueLeft: response.due.dueAmount.toInt(),
      );
      if(response.code == 200){
        final responseItem = await dueRepository.addNewDueItem(dueItemRequest);
        if(responseItem.code == 200){
          Get.back();
          Get.find<DueFrontController>().getAllDue();
          quickSell();
        }
      }
    }
  }

  quickSell() async {
    formKey.currentState.save();
    var uuid = Uuid();
    String tUniqueId = shop.value.id.toString()+uuid.v1().toString()+DateTime.now().microsecondsSinceEpoch.toString();
    String uniqueId = shop.value.id.toString()+uuid.v1().toString()+DateTime.now().microsecondsSinceEpoch.toString();
    String funiqueId = uniqueId.replaceAll("'", "");
    String sellUniqueId = uuid.v1().toString()+DateTime.now().microsecondsSinceEpoch.toString()+shop.value.id.toString();
    String fSellUniqueId = sellUniqueId.replaceAll("'", "");
    QuickSellRequest quickSellRequest = QuickSellRequest(
      createdAt: DateTime.now().toString(),
      shopId: shop.value.id,
      details: '',
      price: totalPrice.value.toInt(),
      version: 0,
      uniqueId: funiqueId,
      transactionUniqueId: fSellUniqueId,
      updatedAt: DateTime.now().toString(),
      profit: 0,
    );
    AddTransactionRequest transaction = AddTransactionRequest(
      shopId: shop.value.id,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      version: 0,
      changeAmount: 0.toString(),
      message: '',
      paymentMethod: 1,
      note: note.value,
      smsCount: 0,
      totalItem: itemLength.value,
      totalProfit: 0.toString(),
      totalPrice: totalPrice.value.toString(),
      totalVat: 0,
      transactionBarcode: '',
      receivedAmount: totalPrice.value.toString(),
      totalDiscount: 0,
      customerMobile: selectedCustomer.value.mobile,
      customerAddress: selectedCustomer.value.address,
      uniqueId: tUniqueId,
      transaction_type: "PRODUCT_SELL",
    );
    final response = await transactionRepository.quickSell(quickSellRequest);
    print("${response.code}");
    if (response.code == 200) {
      final response = await transactionRepository.addTransaction(transaction);
      if(response.code == 200){
        formKey.currentState.reset();
        Get.find<SellController>().clearCart();
        Get.find<ShopFeaturesController>().initData();
        Get.to(() =>
            SoldPage(
              shop: shop.value,
              route: 2,
              totalPrice: totalPrice.value.toInt(),
            ));
      }
    }
  }
}