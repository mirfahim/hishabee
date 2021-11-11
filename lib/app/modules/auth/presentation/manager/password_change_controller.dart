import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_bindings/auth_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/login_page.dart';

class PasswordChangeController extends GetxController {
  final IAuthRepository authRepository;

  PasswordChangeController(this.authRepository);

  final mobileNumber = ''.obs;
  final code = ''.obs;
  final pin = ''.obs;
  final confirmPin = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  getArguments() {
    mobileNumber.value = Get.arguments["mobileNumber"];
    code.value = Get.arguments["code"];
  }

  changePassword() async {
    getArguments();
    if (pin.value.isBlank) {
      CustomDialog.showStringDialog("Please enter a valid pin!");
      return;
    }
    if (pin.value != confirmPin.value) {
      CustomDialog.showStringDialog("Pin doesn't match!");
      return;
    }
    CustomDialog.showLoadingDialog(message: "Please Wait");
    final response = await authRepository.forgetPasswordResetPin(
        mobileNumber.value, code.value, pin.value);

    CustomDialog.hideDialog();
    CustomDialog.showStringDialog(response.message);

    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(() => LoginPage(), binding: AuthBinding());
    });
  }
}
