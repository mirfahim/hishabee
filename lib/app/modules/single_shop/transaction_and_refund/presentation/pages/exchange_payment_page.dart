import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/avd.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_bindings/app_settings_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/set_qr_code_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/exchange_payment_controller.dart';

class ExchangePaymentPage extends GetView<ExchangePaymentController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: !controller.paying.value
            ? Stack(
                children: [
                  Container(
                    height: size.height * 0.2,
                    width: size.width,
                    child: Image.asset(
                      "images/topBg.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              Text(
                                "exchangePayment_payment".tr,
                                style: TextStyle(
                                  color: DEFAULT_BLACK,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: DEFAULT_BLACK),
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
                            height: 50,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 120,
                                    child: Text(
                                      "previous_amount".tr,
                                      style: TextStyle(
                                        color: DEFAULT_BLACK,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    color: DEFAULT_BLACK,
                                    thickness: 1,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Obx(
                                    () => Text(
                                      "tk".tr +
                                          " ${controller.previousPrice.value} /=",
                                      style: TextStyle(
                                        color: DEFAULT_BLACK,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                            top: 10,
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: DEFAULT_BLACK),
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
                            height: 50,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 120,
                                    child: Text(
                                      "new_amount".tr,
                                      style: TextStyle(
                                        color: DEFAULT_BLACK,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    color: DEFAULT_BLACK,
                                    thickness: 1,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Obx(
                                    () => Text(
                                      "tk".tr + " ${controller.newPrice} /=",
                                      style: TextStyle(
                                        color: DEFAULT_BLACK,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                            top: 10,
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: DEFAULT_BLACK,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: DEFAULT_BLACK),
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
                            height: 50,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 120,
                                    child: Text(
                                      "total_payable".tr,
                                      style: TextStyle(
                                        color: Colors.amber[400],
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    color: Colors.amber[400],
                                    thickness: 1,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    "tk".tr +
                                        " ${controller.getAmount.value} /=",
                                    style: TextStyle(
                                      color: Colors.amber[400],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30.0,
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
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        width: 120,
                                        child: Text(
                                          "received".tr,
                                          style: TextStyle(
                                            color: DEFAULT_BLACK,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: VerticalDivider(
                                        color: DEFAULT_BLACK,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Form(
                                      key: controller.formKey,
                                      child: TextFormField(
                                        initialValue: "0",
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                        onSaved: (value) {
                                          controller.takeAmount.value =
                                              double.parse(value);
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
                                              "TK",
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
                                "customer_will_get".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "tk".tr + " ${controller.payAmount.value} /=",
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 18,
                                  color: DEFAULT_BLUE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: DEFAULT_BLACK,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: DEFAULT_BLACK),
                              onPressed: () {
                                if (controller.formKey.currentState
                                    .validate()) {
                                  controller.formKey.currentState.save();
                                  controller.confirm();
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
                                        child: AvdPicture.asset(
                                            'images/xml_icon/ic_money.xml'),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "cash".tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w600,
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
                              borderRadius: BorderRadius.circular(4),
                              color: DEFAULT_BLACK,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: DEFAULT_BLACK),
                              onPressed: () {
                                Get.to(
                                  SetQRCodePage(),
                                  arguments: {
                                    "shop": controller.shop.value,
                                    "type": "transaction"
                                  },
                                  binding: AppSettingsBinding(),
                                );
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
                                        child: AvdPicture.asset(
                                            'images/xml_icon/ic_qr_code.xml'),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "personal_qr_code".tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w600,
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
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 30),
                    Text(
                      "Please Wait",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  payDueWithCash(BuildContext context) async {
    /*if (controller.givenDue.value == 0) {
      _materialDialog(context, "Please enter amount");
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
    }*/
  }
}
