import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_exchange_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_response_model.dart';

abstract class ITransactionProvider {
  Future<Response> addTransaction(Transaction transaction);

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
  Future<Response> addTransaction(Transaction transaction) async {
    String url = '$BASE_URL/transaction/add';

    final creds = await authRepository.getCredentials();

    final body = {
      "user_id": transaction.userId,
      "shop_id": transaction.shopId,
      "time": transaction.time.toIso8601String(),
      "total_price": transaction.totalPrice,
      "total_discount": transaction.totalDiscount,
      "total_item": transaction.totalItem,
      "payment_method": transaction.paymentMethod,
      "received_amount": transaction.receivedAmount,
      "change_amount": transaction.changeAmount,
      "customer_name": transaction.customerName,
      "customer_address": transaction.customerAddress,
      "customer_mobile": transaction.customerMobile,
      "transaction_barcode": transaction.transactionBarcode,
      "transaction_items":
          transactionItemResponseModelToJson(transaction.transactionItems),
      "total_vat": transaction.totalVat,
    };
    // final body = transaction.toJson();

    return post(
      url,
      body,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
    );
  }

  @override
  Future<Response<TransactionResponse>> getAllTransaction({int shopId}) async {
    String url = '$BASE_URL/transaction/all?shop_id=$shopId';

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
}
