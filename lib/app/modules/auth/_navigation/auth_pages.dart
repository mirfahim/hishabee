import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_bindings/auth_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/forgot_password_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/login_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/register_page.dart';

import 'auth_routes.dart';

abstract class AuthPages {
  static List<GetPage> pages = [
    GetPage(
      name: AuthRoutes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AuthRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AuthRoutes.FORGETPASS,
      page: () => ForgotPasswordPage(),
      binding: AuthBinding(),
    ),
  ];
}
