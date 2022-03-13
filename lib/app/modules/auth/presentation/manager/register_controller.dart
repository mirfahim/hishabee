import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_bindings/auth_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/verify_otp_page.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class RegisterController extends GetxController {
  final IAuthRepository authRepository;

  final brandName = ''.obs;
  final mobileNumber = ''.obs;
  final pin = ''.obs;
  final pinConfirmation = ''.obs;
  final termsAgreed = false.obs;
  final address = ''.obs;
  String token;
  RegisterController(this.authRepository);

  @override
  void onInit() async {
    await AnalyticsService.sendAnalytics(event: AnalyticsEvent.signupStarted);
    await AnalyticsService.sendAnalytics(event: AnalyticsEvent.regStarted);
    super.onInit();
  }

  Future<void> register() async {
    CustomDialog.showLoadingDialog(message: "Registering");
    final response = await authRepository.register(
      brandName: brandName.value,
      mobileNumber: mobileNumber.value,
      pin: pin.value,
      pinConfirmation: pinConfirmation.value,
      address: address.value,
      fcmToken: token,
    );
    print('from registration controller ${response.code}');
    CustomDialog.hideDialog();
    if (response.code == 200) {
      await AnalyticsService.sendAnalytics(
          event: AnalyticsEvent.signupCompleted);
      Get.to(
              () => VerifyOtpPage(
            mobileNo: mobileNumber.value,
          ),
          binding: AuthBinding());
    } else {
      // CustomDialog.showStringDialog(response.message);
      Utils.showToast(response.message);
    }
    try {
       token = await FirebaseMessaging.instance.getToken();

      final response = await authRepository.register(
        brandName: brandName.value,
        mobileNumber: mobileNumber.value,
        pin: pin.value,
        pinConfirmation: pinConfirmation.value,
        address: address.value,
        // fcmToken: token,
      );
      print('from registration controller ${response.code}');
      CustomDialog.hideDialog();
      if (response.code == 200) {
        await AnalyticsService.sendAnalytics(
            event: AnalyticsEvent.signupCompleted);
        Get.to(
            () => VerifyOtpPage(
                  mobileNo: mobileNumber.value,
                ),
            binding: AuthBinding());
      } else {
        // CustomDialog.showStringDialog(response.message);
        Utils.showToast(response.message);
      }
    } catch (e) {
      // CustomDialog.showStringDialog(e);
      Utils.showToast(e);
    }
  }
}
