import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/expense_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/request/salary_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/response/salary_response.dart';

abstract class IExpenseProvider {
  Future<Response<List<ExpenseResponseModel>>> getAllExpense({
    int userId,
    int shopId,
  });

  Future<Response<GenericResponseModel>> addExpense(
      ExpenseResponseModel expense, String type);

  Future<Response<PaySalaryResponse>> addNewSalary(
      PaySalaryRequest salaryRequest);
}

class ExpenseProvider extends GetConnect implements IExpenseProvider {
  final IAuthRepository authRepository;

  ExpenseProvider(this.authRepository);

  @override
  Future<Response<List<ExpenseResponseModel>>> getAllExpense({
    int userId,
    int shopId,
  }) async {
    String url = "$BASE_URL/expense/all?user_id=$userId&shop_id=$shopId";

    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: expenseResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<GenericResponseModel>> addExpense(
      ExpenseResponseModel expense, String type) async {
    String url =
        "$BASE_URL/expense/add?shop_id=${expense.shopId}&type=$type&purpose=${expense.purpose}&details=${expense.details}&amount=${expense.amount}";
    final creds = await authRepository.getCredentials();

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: genericResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<PaySalaryResponse>> addNewSalary(
      PaySalaryRequest salaryRequest) async {
    String url =
        "$BASE_URL/salary/add?shop_id=${salaryRequest.shopId}&type=Salary&purpose=Salary&details=${salaryRequest.details}&amount=${salaryRequest.amount}&time=${salaryRequest.time}&employee_id=${salaryRequest.employeeId}";

    final creds = await authRepository.getCredentials();

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: paySalaryResponseFromRawJson,
    );
  }
}
