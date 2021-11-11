import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/digital_payment_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_digital_payment_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/digital_payment_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';

class DigitalPaymentRepository implements IDigitalPaymentRepository {
  final IDigitalPaymentProvider paymentProvider;

  DigitalPaymentRepository(this.paymentProvider);

  @override
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
  }) async {
    final response = await paymentProvider.digitalPayment(
      shopId: shopId,
      time: time,
      totalPrice: totalPrice,
      totalDiscount: totalDiscount,
      totalItem: totalItem,
      paymentMethod: paymentMethod,
      receivedAmount: receivedAmount,
      changeAmount: changeAmount,
      customerName: customerName,
      customerAddress: customerAddress,
      customerMobile: customerMobile,
      employeeName: employeeName,
      employeeMobile: employeeMobile,
      employeeId: employeeId,
      transactionBarcode: transactionBarcode,
      transactionItems: transactionItems,
      totalVat: totalVat,
      note: note,
    );

    return ResponseDecoder.decode(response);
  }

  @override
  Future<DigitalPaymentResponseModel> exchangeDigitalPayment({
    int shopId,
    int transactionId,
    int totalItem,
    num totalPrice,
    num totalVat,
    num exchange,
    num refund,
    int paymentMethod,
  }) async {
    final response = await paymentProvider.exchangeDigitalPayment(
        shopId: shopId,
        transactionId: transactionId,
        totalItem: totalItem,
        totalPrice: totalPrice,
        totalVat: totalVat,
        exchange: exchange,
        refund: refund,
        paymentMethod: paymentMethod);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<UpdateDigitalPaymentDueResponseModel> updateDueDigitalPayment({
    int shopId,
    int customerId,
    String customerName,
    String mobileNumber,
    String address,
    num amount,
  }) async {
    final response = await paymentProvider.updateDueDigitalPayment(
        shopId: shopId,
        customerId: customerId,
        customerName: customerName,
        mobileNumber: mobileNumber,
        address: address,
        amount: amount);

    return ResponseDecoder.decode(response);
  }
}
