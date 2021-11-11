import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/local/data_sources/local_notification_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/remote/data_sources/notification_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/data/repositories/notification_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/domain/repositories/i_notification_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/presentation/manager/notification_controller.dart';

class NotificationBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<INotificationProvider>(() => NotificationProvider(find()));
    Get.lazyPut<ILocalNotificationProvider>(() => LocalNotificationProvider());
    Get.lazyPut<INotificationRepository>(
        () => NotificationRepository(find(), find(), find()));
    Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()));
    Get.lazyPut(() => NotificationController(find(), find()));
  }
}
