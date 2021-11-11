import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/remote/models/notification_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/domain/repositories/i_notification_repository.dart';

class NotificationController extends GetxController {
  final shop = Rxn<Shop>();
  final creds = Rxn<LoginResponseModel>();
  final notificationList = <NotificationResponseModel>[].obs;

  final INotificationRepository notificationRepository;

  final IAuthRepository authRepository;

  NotificationController(this.notificationRepository, this.authRepository);

  @override
  void onInit() async {
    getArguments();
    await getUser();
    await getNotifications();
    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
  }

  getUser() async {
    creds.value = await authRepository.getCredentials();
  }

  getNotifications() async {
    final result =
        await notificationRepository.getAllNotification(shopId: shop.value.id);
    notificationList.assignAll(result);
  }

  clearAll() async {
    // state.forEach((element)async {
    //    await notificationRepository.deleteNotification(id:element.remoteId);
    //
    // });
  }
}
