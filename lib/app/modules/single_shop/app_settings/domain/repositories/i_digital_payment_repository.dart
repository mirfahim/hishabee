import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_digital_payment_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/digital_payment_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';

abstract class IDigitalPaymentRepository {
  Future<UpdateDigitalPaymentDueResponseModel> updateDueDigitalPayment({
    int shopId,
    int customerId,
    String customerName,
    String mobileNumber,
    String address,
    num amount,
  });

  Future<DigitalPaymentResponseModel> exchangeDigitalPayment({
    int shopId,
    int transactionId,
    int totalItem,
    num totalPrice,
    num totalVat,
    num exchange,
    num refund,
    int paymentMethod,
  });

  Future<DigitalPaymentResponseModel> digitalPayment({
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
