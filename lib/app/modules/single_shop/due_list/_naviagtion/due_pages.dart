import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_pages/add_new_due.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/due_details_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/due_item_details.dart';

import '../../../../../new_UI/due/due_front.dart';
import 'due_page_routes.dart';


abstract class DuePages {
  static List<GetPage> pages = [
    GetPage(
      name: DuePageRoutes.DUE_PAGE,
      page: () => DueFront(),
      binding: DueListBinding(),
    ),
    GetPage(
      name: DuePageRoutes.ADD_DUE_PAGE,
      page: () => DueNew(),
      binding: DueListBinding(),
    ),
    GetPage(
      name: DuePageRoutes.DUE_DETAILS_PAGE,
      page: () => DueDetailsPage(),
      binding: DueListBinding(),
    ),
    GetPage(
      name: DuePageRoutes.DUE_ITEM_DETAILS_PAGE,
      page: () => DueItemDetails(),
      binding: DueListBinding(),
    ),
  ];
}
