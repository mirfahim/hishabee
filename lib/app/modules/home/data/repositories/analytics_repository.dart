import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/local/data_sources/local_analytics_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/local/models/analytics_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/remote/data_sources/analytics_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/domain/repositories/i_analytics_repository.dart';

class AnalyticsRepository implements IAnalyticsRepository {
  final IAnalyticsProvider _analyticsProvider;
  final ILocalAnalyticsProvider _localAnalyticsProvider;

  AnalyticsRepository(this._analyticsProvider, this._localAnalyticsProvider);

  @override
  Future<GenericResponseModel> addAnalytics(AnalyticsModel analytics) async {
    return _analyticsProvider.addAnalytics(analytics);
  }

  @override
  Future<void> clearAnalytics() {
    return _localAnalyticsProvider.clearAnalytics();
  }

  @override
  Future<List<AnalyticsModel>> getAllAnalytics() {
    return _localAnalyticsProvider.getAllAnalytics();
  }

  @override
  Future<void> saveAnalytics(AnalyticsModel analytics) {
    return _localAnalyticsProvider.saveAnalytics(analytics);
  }
}
