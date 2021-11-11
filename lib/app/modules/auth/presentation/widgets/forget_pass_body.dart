import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_bindings/auth_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/forgot_password_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/forget_password_verify_otp_page.dart';

class ForgetPinBody extends GetResponsiveView {
  ForgetPinBody({
    @required this.screen,
    @required this.controller,
  });

  final ResponsiveScreen screen;
  final ForgotPasswordController controller;

  final formKey = GlobalKey<FormState>();

  @override
  Widget builder() {
    return Positioned(
      top: screen.context.height * 0.2,
      left: 0,
      child: Container(
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
        // color: Colors.white,
        height: screen.context.height,
        width: screen.context.width,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            top: 50,
            right: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "mobile_number".tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey[300],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        onChanged: (value) {
                          controller.mobileNumber.value = value;
                        },
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[0-9]'),
                          ),
                        ],
                        decoration: InputDecoration(
                          prefix: Text(
                            "+88 ",
                            style: TextStyle(
                                color: DEFAULT_BLACK.withOpacity(0.7)),
                          ),
                          hintText: "Mobile Number",
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: screen.context.width,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: DEFAULT_BLACK),
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      controller.sendOtp();
                    }
                  },
                  child: Text(
                    "submit".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Obx(
                  () => Text(
                    controller.serverError.value.isEmpty
                        ? "[A 6 digit verification code will be sent to this number]"
                        : "${controller.serverError.value}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: controller.serverError.value.isEmpty
                            ? DEFAULT_BLACK
                            : Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
