import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/forget_password_verify_otp_controller.dart';

class VerifyOtpForForgetPassword
    extends GetView<VerifyForgetPasswordOtpController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 2 - 5);
    final double itemWidth = (size.width);
    ScrollController scrollController = new ScrollController();
    return Scaffold(
      backgroundColor: Color(0xfffffada),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "verification_code_title".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'We sent you a 6 digit code',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      width: size.width * 0.6,
                      child: Center(
                        child: Text(
                          'to +88 ${controller.mobileNumber.value}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: DEFAULT_BLACK),
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
                top: 10.0, bottom: 10, right: 20, left: 20),
            child: Container(
              width: size.width,
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: DEFAULT_BLUE, width: 3)),
              child: Align(
                alignment: Alignment.center,
                child: Obx(() => Text(
                      controller.code.value.isEmpty
                          ? '000000'
                          : controller.code.value,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: DEFAULT_BLACK,
                      ),
                      overflow: TextOverflow.fade,
                    )),
              ),
            ),
          ),
          Container(
            child: GridView.count(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              controller: scrollController,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 3,
              children: List.generate(
                12,
                (index) {
                  switch (index) {
                    case 0:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("1");
                            },
                            child: Text(
                              "1",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 1:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("2");
                            },
                            child: Text(
                              "2",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 2:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("3");
                            },
                            child: Text(
                              "3",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 3:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("4");
                            },
                            child: Text(
                              "4",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 4:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("5");
                            },
                            child: Text(
                              "5",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 5:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("6");
                            },
                            child: Text(
                              "6",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 6:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("7");
                            },
                            child: Text(
                              "7",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 7:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("8");
                            },
                            child: Text(
                              "8",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 8:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("9");
                            },
                            child: Text(
                              "9",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 9:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.reSendOtp();
                            },
                            icon: Icon(
                              Icons.refresh,
                              size: 25,
                            ),
                          ),
                        ),
                      );
                      break;
                    case 10:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.verifyOtp("0");
                            },
                            child: Text(
                              "0",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 11:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.code.value = '';
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              size: 25,
                            ),
                          ),
                        ),
                      );
                      break;
                    default:
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ),
                      );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
