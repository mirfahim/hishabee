import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/_bindings/report_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/pages/report_page.dart';

import 'report_routes.dart';

class ReportPages {
  static List<GetPage> pages = [
    GetPage(
        name: ReportRoutes.REPORT,
        page: () => ReportPage(),
        binding: ReportBinding())
  ];
}
