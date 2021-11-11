import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sold_controller.dart';

class SoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SoldController());
  }
}
