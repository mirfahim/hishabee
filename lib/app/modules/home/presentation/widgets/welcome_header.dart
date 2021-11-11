import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/welcome_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/pages/onboardingScrren/onboardingPage.dart';

class WelcomeHeader extends GetResponsiveView {
  final WelcomeController controller;

  WelcomeHeader({@required this.controller});
  final portraitImageList = [
    AssetImage('images/slider/slider1.png'),
    AssetImage('images/slider/slider2.png'),
    AssetImage('images/slider/slider3.png'),
    AssetImage('images/slider/slider4.png'),
    AssetImage('images/slider/slider5.png'),
    AssetImage('images/slider/slider6.png'),
    AssetImage('images/slider/slider7.png'),
  ];
  @override
  Widget builder() {
    print("Screen Height ${screen.height}");
    return Container(
      height: screen.height <= 650 && screen.height > 550
          ? screen.height * 0.6
          : screen.height > 650 && screen.height < 750
              ? screen.height * 0.70
              : screen.height * 0.72,
      child: Stack(
        children: [
          // Center(
          //   child: Container(
          //     width: screen.context.isLandscape
          //         ? screen.responsiveValue(mobile: 200)
          //         : double.maxFinite,
          //     child: Carousel(
          //       boxFit: BoxFit.fill,
          //       images: portraitImageList,
          //       autoplay: true,
          //       animationCurve: Curves.fastOutSlowIn,
          //       animationDuration: Duration(milliseconds: 1000),
          //       dotBgColor: Colors.transparent,
          //       dotSize: 0.0,
          //       showIndicator: false,
          //       dotVerticalPadding: 10,
          //       dotColor: Colors.blueGrey,
          //       dotPosition: DotPosition.bottomCenter,
          //     ),
          //   ),
          // ),
          // OnboardingPage(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  await controller.changeLanguage();
                  controller.getLanguageType();
                },
                child: controller.isBangla.value
                    ? Text(
                        'English',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    : Text(
                        'বাংলা',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
