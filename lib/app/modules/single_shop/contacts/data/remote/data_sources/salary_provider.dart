import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/salary_response_model.dart';

abstract class ISalaryProvider {
  Future<Response<List<SalaryResponseModel>>> getAllSalary({int shopId});
}

class SalaryProvider extends GetConnect implements ISalaryProvider {
  final IAuthRepository authRepository;

  SalaryProvider(this.authRepository);

  @override
  Future<Response<List<SalaryResponseModel>>> getAllSalary({int shopId}) async {
    final url = "$BASE_URL/salary/all?shop_id=$shopId";

    final creds = await authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(url, headers: headers, decoder: salaryResponseModelFromJson);
  }
}
