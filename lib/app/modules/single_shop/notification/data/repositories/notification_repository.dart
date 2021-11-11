import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/local/data_sources/local_notification_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/remote/data_sources/notification_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/remote/models/notification_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/domain/repositories/i_notification_repository.dart';

class NotificationRepository implements INotificationRepository {
  final INotificationProvider notificationProvider;
  final ILocalNotificationProvider localNotificationProvider;
  final INetworkInfo networkInfo;

  NotificationRepository(this.notificationProvider,
      this.localNotificationProvider, this.networkInfo);

  @override
  Future<GenericResponseModel> addNotification(
      {int shopId, String title, String details, String event}) async {
    final response = await notificationProvider.addNotification(
        shopId: shopId, title: title, details: details, event: event);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> deleteNotification({int id}) async {
    final response = await notificationProvider.deleteNotification(id: id);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<NotificationResponseModel>> getAllNotification(
      {int shopId}) async {
    if (await networkInfo.isConnected()) {
      final response =
          await notificationProvider.getAllNotification(shopId: shopId);

      localNotificationProvider.saveAllNotification(shopId, response.body);

      return ResponseDecoder.decode(response);
    } else {
      try {
        final result =
            await localNotificationProvider.getAllNotification(shopId);
        return result;
      } catch (e) {
        return Future.error(e);
      }
    }
  }
}
