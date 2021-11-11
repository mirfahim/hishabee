import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalTransactionProvider {
  Future<List<Transaction>> getAllTransaction(int shopId);

  Future<void> saveTransaction(int shopId, Transaction transaction);

  Future<void> updateTransaction(int shopId, Transaction transaction);

  Future<void> saveAllTransaction(int shopId, List<Transaction> transactions);

  Future<List<TransactionItem>> getAllTransactionItem(int shopId);

  Future<void> saveTransactionItem(int shopId, TransactionItem transactionItem);

  Future<void> updateTransactionItem(
      int shopId, TransactionItem transactionItem);

  Future<void> saveAllTransactionItem(
      int shopId, List<TransactionItem> transactionItems);

  Future<void> clear();
}

class LocalTransactionProvider implements ILocalTransactionProvider {
  final String boxKey = 'transactionBox';
  final String transactionKey = 'transaction';
  final String transactionItemKey = 'transactionItem';

  @override
  Future<void> clear() async {
    final transactionBox = await Hive.openBox(boxKey);
    return transactionBox.clear();
  }

  @override
  Future<List<Transaction>> getAllTransaction(int shopId) async {
    var list = <Transaction>[];
    final transactionBox = await Hive.openBox(boxKey);

    final str = transactionBox.get(transactionKey + shopId.toString());

    if (str != null) {
      final transactions = transactionResponseModelFromJson(str);
      list.addAll(transactions);
    }
    return list;
  }

  @override
  Future<List<TransactionItem>> getAllTransactionItem(int shopId) async {
    var list = <TransactionItem>[];
    final transactionBox = await Hive.openBox(boxKey);

    final str = transactionBox.get(transactionItemKey + shopId.toString());

    if (str != null) {
      final transactionItems = transactionItemResponseModelFromJson(str);
      list.addAll(transactionItems);
    }
    return list;
  }

  @override
  Future<void> saveAllTransaction(
      int shopId, List<Transaction> transactions) async {
    final transactionBox = await Hive.openBox(boxKey);

    final str = transactionResponseModelToJson(transactions);

    return await transactionBox.put(transactionKey + shopId.toString(), str);
  }

  @override
  Future<void> saveTransaction(int shopId, Transaction transaction) async {
    var transactions = await getAllTransaction(shopId);
    transactions.add(transaction);

    await saveAllTransaction(shopId, transactions);
  }

  @override
  Future<void> updateTransaction(int shopId, Transaction transaction) async {
    var txns = await getAllTransaction(shopId);

    int index = txns.indexWhere((element) => element.id == transaction.id);

    txns[index] = transaction;

    await saveAllTransaction(shopId, txns);
  }

  @override
  Future<void> saveAllTransactionItem(
      int shopId, List<TransactionItem> transactionItems) async {
    final transactionBox = await Hive.openBox(boxKey);

    return await transactionBox.put(transactionItemKey + shopId.toString(),
        transactionItemResponseModelToJson(transactionItems));
  }

  @override
  Future<void> saveTransactionItem(
      int shopId, TransactionItem transactionItem) async {
    var transactionItems = await getAllTransactionItem(shopId);
    transactionItems.add(transactionItem);

    await saveAllTransactionItem(shopId, transactionItems);
  }

  @override
  Future<void> updateTransactionItem(
      int shopId, TransactionItem transactionItem) async {
    var txnItems = await getAllTransactionItem(shopId);

    int index =
        txnItems.indexWhere((element) => element.id == transactionItem.id);

    txnItems[index] = transactionItem;

    await saveAllTransactionItem(shopId, txnItems);
  }
}
