import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/expense_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/request/salary_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/response/salary_response.dart';

abstract class IExpenseRepository {
  Future<List<ExpenseResponseModel>> getAllExpense({
    int userId,
    int shopId,
  });
  Future<GenericResponseModel> addExpense(
      ExpenseResponseModel expense, String type);

  Future<PaySalaryResponse> addNewSalary(PaySalaryRequest salaryRequest);
}
