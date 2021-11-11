import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/default_button.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_navigation/auth_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/login_controller.dart';
import 'package:get/get.dart';

class LoginBody extends GetResponsiveView {
  LoginBody({
    @required this.controller,
  });

  final LoginController controller;

  @override
  Widget builder() {
    return Padding(
      padding: EdgeInsets.only(top: screen.height * 0.21),
      child: Container(
          height: screen.context.height - screen.height * 0.21,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "mobile_number".tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: DEFAULT_BLACK,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: DEFAULT_BLACK,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.allow(
                          RegExp('[0-9]'),
                        ),
                      ],
                      maxLength: 11,
                      onChanged: (value) {
                        controller.mobileNumber.value = value;
                      },
                      decoration: InputDecoration(
                        prefix: Text(
                          "+88 ",
                          style:
                              TextStyle(color: DEFAULT_BLACK.withOpacity(0.7)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        border: InputBorder.none,
                        counterText: "",
                        hintText: 'Mobile Number',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w100,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "pin".tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: DEFAULT_BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: screen.width * 0.75,
                            child: TextFormField(
                              cursorColor: DEFAULT_BLACK,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]'),
                                ),
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                controller.pin.value = value;
                              },
                              obscureText: controller.hidePassword.value,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8),
                                border: InputBorder.none,
                                hintText: 'Pin Number',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.obscureText();
                              },
                              icon: Icon(controller.hidePassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AuthRoutes.FORGETPASS);
                      },
                      child: Text(
                        "forgot_password".tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: DEFAULT_BLUE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                DefaultButton(
                  screen: screen,
                  text: "sign_in".tr,
                  buttonColor: DEFAULT_BLACK,
                  onPressed: () async {
                    controller.login();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AuthRoutes.REGISTER);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'don_t_have_an_account'.tr,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ' + 'sign_up'.tr,
                              style: TextStyle(
                                color: DEFAULT_BLUE,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
