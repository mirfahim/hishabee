import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/remote/models/notification_response_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalNotificationProvider {
  Future<List<NotificationResponseModel>> getAllNotification(int shopId);

  Future<void> saveAllNotification(
      int shopId, List<NotificationResponseModel> notifications);
}

class LocalNotificationProvider implements ILocalNotificationProvider {
  final String boxKey = 'notificationsBox';
  final String notificationsKey = 'notifications';

  @override
  Future<List<NotificationResponseModel>> getAllNotification(int shopId) async {
    final notificationsBox = await Hive.openBox(boxKey);

    final notifications =
        notificationsBox.get(notificationsKey + shopId.toString());

    if (notifications != null) {
      return notificationResponseModelFromJson(jsonDecode(notifications));
    } else {
      return Future.error("Catch error!");
    }
  }

  @override
  Future<void> saveAllNotification(
      int shopId, List<NotificationResponseModel> notifications) async {
    final notificationsBox = await Hive.openBox(boxKey);
    return await notificationsBox.put(notificationsKey + shopId.toString(),
        notificationResponseModelToJson(notifications));
  }
}
