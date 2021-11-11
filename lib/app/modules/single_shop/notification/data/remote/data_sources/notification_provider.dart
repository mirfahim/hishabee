import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/remote/models/notification_response_model.dart';

abstract class INotificationProvider {
  Future<Response<List<NotificationResponseModel>>> getAllNotification(
      {int shopId});

  Future<Response<GenericResponseModel>> deleteNotification({int id});

  Future<Response<GenericResponseModel>> addNotification({
    int shopId,
    String title,
    String details,
    String event,
  });
}

class NotificationProvider extends GetConnect implements INotificationProvider {
  final IAuthRepository authRepository;

  NotificationProvider(this.authRepository);

  @override
  Future<Response<GenericResponseModel>> addNotification(
      {int shopId, String title, String details, String event}) async {
    String url =
        "$BASE_URL/notification/add?shop_id={{shop_id}}&title=$title&details=$details&event=$event";

    final creds = await authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: genericResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<GenericResponseModel>> deleteNotification({int id}) async {
    String url = "$BASE_URL/notification/delete?id=$id";

    final creds = await authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: genericResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<List<NotificationResponseModel>>> getAllNotification(
      {int shopId}) async {
    String url = "$BASE_URL/notification/all?shop_id=$shopId";

    final creds = await authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: notificationResponseModelFromRawJson,
    );
  }
}
