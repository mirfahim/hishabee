import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/login_controller.dart';
import 'package:get/get.dart';

import 'forgot_password_page.dart';
class PinVerification extends StatelessWidget {
  PinVerification({this.loginController});
  final LoginController loginController;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  // color: Colors.amber,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome', style: TextStyle(
                        fontFamily: 'Roboto', fontSize: 24,
                      ),),
                      SizedBox(height: 10,),
                      Text('সাইন ইন ', style: TextStyle(
                          fontFamily: 'Roboto', fontSize: 20, color: DEFAULT_BLUE
                      ),)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  // height: height,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset('images/slogan.png'),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('তথ্য সুরক্ষার জন্য আপনার ৫ ডিজিটের পিন দিয়ে দোকানে প্রবেশ করুন', style: TextStyle(
                          fontSize: 16, fontFamily: 'Roboto'
                        ),),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(()=> TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9]'),
                            ),
                          ],
                          obscureText: loginController.hidePassword.value,
                          maxLength: 11,
                          onChanged: (value) {
                            loginController.pin.value = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  loginController.obscureText();
                                },
                                icon: Icon(loginController.hidePassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off, color: Colors.grey,)),
                            // fillColor: Colors.grey.shade200,
                            // filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                            counterText: "",
                            hintText: 'pin'.tr,
                            hintStyle: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        // TextFormField(
                        //   cursorColor: Colors.black,
                        //   keyboardType: TextInputType.number,
                        //   inputFormatters: [
                        //     LengthLimitingTextInputFormatter(5),
                        //     FilteringTextInputFormatter.allow(
                        //       RegExp('[0-9]'),
                        //     ),
                        //   ],
                        //   maxLength: 11,
                        //   onChanged: (value) {
                        //     // controller.mobileNumber.value = value;
                        //   },
                        //   decoration: InputDecoration(
                        //     suffixIcon: const Icon(Icons.visibility_off),
                        //     // prefix: Text(
                        //     //   " Give your Pin",
                        //     //   style: TextStyle(color: Colors.black.withOpacity(0.7)),
                        //     // ),
                        //     fillColor: Colors.grey.shade200,
                        //     filled: true,
                        //     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10)),
                        //     counterText: "",
                        //     hintText: 'Confirm your pin',
                        //     hintStyle: const TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black26,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 100,
                        // ),
                        Center(
                          child: TextButton(onPressed: (){
                            Get.to(ForgotPasswordPage());
                          },
                              child: Text('পিন ভুলে গেছেন?', style: TextStyle(
                                color: Colors.red, fontSize: 16, fontFamily: 'Roboto'
                              ),)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              loginController.login();

                            },
                            child:  Text('confirm'.tr, style: TextStyle(
                                fontSize: 16, fontFamily: 'Roboto', color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF185ADB),
                              fixedSize: Size(400, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
