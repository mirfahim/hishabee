import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/transaction_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transactions_page.dart';

class ExchangePaymentController extends GetxController {
  final ITransactionRepository transactionRepository;

  final paying = false.obs;
  final formKey = GlobalKey<FormState>();
  final transaction = Rxn<Transaction>();
  final shop = Rxn<Shop>();
  final transactionItem = <TransactionItem>[].obs;
  final transactionOldItem = <TransactionItem>[].obs;
  final previousPrice = 0.0.obs;
  final newPrice = 0.0.obs;
  final payAmount = 0.0.obs;
  final getAmount = 0.0.obs;
  final takeAmount = 0.0.obs;
  final time = DateTime.now();

  ExchangePaymentController(this.transactionRepository);

  @override
  void onInit() {
    getArguments();
    calculateNewPrice(transactionItem);
    payOrGet();

    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
    transaction.value = Get.arguments["transaction"];
    previousPrice.value = Get.arguments["previousPrice"];
    transactionItem.assignAll(Get.arguments["transactionItem"]);
    transactionOldItem.assignAll(Get.arguments["transactionOldItem"]);
  }

  calculateNewPrice(List<TransactionItem> transactions) {
    var temp = 0.0;
    transactions.forEach((element) {
      temp += element.price;
    });
    newPrice.value = temp;
    print("new Price ${newPrice.value}");
  }

  payOrGet() {
    if (newPrice.value == previousPrice.value) {
      getAmount.value = 0.0;
      payAmount.value = 0.0;
    } else if (newPrice.value > previousPrice.value) {
      getAmount.value = newPrice.value - previousPrice.value;
    } else if (newPrice.value < previousPrice.value) {
      payAmount.value = previousPrice.value - newPrice.value;
    }
  }

  Future<void> exchangeOrRefund() async {
    final txn = transaction.value.copyWith(
      time: time,
      receivedAmount: takeAmount.value,
      totalItem: transactionItem.length,
    );

    // final transaction = Transaction(shopId: shop.value.id,
    //     userId: transation.value.userId,
    //     time: time,
    //     customerAddress: transation.value.customerAddress,
    //     customerMobile: transation.value.customerMobile,
    //     customerName: transation.value.customerName,
    //     receivedAmount: takeAmount.value,
    //     totalItem: transactionItem.length,
    //     transactionItems: transactionItem,
    //     transactionBarcode: transation.value.transactionBarcode,
    //     paymentMethod: transation.value.paymentMethod,
    //     totalDiscount: transation.value.totalDiscount,
    //     totalVat: transation.value.totalVat,
    //     //changeAmount:
    //     //totalPrice:)
    //     final result = await transactionRepository.addTransaction(
    //
    // );

    try {
      CustomDialog.showLoadingDialog();
      final result =
          await transactionRepository.addTransaction(shop.value.id, txn);
      CustomDialog.hideDialog();

      CustomDialog.showStringDialog("Transaction added successfully");
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }
  }

  confirm() async {
    CustomDialog.showLoadingDialog(message: "Transaction updating");
    final response = await transactionRepository.transactionExchange(
        shopId: shop.value.id,
        totalItem: transactionItem.length,
        totalPrice: getAmount.value,
        transactionId: transaction.value.id,
        exchange: transactionItem,
        refund: transactionOldItem,
        totalVat: transaction.value.totalVat);
    CustomDialog.hideDialog();

    if (response.code == 200) {
      final TransactionController transactionController = Get.find();
      transactionController.getAllTransaction();
      Get.off(() => TransactionPage(),
          arguments: {
            "shop": shop.value,
          },
          binding: TransactionsBinding());
    } else {
      CustomDialog.showStringDialog(response.message);
    }
  }
}
