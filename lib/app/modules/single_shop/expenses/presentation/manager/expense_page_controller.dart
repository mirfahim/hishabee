import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/help_button_box.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';

class ExpensePageController extends GetxController {
  final showCase = true.obs;
  final showCaseTap = Rxn<bool>();
  @override
  void onInit() async {
    await getBox();
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      showCase.value = false;
    });
  }

  getBox() async {
    showCaseTap.value = await HelpButton.getBox(ButtonKey.expenseKey);
  }

  trainingVideoOpen(BuildContext context) {
    final String url =
        "https://www.youtube.com/watch?v=_WOEj0TfnWs&list=PLO7C_xRyL47emWQfUcp2-djjzgdlPGcqS&index=12&pbjreload=101";
    final String title = "expense_page_showcase".tr;
    HelpButton.setBox(ButtonKey.expenseKey);
    Navigator.of(context).push(TutorialOverlay(url, title));
  }
}
