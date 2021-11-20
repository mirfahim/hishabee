import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_header.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/subscription_page_controller.dart';
import 'package:intl/intl.dart';

class SubscriptionPage extends GetView<SubscriptionPageController> {
  final Shop shop;

  SubscriptionPage({
    this.shop,
  });

  @override
  Widget build(BuildContext context) {
    String date = shop.endDate.toString();
    DateTime dateTime = DateTime.parse(date);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.2,
                      width: size.width,
                      child: Image.asset(
                        "images/topBg.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    buildPageHeader('subscription'.tr, shop.name),
                    Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "current_subscription".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                shop.package,
                                style: TextStyle(
                                  fontFamily: "Rubik",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            )
                          ],
                        ),
                        height: 80,
                        margin: EdgeInsets.only(
                          left: 15,
                          top: 10,
                          right: 15,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: DEFAULT_BLACK),
                      onPressed: () {
                        // Get.to(
                        //   SubscriptionPackagePage(
                        //     shop: shop,
                        //   ),
                        // );
                      },
                      child: Text(
                        "change_subscription".tr.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Center(
                    child: Text(
                      "subscription_history".tr,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: DEFAULT_BLACK,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: 15,
                    top: 10,
                    right: 15,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 20),
                          child: Text(
                            "subscription_expiration_date".tr,
                            style: TextStyle(
                              fontFamily: "Rubik",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${DateFormat("dd-MMM-yyyy").format(dateTime)}',
                            style: TextStyle(
                              fontFamily: "Rubik",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: DEFAULT_BODY_BG_COLOR),
                              onPressed: () {
                                // Get.to(
                                //   SubscriptionPackagePage(
                                //     shop: shop,
                                //   ),
                                // );
                              },
                              child: Text(
                                'renew_now'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10, right: 10, bottom: 100),
                  child: Obx(
                    () => ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.subscriptionItemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.subscriptionItemList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: size.width * 0.2,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${item.duration}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Days",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.55,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              "${item.package}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: '',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: 'Starting From : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK
                                                            .withOpacity(0.6))),
                                                TextSpan(
                                                    text:
                                                        '${DateFormat("dd-MMM-yyyy").format(item.startDate)}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: '',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: 'Ending at : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK
                                                            .withOpacity(0.6))),
                                                TextSpan(
                                                    text:
                                                        '${DateFormat("dd-MMM-yyyy").format(item.endDate)}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: PopupMenuButton(
                                          onSelected: (value) {
                                            switch (value) {
                                              case 0:
                                                String url =
                                                    "${DOMAIN}invoice/${item.subscriptionId}";
                                                Utility.launchURL(url);
                                                break;
                                            }
                                          },
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    value: 0,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.receipt,
                                                          color: DEFAULT_BLACK,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Receipt",
                                                          style: TextStyle(
                                                              color:
                                                                  DEFAULT_BLACK,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                          child: Icon(
                                            Icons.more_vert,
                                            size: 25,
                                            color: DEFAULT_BLACK,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
