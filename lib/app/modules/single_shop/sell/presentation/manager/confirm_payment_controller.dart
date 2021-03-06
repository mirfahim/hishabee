import 'dart:math';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/digital_payment_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_digital_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sold_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/quick_sell_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transactions_page.dart';
import 'package:uuid/uuid.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class ConfirmPaymentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final addingNote = false.obs;
  final addingEmployeeInfo = false.obs;
  final addingCustomerInfo = false.obs;
  final discount = false.obs;
  final note = "".obs;
  final employeeName = "".obs;
  final employeeNumber = "".obs;
  final customerName = "".obs;
  final customerNumber = "".obs;
  final customerAddress = "".obs;
  final discountPercent = "".obs;
  final totalDiscount = 0.0.obs;

  final amountReceived = 0.0.obs;
  final dueAmount = 0.0.obs;
  final exchangeAmount = 0.0.obs;

  final shop = Rxn<Shop>();
  final cart = <Product>[].obs;
  final totalPrice = 0.0.obs;
  final discountPrice = 0.0.obs;
  final vat = 0.0.obs;
  final customerList = <Customer>[].obs;
  final employees = <Employee>[].obs;
  final searchEmployeeList = <Employee>[].obs;
  final selectedEmployee = Employee().obs;
  final customers = <Customer>[].obs;
  final searchCustomerList = <Customer>[].obs;
  var selectedCustomer = Customer().obs;
  var transactionItems = <TransactionItem>[];
  final cred = Rxn<LoginResponseModel>();

  final payWithQr = false.obs;

  ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(microseconds: 100));

  final IContactRepository contactRepository;
  final ITransactionRepository transactionRepository;
  final IDueRepository dueRepository;
  final IDigitalPaymentRepository digitalPaymentRepository;
  final IAuthRepository authRepository;
  final IDigitalPaymentProvider iDigitalPaymentProvider;
  final due = Due().obs;
  final shops = Shop().obs;
  final givenAmount = 0.obs;
  final url = ''.obs;
  ConfirmPaymentController(
      this.contactRepository,
      this.transactionRepository,
      this.dueRepository,
      this.iDigitalPaymentProvider,
      this.authRepository,
      this.digitalPaymentRepository);

  @override
  void onInit() async {
    getArguments();
    getInitialValue();
    //generateLink();
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    getTransactionItem();
    super.onReady();
  }

  initData() async {
    await getAllEmployee();
    await getAllCustomer();
    await getCred();
  }

  getInitialValue() {
    shop.value = Get.arguments["shop"];
    due.value = Get.arguments["due"];
    givenAmount.value = Get.arguments["amount"];
  }

  void generateLink() async {
    print("generate link is started $givenAmount");
    var result = await iDigitalPaymentProvider.updateDueDigitalPayment(
        shopId: shop.value.id,
        amount: totalPrice.value,
        address: "ojdso",
        customerId: 1,
        customerName: "mie",
        mobileNumber: "124345"
        //address: due.value.customer.address,
        // customerId: due.value.customer.id,
        // customerName: due.value.customer.name,
        // mobileNumber: due.value.customer.mobile
        );
    if (result.statusCode == 200) {
      print(result.statusCode.toString());
      url.value = result.body.url;
      print(result.body.url);
      Get.to(
        SellDigitalPaymentPage(
          amount: totalPrice,
          url: result.body.url,
        ),
      );
    } else {
      print(result.statusCode.toString());
    }
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

  Future<void> searchEmployee(String searchCustomerName) async {
    if (searchCustomerName.isNotEmpty) {
      final result = employees
          .where((Employee cu) =>
              cu.name.toLowerCase().contains(searchCustomerName.toLowerCase()))
          .toList();
      searchEmployeeList.assignAll(result);
    } else {
      searchEmployeeList.assignAll(employees);
    }
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
    cart.assignAll(Get.arguments['cart']);
    totalPrice.value = Get.arguments['totalPrice'];
  }

  calculateExchangeAmount() {
    if (amountReceived.value > totalPrice.value) {
      exchangeAmount.value = amountReceived.value - totalPrice.value;
    } else {
      exchangeAmount.value = 0.0;
    }
  }

  calculateDueAmount() {
    if (amountReceived.value < totalPrice.value) {
      dueAmount.value = totalPrice.value - amountReceived.value;
    } else {
      dueAmount.value = 0.0;
    }
  }

  getAllEmployee() async {
    final result =
        await contactRepository.getAllEmployee(shopId: shop.value.id);

    employees.assignAll(result);
  }

  getAllCustomer() async {
    final result =
        await contactRepository.getAllCustomer(shopId: shop.value.id);

    customers.assignAll(result);
    searchCustomerList.assignAll(result);
  }

  calculateDiscount() {
    final dp = double.parse(discountPercent.value);
    totalDiscount.value = (totalPrice.value * dp) / 100;
  }

  getTransactionItem() {
    calculateDueAmount();
    cart.forEach((element) {
      int quantity = 0;
      cart.forEach((e) {
        if (element.id == e.id) {
          quantity++;
        }
      });
      var sellingPrice =
          (element.sellingPrice * quantity) - (element.discount ?? 0);
      var txnItem = TransactionItem(
        id: element.id,
        name: element.name,
        // sellingPrice: sellingPrice,
        price: element.sellingPrice,
        imageSrc: element.imageUrl,
        quantity: quantity,
        discount: 0.0,
        vat: 0.0,
        unitPrice: element.sellingPrice,
      );

      transactionItems.add(txnItem);
    });
  }

  addCashTransaction() async {
    if (selectedCustomer.value.name == null) {
      CustomDialog.showStringDialog("Please select a customer");
      return;
    }
    var transactionItems = <TransactionItem>[];
    calculateDueAmount();

    cart.forEach((element) {
      int quantity = 0;
      cart.forEach((e) {
        if (element.id == e.id) {
          quantity++;
        }
      });
      var sellingPrice =
          (element.sellingPrice * quantity) - (element.discount ?? 0);
      var txnItem = TransactionItem(
        id: element.id,
        name: element.name,
        // sellingPrice: sellingPrice,
        price: element.sellingPrice,
        imageSrc: element.imageUrl,
        quantity: quantity,
        discount: 0.0,
        vat: 0.0,
        unitPrice: element.sellingPrice,
      );

      transactionItems.add(txnItem);
    });

    Transactions transaction = Transactions(
        shopId: shop.value.id,
        note: note.value,
        employeeName: employeeName.value,
        employeeMobile: employeeNumber.value,
        customerName: customerName.value,
        customerMobile: customerNumber.value,
        customerAddress: customerAddress.value,
        totalDiscount: totalDiscount.value,
        changeAmount: exchangeAmount.value,
        receivedAmount: amountReceived.value,
        createdAt: DateTime.now(),
        time: DateTime.now(),
        totalPrice: totalPrice.value,
        totalItem: transactionItems.length,
        paymentMethod: 1,
        totalVat: 0.0,
        transactionItems: transactionItems);

    try {
      CustomDialog.showLoadingDialog();
      /*await transactionRepository.addTransaction(shop.value.id, transaction);*/
      if (dueAmount.value > 0) {
        await dueRepository.addDue(
            userId: shop.value.userId,
            shopId: shop.value.id,
            amount: dueAmount.value,
            customerId: selectedCustomer.value.id,
            customerName: selectedCustomer.value.name,
            customerAddress: selectedCustomer.value.address,
            customerMobile: selectedCustomer.value.mobile);
      }
      final SellController sc = Get.find();
      sc.cart.clear();
      sc.calculateTotalCartPrice();
      CustomDialog.hideDialog();
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }
  }

  addDigitalTransaction() async {
    //quickSell();
    if (selectedCustomer.value.name == null) {
      CustomDialog.showStringDialog("Please select a customer");
      return;
    }
    var transactionItems = <TransactionItem>[];
    calculateDueAmount();

    cart.forEach((element) {
      int quantity = 0;
      cart.forEach((e) {
        if (element.id == e.id) {
          quantity++;
        }
      });
      var sellingPrice =
          (element.sellingPrice * quantity) - (element.discount ?? 0);
      var txnItem = TransactionItem(
        id: element.id,
        name: element.name,
        //sellingPrice: sellingPrice,
        price: element.sellingPrice,
        imageSrc: element.imageUrl,
        quantity: quantity,
        discount: 0.0,
        vat: 0.0,
        unitPrice: element.sellingPrice,
      );

      transactionItems.add(txnItem);
    });

    Transactions transaction = Transactions(
        shopId: shop.value.id,
        note: note.value,
        employeeName: employeeName.value,
        employeeMobile: employeeNumber.value,
        customerName: customerName.value,
        customerMobile: customerNumber.value,
        customerAddress: customerAddress.value,
        totalDiscount: totalDiscount.value,
        changeAmount: exchangeAmount.value,
        receivedAmount: amountReceived.value,
        createdAt: DateTime.now(),
        time: DateTime.now(),
        totalPrice: totalPrice.value,
        totalItem: transactionItems.length,
        paymentMethod: 1,
        totalVat: 0.0,
        transactionItems: transactionItems);

    try {
      CustomDialog.showLoadingDialog();
      final result = await digitalPaymentRepository.digitalPayment(
        shopId: shop.value.id,
        time: DateTime.now().toIso8601String(),
        totalPrice: totalPrice.value,
        customerName: selectedCustomer.value.name,
        changeAmount: exchangeAmount.value,
        customerAddress: selectedCustomer.value.address,
        customerMobile: selectedCustomer.value.mobile,
        employeeId: selectedEmployee.value.id,
        employeeMobile: selectedEmployee.value.mobile,
        employeeName: selectedEmployee.value.name,
        note: note.value,
        paymentMethod: 2,
        receivedAmount: amountReceived.value,
        totalDiscount: totalDiscount.value,
        totalVat: 0.0,
        totalItem: transactionItems.length,
        transactionBarcode: transaction.transactionBarcode,
        transactionItems: transactionItems,
      );
      if (dueAmount.value > 0) {
        await dueRepository.addDue(
            userId: shop.value.userId,
            shopId: shop.value.id,
            amount: dueAmount.value,
            customerId: selectedCustomer.value.id,
            customerName: selectedCustomer.value.name,
            customerAddress: selectedCustomer.value.address,
            customerMobile: selectedCustomer.value.mobile);
      }
      CustomDialog.hideDialog();
      final SellController sc = Get.find();
      sc.cart.clear();
      sc.calculateTotalCartPrice();
      if (result.code == 200) {
        Get.to(() => SellDigitalPaymentPage(
              customerMobile: selectedCustomer.value.mobile,
              shop: shop.value,
              url: result.url,
              customerEmail: selectedCustomer.value.email,
              amount: result.transaction.totalPrice,
            ));
      } else {
        CustomDialog.showStringDialog(result.message);
      }
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }

    /* Get.to(() => SoldPage(
          transaction: transaction,
          shop: shop.value,
          route: 1,
        ));*/
  }

  getCred() async {
    final result = await authRepository.getCredentials();
    cred.value = result;
  }

  Future<dynamic> addTransactionItemsRequest({
    id,
    String uniqueID,
    discount,
  }) async {
    final SellController sc = Get.find();
    sc.cart.forEach((ele) {
      print("my addTransactionItemsRequest are ${ele.name}");
      //  print("my add transaction ****** ${ele.")
      addTransactionItems(
          uniqueID: uniqueID,
          productID: ele.id,
          discount: discount,
          productPrice: ele.sellingPrice,
          quantity: ele.unit);
    });
  }
  Future<dynamic> editTransactionItemsRequest({


   quantity,

  }) async {
    final SellController sc = Get.find();
    sc.cart.forEach((ele) {
      print("my addTransactionItemsRequest are ${ele.name}");
      //  print("my add transaction ****** ${ele.")
      addTransactionItems(
          version: ele.version + 1,
          uniqueID: ele.uniqueID,
          productID: ele.id,
          discount: ele.discount,
          productPrice: ele.sellingPrice,
          quantity: ele.unit);
    });
  }

  Future<dynamic> addTransactionItems(

      {String uniqueID,
        int version,
      int productID,
      discount,
      productPrice,
      quantity}) async {
    var uuid = Uuid();
    print("working 101");
    String tUniqueId = shop.value.id.toString() +
        uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString();

    String uniqueId = shop.value.id.toString() +
        uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString();

    ApiService _apiService = ApiService();
    String url =
        "/transaction_item/?shop_id=${shop.value.id}&created_at=${DateTime.now()}&updated_at=${DateTime.now()}&price=$productPrice&discount=$discount&shop_product_id=$productID&quantity=$quantity&status=PAID&name=abc&vat=0&unit_vat=0&unit_price=10&profit=100&unit_cost=0&unique_id=$uniqueId&version=$version&transaction_unique_id=$uniqueID";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  quickSell() async {
    final SellController sc = Get.find();
    formKey.currentState.save();
    var uuid = Uuid();
    String tUniqueId = shop.value.id.toString() +
        uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString();
    String uniqueId = shop.value.id.toString() +
        uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString();
    String funiqueId = uniqueId.replaceAll("'", "");
    String sellUniqueId = uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString() +
        shop.value.id.toString();
    String fSellUniqueId = sellUniqueId.replaceAll("'", "");
    QuickSellRequest quickSellRequest = QuickSellRequest(
      createdAt: DateTime.now().toString(),
      shopId: shop.value.id,
      details: '',
      price: totalPrice.value,
      version: 0,
      uniqueId: funiqueId,
      transactionUniqueId: fSellUniqueId,
      updatedAt: DateTime.now().toString(),
      profit: 0,
    );
    AddTransactionRequest transactionss = AddTransactionRequest(
      shopId: shop.value.id,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      version: 0,
      changeAmount: 0.toString(),
      message: '',
      paymentMethod: 1,
      note: note.value,
      smsCount: 0,
      totalItem: cart.length,
      totalProfit: 0.toString(),
      totalPrice: totalPrice.value.toString(),
      totalVat: vat,
      transactionBarcode: '',
      receivedAmount: totalPrice.value.toString(),
      totalDiscount: totalDiscount,
      customerName: selectedCustomer.value.name,
      customerMobile: selectedCustomer.value.mobile,
      customerAddress: selectedCustomer.value.address,
      uniqueId: tUniqueId,
      transaction_type: "PRODUCT_SELL",
    );
    final response = await transactionRepository.quickSell(quickSellRequest);
    print("${response.code}");
    if (response.code == 200) {
      print("yo bro unqID is ++++++++++ $tUniqueId");
      addTransactionItemsRequest(
          id: shop.value.id, uniqueID: tUniqueId, discount: totalDiscount);
      // addTransactionItems(id: shop.value.id, uniqueID: tUniqueId);
      final response =
          await transactionRepository.addTransaction(transactionss);
      //final responseTrns = await transactionRepository.getAllTransaction();
      if (response.code == 200) {
        formKey.currentState.reset();
        //  Get.find<SellController>().clearCart();
        final SellController sc = Get.find();
        Get.find<ShopFeaturesController>().initData();
        Get.to(() => SoldPage(
              shop: shop.value,
              route: 2,
              totalPrice: totalPrice.value.toInt(),
              vat: sc.discount2.value.toInt(),
              discount: sc.discount1.value.toInt(),
              productList: sc.cart,
              transaction: transactionss,
            ));
      }
    }
  }
  testWork(){
    print("hlw hishabee");
  }
  ediQuickSell() async {
    print("why man");
    final SellController sc = Get.find();
    formKey.currentState.save();
    var uuid = Uuid();
    String tUniqueId = shop.value.id.toString() +
        uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString();
    String uniqueId = shop.value.id.toString() +
        uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString();
    String funiqueId = uniqueId.replaceAll("'", "");
    String sellUniqueId = uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString() +
        shop.value.id.toString();
    String fSellUniqueId = sellUniqueId.replaceAll("'", "");
    QuickSellRequest quickSellRequest = QuickSellRequest(
      createdAt: DateTime.now().toString(),
      shopId: shop.value.id,
      details: '',
      price: totalPrice.value,
      version: 0,
      uniqueId: funiqueId,
      transactionUniqueId: fSellUniqueId,
      updatedAt: DateTime.now().toString(),
      profit: 0,
    );
    AddTransactionRequest transactionss = AddTransactionRequest(
      shopId: shop.value.id,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      version: 0,
      changeAmount: 0.toString(),
      message: '',
      paymentMethod: 1,
      note: note.value,
      smsCount: 0,
      totalItem: cart.length,
      totalProfit: 0.toString(),
      totalPrice: totalPrice.value.toString(),
      totalVat: vat,
      transactionBarcode: '',
      receivedAmount: totalPrice.value.toString(),
      totalDiscount: totalDiscount,
      customerName: selectedCustomer.value.name,
      customerMobile: selectedCustomer.value.mobile,
      customerAddress: selectedCustomer.value.address,
      uniqueId: tUniqueId,
      transaction_type: "PRODUCT_SELL",
    );
    final response = await transactionRepository.quickSell(quickSellRequest);
    print("${response.code}");
    if (response.code == 200) {
      print("yo bro unqID is ++++++++++ $tUniqueId");
      addTransactionItemsRequest(
          id: shop.value.id, uniqueID: tUniqueId, discount: totalDiscount);
      // addTransactionItems(id: shop.value.id, uniqueID: tUniqueId);
      final response =
      await transactionRepository.addTransaction(transactionss);
      //final responseTrns = await transactionRepository.getAllTransaction();
      if (response.code == 200) {
        formKey.currentState.reset();
        //  Get.find<SellController>().clearCart();
        final SellController sc = Get.find();
        Get.find<ShopFeaturesController>().initData();
        Get.to(() =>  Get.to(TransactionPage(),
            binding: TransactionsBinding()));

      }
    }
  }
}
