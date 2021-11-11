import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/local/models/analytics_model.dart';

abstract class IAnalyticsRepository {
  Future<GenericResponseModel> addAnalytics(AnalyticsModel analytics);

  Future<List<AnalyticsModel>> getAllAnalytics();

  Future<void> saveAnalytics(AnalyticsModel analytics);

  Future<void> clearAnalytics();
}
