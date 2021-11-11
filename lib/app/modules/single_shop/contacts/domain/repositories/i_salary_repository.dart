import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/salary_response_model.dart';

abstract class ISalaryRepository {
  Future<List<SalaryResponseModel>> getAllSalary({int shopId});
  Future<void> clearDatabase();
}
