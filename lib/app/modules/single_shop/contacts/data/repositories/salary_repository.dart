import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/local/data_sources/local_salary_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/data_sources/salary_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/salary_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_salary_repository.dart';

class SalaryRepository implements ISalaryRepository {
  final ISalaryProvider salaryProvider;
  final ILocalSalaryProvider localSalaryProvider;
  final INetworkInfo networkInfo;

  SalaryRepository(
      this.salaryProvider, this.localSalaryProvider, this.networkInfo);

  @override
  Future<List<SalaryResponseModel>> getAllSalary({int shopId}) async {
    if (await networkInfo.isConnected()) {
      final response = await salaryProvider.getAllSalary(shopId: shopId);
      if (response.hasError) {
        return Future.error(response.statusText);
      }
      localSalaryProvider.saveAllSalary(shopId, response.body);
      return response.body;
    } else {
      try {
        final result = await localSalaryProvider.getAllSalary(shopId);
        return result;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<void> clearDatabase() async {
    return await localSalaryProvider.clearDatabase();
  }
}
