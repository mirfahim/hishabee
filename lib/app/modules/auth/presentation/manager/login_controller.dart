import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_navigation/shop_main_routes.dart';

class LoginController extends GetxController {
  final mobileNumber = ''.obs;
  final pin = ''.obs;
  final hidePassword = true.obs;
  final loginResponse = Rxn<LoginResponseModel>();
  final storage = GetStorage();
  final IAuthRepository authRepository;

  LoginController(this.authRepository);

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getCredentials();
  }

  void login() async {
    if (mobileNumber.value.length < 11 || pin.value.length < 5) {
      CustomDialog.showStringDialog(
          "Please provide a valid phone number and pin");
    } else {
      CustomDialog.showLoadingDialog(message: "Signing In");
      try {
        // String token = await FirebaseMessaging.instance.getToken();

        final response = await authRepository.login(
          mobileNumber: mobileNumber.value,
          pin: pin.value,
          // fcmToken: token,
        );

        if (Get.isDialogOpen) {
          Get.back();
        }
        if (response.accessToken != null) {
          // await AnalyticsService.sendAnalyticsToServer(
          //     event: AnalyticsEvent.login);
          storage.write("token", response.accessToken);
          Get.offAllNamed(ShopMainRoutes.SELECT_SHOP);
        }
      } catch (e) {
        CustomDialog.hideDialog();

        CustomDialog.showStringDialog("Wrong phone number or pin");
      }
    }
  }

  Future<void> getCredentials() async {
    loginResponse.value = await authRepository.getCredentials();
  }

  obscureText() {
    if (hidePassword.value == true) {
      hidePassword.value = false;
    } else if (hidePassword.value == false) {
      hidePassword.value = true;
    }
  }
}
