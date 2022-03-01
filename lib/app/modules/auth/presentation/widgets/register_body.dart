import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/default_button.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/register_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpBody extends GetResponsiveView {
  final RegisterController controller;
  final ResponsiveScreen screen;
  SignUpBody({
    @required this.controller,
    @required this.screen,
  });
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                30,
              ),
              topRight: Radius.circular(
                30,
              ),
            ),
          ),
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              top: 30,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // business name start
                Text(
                  "business_name".tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        cursorColor: DEFAULT_BLACK,
                        onSaved: (value) {
                          controller.brandName.value = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "name_of_business".tr,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Mobile start
                Text(
                  "mobile_number".tr,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                          FilteringTextInputFormatter.allow(
                            RegExp('[0-9]'),
                          ),
                        ],
                        onSaved: (value) {
                          controller.mobileNumber.value = value;
                        },
                        validator: (value) {
                          String prefix = value.substring(0, 3);
                          // if (prefix != "013" ||
                          //     prefix != "014" ||
                          //     prefix != "017" ||
                          //     prefix != "015" ||
                          //     prefix != "016" ||
                          //     prefix != "018" ||
                          //     prefix != "019") {
                          //   return "please input a bangladeshi number";
                          // }
                          if (value.length < 11) {
                            return "please input a valid number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefix: Text(
                            "+88 ",
                            style: TextStyle(
                                color: DEFAULT_BLACK,
                                fontWeight: FontWeight.bold),
                          ),
                          hintText: "11_digit_mobile_number".tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "address".tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        cursorColor: DEFAULT_BLACK,
                        onSaved: (value) {
                          controller.address.value = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "address".tr,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "password".tr,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(
                            RegExp('[0-9]'),
                          ),
                        ],
                        onSaved: (value) {
                          controller.pin.value = value;
                        },
                        decoration: InputDecoration(
                          hintText: "write_pin_number".tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "enter_a_5_digit_pin_number_you_will_use_it_later_to_login_to_your_account"
                      .tr,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "confirm_password".tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(
                            RegExp('[0-9]'),
                          ),
                        ],
                        onSaved: (value) {
                          controller.pinConfirmation.value = value;
                        },
                        decoration: InputDecoration(
                          hintText: "confirm_password".tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "enter_the_pin_again".tr,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Checkbox(
                            checkColor: Colors.white,
                            activeColor: DEFAULT_BLACK,
                            value: controller.termsAgreed.value,
                            onChanged: (value) {
                              controller.termsAgreed.value = value;
                            },
                          )),
                      Obx(
                        () => Text(
                          'I have read and accept',
                          style: TextStyle(
                              fontWeight: controller.termsAgreed.value
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12,
                              color: DEFAULT_BLACK),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    const url = 'https://hishabee.business/terms-of-use/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Center(
                    child: Text(
                      "General Terms & Conditions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: DEFAULT_BLUE, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    const url =
                        'https://hishabee.business/business-manager-terms-of-use/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Center(
                    child: Text(
                      "Business Manager Terms &Condition",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: DEFAULT_BLUE, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 15),
                  child: Container(
                    width: screen.context.width,
                    margin: EdgeInsets.only(bottom: 35.0),
                    child: Obx(
                      () => ElevatedButton(
                          child: Text("register".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screen.responsiveValue(mobile: 16, tablet: 20),
                              fontWeight: FontWeight.bold,
                            ),),
                          style: ElevatedButton.styleFrom(primary: Colors.black),

                          onPressed: !controller.termsAgreed.value
                              ? null
                              : () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    controller.register();
                                    //FreeTrialDialog.freeTrialDialog(context);
                                  }
                                }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
