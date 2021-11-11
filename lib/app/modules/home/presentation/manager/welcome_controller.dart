import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_services/localization_service.dart';

class WelcomeController extends GetxController {
  final ILocalizationService localizationService;

  WelcomeController(this.localizationService);

  final isBangla = true.obs;

  @override
  onInit() async {
    super.onInit();
    await getLanguageType();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => initTrackingPermission());
  }

  Future<void> changeLanguage() async {
    await localizationService.changeLocale();
  }

  Future<void> getLanguageType() async {
    isBangla.value = await localizationService.isBangla();
  }

  Future<void> initTrackingPermission() async {
    // try {
    //   final TrackingStatus status =
    //       await AppTrackingTransparency.trackingAuthorizationStatus;
    //   if (status == TrackingStatus.notDetermined) {
    //     final TrackingStatus status =
    //         await AppTrackingTransparency.requestTrackingAuthorization();
    //     print("Status : $status");
    //   }
    // } on PlatformException {}
  }
}
