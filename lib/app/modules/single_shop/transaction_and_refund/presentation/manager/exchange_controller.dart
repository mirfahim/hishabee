import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/new_transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class ExchangeController extends GetxController {
  final transactionItemList = <TransactionItem>[].obs;
  final transactionItemOldList = <TransactionItem>[].obs;
  final transaction = Rxn<Transactions>();
  final shop = Rxn<Shop>();
  final transactionItem = Rxn<TransactionItem>();
  final totalPrice = 0.0.obs;
  final beforeTotalPrice = 0.0.obs;

  final ITransactionRepository _transactionRepository;

  ExchangeController(this._transactionRepository);

  @override
  void onInit() {
    getArguments();
    //initData();
    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
    transaction.value = Get.arguments["transaction"];
  }

  initData() {
    transactionItemList.assignAll(transaction.value.transactionItems);
    transactionItemOldList.assignAll(transaction.value.transactionItems);
    totalPrice.value = transaction.value.totalPrice;
    if (beforeTotalPrice.value == 0.0) {
      beforeTotalPrice.value = totalPrice.value;
    }
    if (totalPrice.value > beforeTotalPrice.value) {
      totalPrice.value = totalPrice.value - beforeTotalPrice.value;
      print("Grater Called");
    } else if (totalPrice.value < beforeTotalPrice.value) {
      totalPrice.value = beforeTotalPrice.value - totalPrice.value;
      print("Grater Called");
    } else if (totalPrice.value == beforeTotalPrice.value) {
      print("Equal Called");
      totalPrice.value = 0.0;
    }
  }

  Future<dynamic> getALlTransactionItemByUniqueID({
    String uniqueID,
  }) async {
    String url = "/transaction/items?unique_id=$uniqueID";
    ApiService _apiService = ApiService();
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  removeItem(TransactionItem item) {
    transactionItemList.removeWhere((element) => element.id == item.id);
    transactionItem.value = item;
    totalPrice.value = totalPrice.value - item.price;
  }

  addItemToCartAgain() {
    transactionItemList.add(transactionItem.value);
    totalPrice.value = totalPrice.value + transactionItem.value.price;
  }
}
