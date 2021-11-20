import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/pages/recharge_page.dart';
import 'package:intl/intl.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_header.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_navigation/settings_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/digital_balance_page_controller.dart';

class DigitalBalancePage extends GetView<DigitalBalancePageController> {
  final Shop shop;
  DigitalBalancePage(this.shop);

  @override
  Widget build(BuildContext context) {
    print("SHOP ID: ${DataHolder.shopId}");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: Obx(
        () => controller.walletResponse.value != null
            ? SafeArea(
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
                            buildPageHeader(
                                'digital_balance_colon'.tr, shop.name),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 100.0, right: 15, left: 15, bottom: 15),
                              child: Container(
                                height: 100,
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          'digital_balance_colon'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "tk".tr,
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: DEFAULT_BLUE,
                                              ),
                                            ),
                                            Text(
                                              ' ${shop.walletBalance}',
                                              style: TextStyle(
                                                fontFamily:
                                                    'Rubik-VariableFont_wght',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLUE,
                                              ),
                                            ),
                                            Text(
                                              '/=',
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: DEFAULT_BLUE,
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
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            height: 140,
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Card(
                                      elevation: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                "digital_income".tr,
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                            ),
                                            Obx(() => Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${controller.walletResponse.value.wallet.liquidBalance} ",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Rubik-VariableFont_wght',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DEFAULT_BLUE,
                                                        ),
                                                      ),
                                                      Text(
                                                        "tk".tr,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: DEFAULT_BLUE,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                  bottom: 10),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.red),
                                                  onPressed: () {
                                                    if (controller.cred.value
                                                            .user.nidVerified ==
                                                        0) {
                                                      CustomDialog
                                                          .showNidVerigyDialog();
                                                    } else {
                                                      Get.toNamed(
                                                        SettingsRoutes
                                                            .WITHDRAW_REQUEST,
                                                        arguments: {
                                                          "shop": shop
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: size.width * 0.28,
                                                    child: Center(
                                                      child: Text(
                                                        'withdraw'.tr,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                "hishabee_credit".tr,
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Obx(
                                                    () => Text(
                                                      "${controller.walletResponse.value.wallet.hishabeeCredit} ",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Rubik-VariableFont_wght',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLUE,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "tk".tr,
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: DEFAULT_BLUE,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                  bottom: 10),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.green),
                                                  onPressed: () {
                                                    if (controller.cred.value
                                                            .user.nidVerified ==
                                                        0) {
                                                      CustomDialog
                                                          .showNidVerigyDialog();
                                                    } else {
                                                      Get.to(
                                                        RechargePage(),
                                                        arguments: {
                                                          "shop": shop
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: size.width * 0.28,
                                                    child: Center(
                                                      child: Text(
                                                        'recharge'.tr,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 20,
                            width: size.width,
                            child: Center(
                              child: Text(
                                "transaction_history".tr,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10, bottom: 100),
                          child: Obx(
                            () => Container(
                              height: 400,
                              child: ListView.builder(
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.walletResponse.value.wallet
                                    .walletTransaction.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = controller.walletResponse.value
                                      .wallet.walletTransaction[index];
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: size.width * 0.12,
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                item.type == "RECHARGE" ||
                                                        item.type ==
                                                            "DIGITAL_PAYMENT" ||
                                                        item.type == "CASHBACK" ||
                                                        item.type ==
                                                            "MARKETING_CREDIT" ||
                                                        item.type == "ADD"
                                                    ? "images/svg_image/recharge.svg"
                                                    : "images/svg_image/withdraw.svg",
                                                height: 40,
                                              )),
                                            ),
                                            Container(
                                              width: size.width * 0.5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${item.type.replaceAll("_", "")}",
                                                      style: TextStyle(
                                                          color: item.type ==
                                                                      "RECHARGE" ||
                                                                  item.type ==
                                                                      "DIGITAL_PAYMENT" ||
                                                                  item.type ==
                                                                      "CASHBACK" ||
                                                                  item.type ==
                                                                      "MARKETING_CREDIT" ||
                                                                  item.type ==
                                                                      "ADD"
                                                              ? Colors.green
                                                              : Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "Rubik-Italic-VariableFont_wght",
                                                          fontSize: 16),
                                                    ),
                                                    Container(
                                                      width: size.width * 0.5,
                                                      child: Text(
                                                        "${item.note}",
                                                        style: TextStyle(
                                                            color: DEFAULT_BLACK,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        "${DateFormat('dd-MMM, yyyy   KK:mm a').format(item.createdAt)}")
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              child: Text(
                                                "৳" + "${item.amount}" + "/=",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: PopupMenuButton(
                                                    onSelected: (value) {
                                                      switch (value) {
                                                        case 0:
                                                          break;
                                                      }
                                                    },
                                                    itemBuilder: (context) => [
                                                          PopupMenuItem(
                                                              value: 0,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    Icons.receipt,
                                                                    color:
                                                                        DEFAULT_BLACK,
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
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                                ],
                                                              )),
                                                        ],
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      size: 30,
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
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Center(
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "images/icons/bee.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                            SpinKitFadingCircle(
                              color: DEFAULT_BLUE,
                              //size: 0.0,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Please Wait",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLUE,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
