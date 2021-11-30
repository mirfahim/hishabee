import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/shop_item_card.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/_bindings/product_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/product_list_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/business_overview/business_overview.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/create_sms.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/digital_payment.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/digital_payment.dart';

class StandardItemList extends GetResponsiveView<ShopFeaturesController> {
  final Shop shop;

  StandardItemList({
    this.shop,
  });

  @override
  Widget builder() {
    Size size = MediaQuery.of(screen.context).size;
    final double itemHeight = size.height * 0.13;
    final double itemWidth = size.width * 0.44;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 5),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ProductListPage(),
                        arguments: {
                          "shop": shop,
                        },
                        binding: ProductListBinding());
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/productList.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "product_list".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => SmsCreatePage(),
                      arguments: {
                        "shop": shop,
                      },
                      // binding: SMSBindings(),
                    );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/settings.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "sms_marketing".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                // InkWell(
                //   onTap: () {
                //     Get.to(() => SellPageShowcase(),
                //         arguments: {
                //           "shop": shop,
                //         },
                //         binding: SellBinding());
                //   },
                //   child: Container(
                //     height: itemHeight,
                //     width: itemWidth,
                //     decoration: SHOP_ITEM_DECORATION,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           'images/shop_features/sell.png',
                //           height:
                //               screen.responsiveValue(mobile: 40, tablet: 60),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Text(
                //           "sell_pos".tr,
                //           style: TextStyle(
                //             fontFamily: 'Rubik',
                //             fontSize: 16,
                //             fontWeight: FontWeight.normal,
                //             color: DEFAULT_BLACK,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(BusinessOverView(), arguments: shop);
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/bo.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "business_overview".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                InkWell(
                  onTap: () =>
                      Get.to(DigitalPaymentDashboard(), arguments: shop),
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/settings.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "digital_marketing".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
