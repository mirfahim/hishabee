import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/nid_verification/presentation/manager/nid_verification_page_controller.dart';

class NidVerificationBinding extends Bindings {
  static final find = Get.find;
  @override
  void dependencies() {
    Get.lazyPut(() => NidVerificationController(find()));
  }
}
