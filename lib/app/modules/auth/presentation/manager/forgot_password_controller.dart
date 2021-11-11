import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_bindings/auth_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/forget_password_verify_otp_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/verify_otp_page.dart';

class ForgotPasswordController extends GetxController {
  final IAuthRepository authRepository;

  ForgotPasswordController(this.authRepository);

  final mobileNumber = ''.obs;
  final serverError = ''.obs;
  final resetOTP = GenericResponseModel().obs;

  resetPin() async {
    resetOTP.value =
        await authRepository.resetPin(mobileNumber: mobileNumber.value);
    if (resetOTP.value.code == 200) {
      Get.to(VerifyOtpPage());
    } else {
      Get.to(VerifyOtpPage(
        mobileNo: mobileNumber.value,
      ));
    }
  }

  sendOtp() async {
    CustomDialog.showLoadingDialog(message: "please wait");
    final response =
        await authRepository.sendForgetPasswordOtp(mobileNumber.value);
    Get.back();
    if (response.code == 200) {
      Get.to(
        () => VerifyOtpForForgetPassword(),
        binding: AuthBinding(),
        arguments: {"mobileNumber": mobileNumber.value},
      );
    } else {
      serverError.value = response.message;
    }
  }
}
