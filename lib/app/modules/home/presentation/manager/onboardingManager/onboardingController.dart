import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_navigation/auth_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/onboardingManager/onboardingModel.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController{

  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex == onboardingPages.length -1;
  var pageController = PageController();

  fowardAction(){
    if(isLastPage){
      Get.toNamed(AuthRoutes.LOGIN);
    }else{
    pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }
  List<OnboardingModel> onboardingPages = [
    OnboardingModel(
        'images/onboard1.png',
        'keep track of your business digitally'.tr,
        'নির্ভুল হিশাব',
        'লাভ ও ক্ষতি',
        'ব্যবসার রিপোর্ট',
        'স্টকের তদরকারি',
        'images/accounting.png',
        'images/financial_profit.png',
        'images/report.png',
        'images/inventory.png'),
    OnboardingModel(
        'images/onboard2.png',
        'অনলাইন ব্যবসার সেরা অ্যাপ',
        'নিজেসহ ই-কমার্স',
        'ডেলিভারি সুবিধা',
        'ডিজিটাল মার্কেটিং',
        'কিস্তিতে বিক্রি',
        'images/ecommerce.png',
        'images/delivery_icon.png',
        'images/marketing_icon.png',
        'images/calender.png')
  ];
}
