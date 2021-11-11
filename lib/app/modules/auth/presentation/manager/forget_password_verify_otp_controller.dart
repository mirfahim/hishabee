import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_bindings/auth_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/password_change_page.dart';

class VerifyForgetPasswordOtpController extends GetxController {
  final IAuthRepository authRepository;

  VerifyForgetPasswordOtpController(this.authRepository);

  final mobileNumber = ''.obs;
  final code = ''.obs;

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  getArguments() {
    mobileNumber.value = Get.arguments["mobileNumber"];
  }

  verifyOtp(String val) async {
    if (code.value.length < 6) {
      code.value += val;
    }
    if (code.value.length == 6) {
      final response = await authRepository.verifyForgetPasswordOtp(
          mobileNumber.value, code.value, VerificationType.manual);

      if (response.code == 200) {
        Get.to(() => PasswordChangePage(), binding: AuthBinding(), arguments: {
          "mobileNumber": mobileNumber.value,
          "code": code.value,
        });
      } else {
        CustomDialog.showStringDialog(response.message);
      }
    }
  }

  reSendOtp() async {
    CustomDialog.showLoadingDialog(message: "Resending Code");
    if (mobileNumber.value.isNotEmpty) {
      final response =
          await authRepository.sendForgetPasswordOtp(mobileNumber.value);
      Get.back();
    }
  }

  /*verifyAutoOtp() async {
    final response = await authRepository.verifyForgetPasswordOtp(
        mobileNumber.value, code.value, VerificationType.manual);

    if (response.code == 200) {
      Get.to(() => PasswordChangePage(), binding: AuthBinding(), arguments: {
        "mobileNumber": mobileNumber.value,
        "code": code.value,
      });
    }
  }*/
}
