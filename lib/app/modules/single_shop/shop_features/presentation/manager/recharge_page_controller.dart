import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';

class RechargeController extends GetxController {
  final amount = ''.obs;

  recharge() async {
    CustomDialog.showLoadingDialog(message: "Recharging...");

    CustomDialog.hideDialog();
  }
}
