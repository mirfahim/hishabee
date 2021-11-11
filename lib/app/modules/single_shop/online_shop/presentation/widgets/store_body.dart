import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/shop_item_card.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/_bindings/store_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_dashboard_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/pages/chat_user_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/pages/delivery_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/pages/online_products_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/pages/order_list_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/pages/store_setting_page.dart';

class StoreBody extends GetResponsiveView<OnlineStoreDashboardController> {
  @override
  Widget builder() {
    Size size = MediaQuery.of(screen.context).size;
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Container(
        height: screen.context.height,
        decoration: BoxDecoration(
          color: DEFAULT_BODY_BG_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              30,
            ),
            topRight: Radius.circular(
              30,
            ),
          ),
        ),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 20, left: 10, right: 10),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: size.width * 0.28,
                        decoration: BoxDecoration(
                          color: DEFAULT_BLACK,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                "${controller.onlineShopInfoResponse.value.shop.activeOrder}",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Active Order",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 70,
                        width: size.width * 0.28,
                        decoration: BoxDecoration(
                          color: DEFAULT_BLACK,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                "${controller.onlineShopInfoResponse.value.shop.onlineProduct}",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Online Products",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 70,
                        width: size.width * 0.28,
                        decoration: BoxDecoration(
                          color: DEFAULT_BLACK,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                "৳ ${controller.onlineShopInfoResponse.value.shop.totalEarning}",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Earn",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 20, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => ChatUserPage(), binding: StoreBinding());
                    },
                    child: Container(
                      height: 110,
                      width: size.width * 0.45,
                      decoration: SHOP_ITEM_DECORATION,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            child:
                                SvgPicture.asset('images/svg_image/chat.svg'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Online Message",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ShopSettingPage(),
                            arguments: {
                              "onlineShopInfoResponse":
                                  controller.onlineShopInfoResponse.value
                            },
                            binding: StoreBinding());
                      },
                      child: Container(
                        height: 110,
                        width: size.width * 0.45,
                        decoration: SHOP_ITEM_DECORATION,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              child: AvdPicture.asset(
                                  'images/xml_icon/setting.xml'),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Shop Setting",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => OrderListPage(), binding: StoreBinding());
                    },
                    child: Container(
                      height: 110,
                      width: size.width * 0.45,
                      decoration: SHOP_ITEM_DECORATION,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            child: AvdPicture.asset(
                                'images/xml_icon/online_order.xml'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Order List",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => OnlineProductPage(),
                            arguments: {
                              "shop":
                                  controller.onlineShopInfoResponse.value.shop
                            },
                            binding: StoreBinding());
                      },
                      child: Container(
                        height: 110,
                        width: size.width * 0.45,
                        decoration: SHOP_ITEM_DECORATION,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              child: AvdPicture.asset(
                                  'images/xml_icon/ic_online_shopping.xml'),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Online Product",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => DeliveryPage(), binding: StoreBinding());
                    },
                    child: Container(
                      height: 110,
                      width: size.width * 0.45,
                      decoration: SHOP_ITEM_DECORATION,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            child: SvgPicture.asset(
                              'images/svg_image/delivery_truck.svg',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Delivery",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 110,
                        width: size.width * 0.45,
                        //decoration: SHOP_ITEM_DECORATION,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              /*child: AvdPicture.asset(
                                  'images/xml_icon/ic_online_shopping.xml'),*/
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
