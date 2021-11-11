import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/remote/models/notification_response_model.dart';

abstract class INotificationRepository {
  Future<List<NotificationResponseModel>> getAllNotification({int shopId});

  Future<GenericResponseModel> deleteNotification({int id});

  Future<GenericResponseModel> addNotification({
    int shopId,
    String title,
    String details,
    String event,
  });
}
