import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_binding/contact_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/add_contact_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/contacts_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/edit_contact_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/salary_report_page.dart';

import 'contact_routes.dart';

abstract class ContactPages {
  static List<GetPage> pages = [
    GetPage(
      name: ContactRoutes.CONTACTS,
      page: () => ContactsPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: ContactRoutes.ADD_CONTACT,
      page: () => AddContactPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: ContactRoutes.SALARY_REPORT,
      page: () => SalaryReportPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: ContactRoutes.EDIT_CONTACT,
      page: () => EditContactPage(),
      binding: ContactBinding(),
    ),
  ];
}
