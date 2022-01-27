import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/quick_sell_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/quick_sell_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_exchange_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_response_model.dart';

abstract class ITransactionRepository {
  Future<AddTransactionResponse> addTransaction(AddTransactionRequest transaction);
  Future<QuickSellResponse> quickSell(QuickSellRequest quickSellRequest);
  Future<TransactionResponse> getAllTransaction({int shopId});

  Future<List<TransactionItem>> getAllTransactionItem({int shopId});

  Future<TransactionExchangeResponseModel> transactionExchange({
    int shopId,
    int transactionId,
    int totalItem,
    double totalPrice,
    double totalVat,
    List<TransactionItem> exchange,
    List<TransactionItem> refund,
  });
}
