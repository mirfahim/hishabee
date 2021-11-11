// import 'package:flutter/services.dart';
// import 'package:sslcommerz_flutter/model/SSLCSdkType.dart';
// import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';
// import 'package:sslcommerz_flutter/model/SSLCommerzInitialization.dart';
// import 'package:sslcommerz_flutter/model/SSLCurrencyType.dart';
// import 'package:sslcommerz_flutter/sslcommerz.dart';
//
// abstract class ISSLCommerzPaymentProvider {
//   Future<SSLCTransactionInfoModel> pay({
//     String storeId,
//     String storePasswd,
//     String tranId,
//     double amount,
//   });
// }
//
// class SSLCommerzPaymentProvider implements ISSLCommerzPaymentProvider {
//   @override
//   Future<SSLCTransactionInfoModel> pay({
//     String storeId,
//     String storePasswd,
//     String tranId,
//     double amount,
//   }) async {
//     SSLCTransactionInfoModel transactionInfoModel;
//     try {
//       Sslcommerz sslcommerz = Sslcommerz(
//           initializer: SSLCommerzInitialization(
//         ipn_url: 'www.ipnurl.com',
//         multi_card_name: 'card',
//         currency: SSLCurrencyType.BDT,
//         product_category: 'Subscription',
//         sdkType: SSLCSdkType.TESTBOX,
//         store_id: storeId,
//         store_passwd: storePasswd,
//         total_amount: amount,
//         tran_id: '${DateTime.now().toIso8601String()}', // should be from api
//       ));
//
//       var result = await sslcommerz.payNow();
//
//       if (result is PlatformException) {
//         print("PEEEEEEEEE");
//       } else {
//         transactionInfoModel = result;
//       }
//     } catch (e) {}
//
//     return transactionInfoModel;
//   }
// }
