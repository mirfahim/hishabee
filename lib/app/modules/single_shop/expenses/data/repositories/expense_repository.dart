import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/local/data_sources/local_expense_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/data_sources/expense_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/expense_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/request/salary_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/response/salary_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/domain/repositories/i_expense_repository.dart';

class ExpenseRepository implements IExpenseRepository {
  final INetworkInfo networkInfo;
  final IExpenseProvider expenseProvider;
  final ILocalExpenseProvider localExpenseProvider;

  ExpenseRepository(
      this.networkInfo, this.expenseProvider, this.localExpenseProvider);

  @override
  Future<GenericResponseModel> addExpense(
      ExpenseResponseModel expense, String type) async {
    final response = await expenseProvider.addExpense(expense, type);
    return response.body;

    // await localExpenseProvider.save(expense, expense.shopId);
  }

  @override
  Future<List<ExpenseResponseModel>> getAllExpense(
      {int userId, int shopId}) async {
    final localData = await localExpenseProvider.getAll(shopId);

    if (await networkInfo.isConnected()) {
      try {
        final response = await expenseProvider.getAllExpense(shopId: shopId);

        if (response.hasError) {
          return Future.error(response.statusText);
        }
        if (localData.isEmpty) {
          await localExpenseProvider.saveAll(response.body, shopId);
        }
        if (localData.length < response.body.length) {
          await localExpenseProvider.saveAll(response.body, shopId);
        }
        response.body.forEach((r) async {
          localData.forEach((l) async {
            if (l.id == r.id) {
              if (l.amount != r.amount) {
                await localExpenseProvider.update(r, shopId);
              }
            }
          });
        });
      } catch (e) {
        print("Ex: ${e.toString()}");
      }
    }

    return await localExpenseProvider.getAll(shopId);
  }

  @override
  Future<PaySalaryResponse> addNewSalary(PaySalaryRequest salaryRequest) async {
    final response = await expenseProvider.addNewSalary(salaryRequest);
    return response.body;
  }
}
