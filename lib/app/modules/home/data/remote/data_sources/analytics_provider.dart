import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/local/models/analytics_model.dart';

abstract class IAnalyticsProvider {
  Future<GenericResponseModel> addAnalytics(AnalyticsModel analytics);
}

class AnalyticsProvider extends GetConnect implements IAnalyticsProvider {
  final IAuthRepository authRepository;
  AnalyticsProvider(this.authRepository);

  @override
  Future<GenericResponseModel> addAnalytics(AnalyticsModel analytics) async {
    final url =
        "$BASE_URL/analytics/add?shop_id=${analytics.shopId}&event=${analytics.event}&app_platform=${analytics.platform}";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await post<GenericResponseModel>(url, {},
        headers: headers, decoder: genericResponseModelFromRawJson);
    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return response.body;
  }
}
