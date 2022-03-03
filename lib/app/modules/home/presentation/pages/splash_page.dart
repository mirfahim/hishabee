import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/custom_pop.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var internalStorage = GetStorage();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      print(internalStorage.read('track'));
      if (Platform.isIOS && (MediaQuery.of(context).size.height < 900)) {
        if (internalStorage.read('track') == null ||
            internalStorage.read('track') == 'false') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (builder) => CustomPopup()));
        } else {
          final SplashController controller = Get.find();
        }
      } else {
        final SplashController controller = Get.find();
      }
    });

    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Container(
                // height: size.height,
                // width: size.width /2,
                child: Image.asset(
                  "images/splashNew.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
