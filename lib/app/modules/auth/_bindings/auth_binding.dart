import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/forgot_password_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/login_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/password_change_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/register_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/forget_password_verify_otp_controller.dart';

class AuthBinding extends Bindings {
  final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(find()));

    Get.lazyPut(() => LoginController(find()));

    Get.lazyPut(() => VerifyForgetPasswordOtpController(find()));
    Get.lazyPut(() => PasswordChangeController(find()));
    Get.lazyPut(() => ForgotPasswordController(find()));
  }
}
