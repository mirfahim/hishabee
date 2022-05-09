import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_digital_payment_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/digital_payment_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';

abstract class IDigitalPaymentProvider {
  Future<Response<UpdateDigitalPaymentDueResponseModel>>
      updateDueDigitalPayment({
    int shopId,
    int customerId,
    String customerName,
    String mobileNumber,
    String address,
    num amount,
  });

  Future<Response<DigitalPaymentResponseModel>> exchangeDigitalPayment({
    int shopId,
    int transactionId,
    int totalItem,
    num totalPrice,
    num totalVat,
    num exchange,
    num refund,
    int paymentMethod,
  });

  Future<Response<DigitalPaymentResponseModel>> digitalPayment({
    int shopId,
    String time,
    num totalPrice,
    num totalDiscount,
    int totalItem,
    int paymentMethod,
    num receivedAmount,
    num changeAmount,
    String customerName,
    String customerAddress,
    String customerMobile,
    String employeeName,
    String employeeMobile,
    int employeeId,
    String transactionBarcode,
    List<TransactionItem> transactionItems,
    num totalVat,
    String note,
  });
}

class DigitalPaymentProvider extends GetConnect
    implements IDigitalPaymentProvider {
  final IAuthRepository authRepository;

  DigitalPaymentProvider(this.authRepository);

  @override
  Future<Response<DigitalPaymentResponseModel>> digitalPayment({
    int shopId,
    String time,
    num totalPrice,
    num totalDiscount,
    int totalItem,
    int paymentMethod,
    num receivedAmount,
    num changeAmount,
    String customerName,
    String customerAddress,
    String customerMobile,
    String employeeName,
    String employeeMobile,
    int employeeId,
    String transactionBarcode,
    List<TransactionItem> transactionItems,
    num totalVat,
    String note,
  }) async {
    String url = '$BASE_URL/digital_payment/transaction';

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};
    final body = {
      "shop_id": shopId,
      "time": time,
      "total_price": totalPrice,
      "total_discount": totalDiscount,
      "total_item": totalItem,
      "payment_method": paymentMethod,
      "received_amount": receivedAmount,
      "change_amount": changeAmount,
      "customerName": customerName,
      "customer_address": customerAddress,
      "customer_mobile": customerMobile,
      "employee_name": employeeName,
      "employee_mobile": employeeMobile,
      "employee_id": employeeId,
      "transaction_barcode": transactionBarcode,
      "transaction_items": transactionItemResponseModelToJson(transactionItems),
      "total_vat": totalVat,
      "note": note
    };

    return post(
      url,
      body,
      headers: headers,
      decoder: digitalPaymentResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<DigitalPaymentResponseModel>> exchangeDigitalPayment({
    int shopId,
    int transactionId,
    int totalItem,
    num totalPrice,
    num totalVat,
    num exchange,
    num refund,
    int paymentMethod,
  }) async {
    String url =
        '$BASE_URL/digital_payment/exchange?shop_id=$shopId&transaction_id=$transactionId&total_item=$totalItem&total_price=$totalPrice&total_vat=$totalVat&exchange=$exchange&refund=$refund&payment_method=$paymentMethod';

    final creds = await authRepository.getCredentials();

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: digitalPaymentResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<UpdateDigitalPaymentDueResponseModel>>
      updateDueDigitalPayment({
    int shopId,
    int customerId,
    String customerName,
    String mobileNumber,
    String address,
    num amount,
  }) async {
    String url =
        '$BASE_URL/digital_payment/custom?shop_id=15&name=test&mobile=012&amount=50';

    final creds = await authRepository.getCredentials();

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: updateDigitalPaymentDueResponseModelFromRawJson,
    );
  }
}
