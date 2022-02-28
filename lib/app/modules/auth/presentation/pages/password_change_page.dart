import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/password_change_controller.dart';

class PasswordChangePage extends GetView<PasswordChangeController> {
  PasswordChangePage({Key key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_YELLOW_BG,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.05,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "welcome".tr,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "reset_pin".tr,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 22,
                      color: DEFAULT_BLUE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.height * 0.2,
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
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 50,
                    right: 10,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "পাঁচ সংখ্যার পিন নম্বর ",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                onSaved: (value) {
                                  controller.pin.value = value;
                                },
                                maxLength: 5,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  hintText: "পিন নম্বর",
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('[একটি পাঁচ সংখ্যার পিন নম্বর লিখুন। আপনি আপনার একাউন্ট লগইন করতে এটি পরে ব্যবহার করবেন]', style: TextStyle(
                          fontSize: 10, fontFamily: 'Roboto'
                        ),),
                        SizedBox(height: 20,),
                        Text(
                          "পিন নিশ্চিত করুন",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                onSaved: (value) {
                                  controller.confirmPin.value = value;
                                },
                                maxLength: 5,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  hintText: "পিন নিশ্চিত করুন",
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('[পিন নম্বরটি আবার দিন]', style: TextStyle(
                          fontSize: 12, fontFamily: 'Roboto'
                        ),),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: DEFAULT_BLACK),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                await controller.changePassword();
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
