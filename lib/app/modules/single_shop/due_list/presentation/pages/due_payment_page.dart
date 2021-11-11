import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/due_digital_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/pay_due_qr_code_page.dart';

class DuePaymentPage extends GetView<DuePaymentController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: !controller.paying.value
              ? SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.2,
                        width: size.width,
                        child: Image.asset(
                          "images/topBg.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  "due_payment".tr,
                                  style: TextStyle(
                                    color: DEFAULT_BLACK,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: DEFAULT_BLACK,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 55,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        width: size.width * 0.25,
                                        child: Text(
                                          "total_due".tr,
                                          style: TextStyle(
                                            color: DEFAULT_YELLOW_BG,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: VerticalDivider(
                                        color: DEFAULT_YELLOW_BG,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Obx(
                                        () => Text(
                                          "tk".tr +
                                              " ${controller.due.value.dueAmount} /=",
                                          style: TextStyle(
                                            color: DEFAULT_YELLOW_BG,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12.0,
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: DEFAULT_BLACK),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.23),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 55,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            width: size.width * 0.25,
                                            child: Text(
                                              "received".tr,
                                              style: TextStyle(
                                                // color: default_yellow,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: VerticalDivider(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: Form(
                                          key: formKey,
                                          child: TextFormField(
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                            onSaved: (value) {
                                              if (value.length != 0) {
                                                controller.givenDue.value =
                                                    int.parse(value);

                                                if (controller.due.value
                                                            .dueAmount -
                                                        controller
                                                            .givenDue.value <
                                                    0) {
                                                  controller.dueLeft.value = 0;
                                                } else {
                                                  controller.dueLeft
                                                      .value = controller
                                                          .due.value.dueAmount -
                                                      controller.givenDue.value;
                                                }
                                                if (controller.givenDue.value >
                                                    controller
                                                        .due.value.dueAmount) {
                                                  controller.changedAmount
                                                      .value = controller
                                                          .givenDue.value -
                                                      controller
                                                          .due.value.dueAmount;
                                                }
                                              } else {
                                                controller.givenDue.value = 0;
                                              }
                                            },
                                            onChanged: (value) {
                                              if (value.length != 0) {
                                                controller.givenDue.value =
                                                    int.parse(value);

                                                if (controller.due.value
                                                            .dueAmount -
                                                        controller
                                                            .givenDue.value <
                                                    0) {
                                                  controller.dueLeft.value = 0;
                                                } else {
                                                  controller.dueLeft
                                                      .value = controller
                                                          .due.value.dueAmount -
                                                      controller.givenDue.value;
                                                }
                                                if (controller.givenDue.value >
                                                    controller
                                                        .due.value.dueAmount) {
                                                  controller.changedAmount
                                                      .value = controller
                                                          .givenDue.value -
                                                      controller
                                                          .due.value.dueAmount;
                                                }
                                              } else {
                                                controller.givenDue.value = 0;
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              suffix: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "tk".tr,
                                                  style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    //nedd to update localization
                                    "change_amount".tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Obx(
                                    () => Text(
                                      //nedd to update localization
                                      "tk".tr +
                                          " ${controller.changedAmount.value} /="
                                              .tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: DEFAULT_BLUE,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "due_left".tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Obx(
                                    () => Text(
                                      "tk".tr +
                                          " ${controller.dueLeft.value} /=",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: DEFAULT_BLUE,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: DEFAULT_BLACK),
                                        onPressed: () {
                                          if (controller.givenDue.value == 0 ||
                                              controller.givenDue.value ==
                                                  null) {
                                            CustomDialog.showStringDialog(
                                                "Please input amount");
                                          } else {
                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();
                                              payDueWithCash(context);
                                            }
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: SvgPicture.asset(
                                                      'images/svg_image/cash_money.svg'),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "cash".tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Rubik',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: DEFAULT_BLACK),
                                        onPressed: () {
                                          if (controller.cred.value.user
                                                  .nidVerified ==
                                              0) {
                                            CustomDialog.showNidVerigyDialog();
                                          } else {
                                            if (controller.givenDue.value ==
                                                    0 ||
                                                controller.givenDue.value ==
                                                    null) {
                                              CustomDialog.showStringDialog(
                                                  "Please input amount");
                                            } else {
                                              Get.to(() => DigitalPaymentPage(),
                                                  arguments: {
                                                    "shop":
                                                        controller.shop.value,
                                                    "due": controller.due.value,
                                                    "amount": controller
                                                        .givenDue.value,
                                                  },
                                                  binding: DueListBinding());
                                            }
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: SvgPicture.asset(
                                                      'images/svg_image/digital_payment.svg'),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "digital_payment".tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Rubik',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: DEFAULT_BLACK),
                                        onPressed: () {
                                          if (controller.givenDue.value == 0 ||
                                              controller.givenDue.value ==
                                                  null) {
                                            CustomDialog.showStringDialog(
                                                "Please input amount");
                                          } else {
                                            Get.to(
                                              PayDueQRCodePage(),
                                              arguments: {
                                                "shop": controller.shop.value,
                                                "due": controller.due.value,
                                                "givenDue":
                                                    controller.givenDue.value,
                                              },
                                              binding: DueListBinding(),
                                            );
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: SvgPicture.asset(
                                                    'images/svg_image/qr_code.svg',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "personal_qr_code".tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Rubik',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitChasingDots(
                        color: DEFAULT_BLUE,
                        size: 50.0,
                      ),
                      SizedBox(height: 30),
                      Text(
                        "please_wait".tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  payDueWithCash(BuildContext context) async {
    if (controller.givenDue.value == 0) {
      CustomDialog.showStringDialog("enter_amount".tr);
    } else {
      controller.paying.value = true;
      try {
        await controller.payDue();

        if (Platform.isIOS) {
          _cupertinoDialog(context, controller.updateDueResponse.value.message);
        } else {
          _materialDialog(context, controller.updateDueResponse.value.message);
        }
      } finally {
        controller.paying.value = false;
      }
    }
  }

  _materialDialog(BuildContext context, String data) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        content: new Text(data),
        actions: <Widget>[
          TextButton(
            child: Text('close'.tr),
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
            },
          )
        ],
      ),
    );
  }

  _cupertinoDialog(BuildContext context, String data) {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: new Text(data),
        actions: <Widget>[
          TextButton(
            child: Text('close'.tr),
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
