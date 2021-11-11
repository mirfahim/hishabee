import 'package:hishabee_business_manager_fl/app/modules/home/data/local/models/analytics_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalAnalyticsProvider {
  Future<List<AnalyticsModel>> getAllAnalytics();

  Future<void> saveAnalytics(AnalyticsModel analytics);

  Future<void> clearAnalytics();
}

class LocalAnalyticsProvider implements ILocalAnalyticsProvider {
  final String boxKey = 'analyticsBox';
  final String analyticsKey = 'analytics';

  @override
  Future<void> clearAnalytics() async {
    final analyticsBox = await Hive.openBox(boxKey);

    return await analyticsBox.clear();
  }

  @override
  Future<List<AnalyticsModel>> getAllAnalytics() async {
    List<AnalyticsModel> analytics = [];

    final analyticsBox = await Hive.openBox(boxKey);

    final result = analyticsBox.get(analyticsKey);

    if (result != null) {
      analytics = analyticsModelFromJson(result);
    }
    return analytics;
  }

  @override
  Future<void> saveAnalytics(AnalyticsModel analytics) async {
    final analyticsBox = await Hive.openBox(boxKey);

    final list = await getAllAnalytics();

    list.add(analytics);

    return analyticsBox.put(analyticsKey, analyticsModelToJson(list));
  }
}
