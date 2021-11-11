import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/walkthrough/_binding/walkthrough_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/walkthrough/manager/store_setting_walkthrough_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/walkthrough/view/store_publish_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/walkthrough/view/walkthrough_product_list_page.dart';

class StoreSettingWalkThroughPage
    extends GetView<StoreSettingWalkThroughController> {
  const StoreSettingWalkThroughPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 20, bottom: 10),
                    child: Container(
                      height: 35,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: DEFAULT_BLACK.withOpacity(0.5))),
                      child: TextButton(
                        onPressed: () {
                          //Skip
                        },
                        child: Text("SKIP",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                                fontSize: 14)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: Text(
                    "you_online_shop_is_ready".tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: DEFAULT_BLACK.withOpacity(0.7),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20, top: 10),
                  child: InkWell(
                    onTap: () async {
                      if (controller.publishShop.value == true) {
                        controller.publishShop.value = await Get.to(
                            () => StorePublishPage(),
                            binding: WalkThroughBinding());
                      } else {
                        Fluttertoast.showToast(msg: "Shop published");
                      }
                    },
                    child: Obx(
                      () => Container(
                        height: 120,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: controller.publishShop.value == true
                                  ? Colors.white
                                  : Colors.green,
                              width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5),
                                    borderRadius: BorderRadius.circular(60)),
                                child: Center(
                                  child: Text(
                                    "one".tr,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              child: Text(
                                "publish_shop".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK.withOpacity(0.7),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 50.0, top: 10, bottom: 10),
                  child: Container(
                      height: 60,
                      width: 40,
                      child: SvgPicture.asset(
                        "images/svg_image/dots.svg",
                        color: DEFAULT_BLACK,
                        fit: BoxFit.fill,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => WalkThroughProductListPage(),
                          arguments: {
                            "shop": controller.shop.value,
                          },
                          binding: WalkThroughBinding());
                    },
                    child: Container(
                      height: 120,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(60)),
                              child: Center(
                                child: Text(
                                  "two".tr,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.4,
                            child: Text(
                              "add_online_product".tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK.withOpacity(0.7),
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 50.0, top: 10, bottom: 10),
                  child: Container(
                      height: 60,
                      width: 40,
                      child: SvgPicture.asset(
                        "images/svg_image/dots.svg",
                        color: DEFAULT_BLACK,
                        fit: BoxFit.fill,
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20, bottom: 30),
                  child: Container(
                    height: 120,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(60)),
                            child: Center(
                              child: Text(
                                "three".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: Text(
                            "start_sell".tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: DEFAULT_BLACK.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
