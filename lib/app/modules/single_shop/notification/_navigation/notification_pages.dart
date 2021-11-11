import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/_binding/notification_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/presentation/pages/notification_page.dart';

import 'notification_routes.dart';

abstract class NotificationPages {
  static List<GetPage> pages = [
    GetPage(
      name: NotificationRoutes.NOTIFICATION,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
  ];
}
