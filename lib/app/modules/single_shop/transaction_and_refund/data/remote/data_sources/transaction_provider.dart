import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/quick_sell_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/quick_sell_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_exchange_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_response_model.dart';

abstract class ITransactionProvider {
  Future<Response<AddTransactionResponse>> addTransaction(AddTransactionRequest transaction);
  Future<Response<QuickSellResponse>> quickSell(QuickSellRequest transaction);

  Future<Response<TransactionResponse>> getAllTransaction({int shopId});

  Future<Response<List<TransactionItem>>> getAllTransactionItem({int shopId});

  Future<Response<TransactionExchangeResponseModel>> transactionExchange({
    int shopId,
    int transactionId,
    int totalItem,
    double totalPrice,
    double totalVat,
    List<TransactionItem> exchange,
    List<TransactionItem> refund,
  });
}

class TransactionProvider extends GetConnect implements ITransactionProvider {
  final IAuthRepository authRepository;

  TransactionProvider(this.authRepository);

  @override
  Future<Response<AddTransactionResponse>> addTransaction(AddTransactionRequest transaction) async {
    String url = '$BASE_URL/transaction/?shop_id=${transaction.shopId}&created_at='
        '${DateTime.now().toString()}&updated_at=${DateTime.now().toString()}&total_price='
        '${transaction.totalPrice}&total_discount=${transaction.totalDiscount}&total_item='
        '${transaction.totalItem}&payment_method=${transaction.paymentMethod}'
        '&received_amount=${transaction.totalPrice}&change_amount='
        '${transaction.changeAmount}&customer_name=${transaction.customerName}'
        '&customer_address=${transaction.customerAddress}&customer_mobile='
        '${transaction.customerMobile}&employee_name=${transaction.employeeName}'
        '&employee_mobile=${transaction.employeeMobile}&'
        'transaction_barcode=${transaction.transactionBarcode}&total_vat='
        '${transaction.totalVat}&note=${transaction.note}&total_profit='
        '${transaction.totalProfit}&unique_id=${transaction.uniqueId}&message='
        '${transaction.message}&sms_count=${transaction.smsCount}&version='
        '${transaction.version}&transaction_type=${transaction.transaction_type}';
    final creds = await authRepository.getCredentials();
    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: addTransactionResponseFromRawJson,
    );
  }

  @override
  Future<Response<TransactionResponse>> getAllTransaction({int shopId}) async {
    String url = '$BASE_URL/transaction/all?shop_id=$shopId&page=1';

    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: transactionResponseFromRawJson,
    );
  }

  @override
  Future<Response<List<TransactionItem>>> getAllTransactionItem(
      {int shopId}) async {
    String url = '$BASE_URL/transaction/items/all?shop_id=$shopId';

    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: transactionItemResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<TransactionExchangeResponseModel>> transactionExchange(
      {int shopId,
        int transactionId,
        int totalItem,
        double totalPrice,
        double totalVat,
        List<TransactionItem> exchange,
        List<TransactionItem> refund}) async {
    String url =
        "$BASE_URL/transaction/exchange?shop_id=$shopId&transaction_id=$transactionId&total_item=$totalItem&total_price=$totalPrice&total_vat=$totalVat&exchange=${transactionItemResponseModelToJson(exchange)}&refund=${transactionItemResponseModelToJson(refund)}";

    final creds = await authRepository.getCredentials();

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: transactionExchangeResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<QuickSellResponse>> quickSell(
      QuickSellRequest transaction) async {
    String url = '$BASE_URL/quick_sell/?shop_id=${transaction.shopId}&created_at=${transaction.createdAt}&updated_at=${transaction.updatedAt}&price=${transaction.price}&details=${transaction.details}&unique_id=${transaction.uniqueId}&version=${transaction.version}&transaction_unique_id=${transaction.transactionUniqueId}';

    final creds = await authRepository.getCredentials();

    final body = {
      "shop_id": transaction.shopId,
      "price": transaction.price,
      "created_at": transaction.createdAt,
      "updated_at": transaction.updatedAt,
      "image": transaction.image,
      "unique_id": transaction.uniqueId,
      "version": transaction.version,
      "transaction_unique_id": transaction.transactionUniqueId,
      "details": transaction.details,
      //"transaction_id": 0,
    };

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: quickSellResponseFromRawJson,
    );
  }
}
