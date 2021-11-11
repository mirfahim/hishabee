import 'package:get/get.dart';

class SubscriptionPackageController extends GetxController {
  final enable = true.obs;
  final isFirstTimeLogin = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      enable.value = false;
    });
  }
}
