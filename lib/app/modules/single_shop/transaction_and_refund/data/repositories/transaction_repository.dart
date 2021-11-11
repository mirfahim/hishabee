import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/local/data_sources/local_transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/data_sources/transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_exchange_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  final ITransactionProvider transactionProvider;
  final ILocalTransactionProvider localTransactionProvider;
  final INetworkInfo networkInfo;

  TransactionRepository(this.transactionProvider, this.localTransactionProvider,
      this.networkInfo);

  // @override
  // Future<void> addTransaction(int shopId, Transaction transaction) async {
  //   // try {
  //   final response = await transactionProvider.addTransaction(transaction);
  //   print("Txn add: ${transaction.time.toIso8601String()}");
  //
  //   return await localTransactionProvider.saveTransaction(shopId, transaction);
  //   // } catch (e) {
  //   //   print("Err: ${e.toString()}");
  //   // }
  //   print("Txn out try add: ${transaction.time.toIso8601String()}");
  //
  //   return await localTransactionProvider.saveTransaction(shopId, transaction);
  // }

  @override
  Future<void> addTransaction(int shopId, Transaction transaction) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await transactionProvider.addTransaction(transaction);

        return response.body;
      } catch (e) {
        return Future.error(e);
      }
    }
    return Future.error("No connection! Please connect to the internet.");
  }

  // @override
  // Future<List<Transaction>> getAllTransaction({int shopId}) async {
  //   final localData = await localTransactionProvider.getAllTransaction(shopId);
  //
  //   if (await networkInfo.isConnected()) {
  //     try {
  //       final response =
  //           await transactionProvider.getAllTransaction(shopId: shopId);
  //
  //       if (localData.isEmpty) {
  //         await localTransactionProvider.saveAllTransaction(
  //             shopId, response.body);
  //       }
  //       if (localData.length < response.body.length) {
  //         await localTransactionProvider.saveAllTransaction(
  //             shopId, response.body);
  //       }
  //       response.body.forEach((r) async {
  //         localData.forEach((l) async {
  //           if (l.id == r.id) {
  //             if (l.localId != r.localId) {
  //               await localTransactionProvider.updateTransaction(shopId, r);
  //             }
  //           }
  //         });
  //       });
  //     } catch (e) {}
  //   }
  //
  //   return await localTransactionProvider.getAllTransaction(shopId);
  // }

  @override
  Future<TransactionResponse> getAllTransaction({int shopId}) async {
    List<Transaction> transaction = [];
    var response;
    if (await networkInfo.isConnected()) {
      try {
        response = await transactionProvider.getAllTransaction(shopId: shopId);
        response.body.data.forEach((element) {
          transaction.add(element);
        });
        await localTransactionProvider.saveAllTransaction(shopId, transaction);
        return response.body;
      } catch (e) {
        return Future.error(e);
      }
    }
    //return null/*await localTransactionProvider.getAllTransaction(shopId)*/;
  }

  @override
  Future<List<TransactionItem>> getAllTransactionItem({int shopId}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response =
            await transactionProvider.getAllTransactionItem(shopId: shopId);
        await localTransactionProvider.saveAllTransactionItem(
            shopId, response.body);
        return response.body;
      } catch (e) {
        return Future.error(e);
      }
    }
    return await localTransactionProvider.getAllTransactionItem(shopId);
  }

  @override
  Future<TransactionExchangeResponseModel> transactionExchange(
      {int shopId,
      int transactionId,
      int totalItem,
      double totalPrice,
      double totalVat,
      List<TransactionItem> exchange,
      List<TransactionItem> refund}) async {
    final response = await transactionProvider.transactionExchange(
        shopId: shopId,
        transactionId: transactionId,
        totalItem: totalItem,
        totalPrice: totalPrice,
        totalVat: totalVat,
        exchange: exchange,
        refund: refund);

    print("TRS : ${response.bodyString}");

    return ResponseDecoder.decode(response);
  }

// @override
// Future<List<TransactionItem>> getAllTransactionItem({int shopId}) async {
//   final localData =
//       await localTransactionProvider.getAllTransactionItem(shopId);
//
//   if (await networkInfo.isConnected()) {
//     try {
//       final response =
//           await transactionProvider.getAllTransactionItem(shopId: shopId);
//       if (localData.isEmpty) {
//         await localTransactionProvider.saveAllTransactionItem(
//             shopId, response.body);
//       }
//       if (localData.length < response.body.length) {
//         await localTransactionProvider.saveAllTransactionItem(
//             shopId, response.body);
//       }
//       response.body.forEach((r) async {
//         localData.forEach((l) async {
//           if (l.id == r.id) {
//             if (l.localId != r.localId) {
//               await localTransactionProvider.updateTransactionItem(shopId, r);
//             }
//           }
//         });
//       });
//     } catch (e) {}
//   }
//
//   return localData;
//
// }
}
