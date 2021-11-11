import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/expense_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalExpenseProvider {
  Future<List<ExpenseResponseModel>> getAll(int shopId);

  Future<void> save(ExpenseResponseModel expense, int shopId);

  Future<void> saveAll(List<ExpenseResponseModel> expenseList, int shopId);

  Future<void> update(ExpenseResponseModel expense, int shopId);

  Future<void> clear();
}

class LocalExpenseProvider implements ILocalExpenseProvider {
  final String boxKey = 'expenseBox';
  final String expenseKey = 'expense';

  @override
  Future<void> clear() async {
    final expenseBox = await Hive.openBox(boxKey);
    return expenseBox.clear();
  }

  @override
  Future<List<ExpenseResponseModel>> getAll(int shopId) async {
    var list = <ExpenseResponseModel>[];
    final expenseBox = await Hive.openBox(boxKey);

    final str = expenseBox.get(expenseKey + shopId.toString());

    if (str != null) {
      final expenses = expenseResponseModelFromJson(str);
      list.addAll(expenses);
    }
    return list;
  }

  @override
  Future<void> save(ExpenseResponseModel expense, int shopId) async {
    var expenses = await getAll(shopId);
    expenses.add(expense);

    await saveAll(expenses, shopId);
  }

  @override
  Future<void> saveAll(
      List<ExpenseResponseModel> expenseList, int shopId) async {
    final expenseBox = await Hive.openBox(boxKey);

    final str = expenseResponseModelToJson(expenseList);

    return await expenseBox.put(expenseKey + shopId.toString(), str);
  }

  @override
  Future<void> update(ExpenseResponseModel expense, int shopId) async {
    var expenses = await getAll(shopId);

    int index = expenses.indexWhere((element) => element.id == expense.id);

    expenses[index] = expense;

    await saveAll(expenses, shopId);
  }
}
