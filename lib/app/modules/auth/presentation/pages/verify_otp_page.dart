import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_bindings/shop_main_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/select_shop_page.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifyOtpPage extends StatefulWidget {
  final String mobileNo;
  //final VerifyOTPController verifyOTPController = AppDependencies.find();
  VerifyOtpPage({
    this.mobileNo,
  });

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  Timer _timer;
  int _start = 30;
  bool display = false;
  String otp;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      width: 2,
      color: const Color.fromRGBO(43, 46, 66, 1),
    ),
  );

  @override
  void initState() {
    super.initState();
    startTimer();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('ভেরিফিকেশন', style: TextStyle(fontFamily: 'Roboto'),),
        // backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "images/authentication.png",
                      height: 100,
                      width: size.width,
                    ),
                  ),
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
                    '৬ ডিজিটের ভেরিফিকেশন কোড সেন্ড করা হয়েছে এই নম্বর এ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Roboto'
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      width: size.width * 0.55,
                      child: Center(
                        child: Text(
                          '+88 ${widget.mobileNo}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: DEFAULT_BLUE),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      width: size.width * 0.55,
                      child: Center(
                        child: Divider(
                          color: Colors.black,
                          thickness: 2,
                          height: 2,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: PinPut(
              keyboardType: TextInputType.number,
              eachFieldPadding: EdgeInsets.all(5),
              fieldsCount: 6,
              autofocus: true,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.black87),
              eachFieldWidth: 40.0,
              eachFieldHeight: 50.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                /// Need to connect with firebase
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      await AnalyticsService.sendAnalytics(
                          event: AnalyticsEvent.regCompleted);
                      //Need to change rout
                      Get.off(
                        () => SelectShopPage(),
                        binding: ShopMainBinding(),
                      );
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text('Invalid OTP')));
                }
              },
            ),
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: "retry_in".tr,
                style: TextStyle(
                    color: DEFAULT_BLACK.withOpacity(0.5), fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                    text: " $_start",
                    style: TextStyle(color: DEFAULT_BLUE, fontSize: 16),
                  ),
                  TextSpan(
                    text: " second_later".tr,
                    style: TextStyle(
                        color: DEFAULT_BLACK.withOpacity(0.5), fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          display
              ? Center(
                  child: GestureDetector(
                    onTap: () {
                      otpForgotPin(widget.mobileNo);
                      _verifyPhone();
                    },
                    child: Text(
                      "resend_code".tr,
                      style: TextStyle(
                        color: DEFAULT_BLACK,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "go_back".tr,
              style: TextStyle(
                  color: DEFAULT_BLUE,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// Verify Otp Start
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+88${widget.mobileNo}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              await AnalyticsService.sendAnalytics(
                  event: AnalyticsEvent.regCompleted);
              Get.off(
                () => SelectShopPage(),
                binding: ShopMainBinding(),
              );
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error From Firebase: $e.message');
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 30));
  }

  ///verify Otp End
  void otpForgotPin(String number) async {
    startTimer();
  }

  startTimer() {
    setState(() {
      display = false;
      _start = 30;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              display = true;
            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }
}
