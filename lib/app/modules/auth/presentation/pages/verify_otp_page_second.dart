import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPPageSecond extends StatefulWidget {

  final String mobileNo;
  //final VerifyOTPController verifyOTPController = AppDependencies.find();
  OTPPageSecond({
    this.mobileNo,
  });

  @override
  State<OTPPageSecond> createState() => _OTPPageSecondState();
}

class _OTPPageSecondState extends State<OTPPageSecond> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _pinPutController = TextEditingController();
    final FocusNode _pinPutFocusNode = FocusNode();

    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        width: 2,
        color: const Color.fromRGBO(128, 128, 128, 1),
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('ভেরিফিকেশন কোড দিন'),
              const SizedBox(
                height: 30,
              ),
              const Text(
                '০১৮৩০৭৩৬৪৭০ নম্বরে ৪ ডিজিটের ভেরিফিকেশন কোড পাঠানো হয়েছে।',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('কোড টি লিখুন'),
              const SizedBox(
                height: 30,
              ),
              PinPut(
                keyboardType: TextInputType.number,
                eachFieldPadding: EdgeInsets.all(5),
                fieldsCount: 4,
                autofocus: true,
                textStyle:
                const TextStyle(fontSize: 25.0, color: Colors.black87),
                eachFieldWidth: 50.0,
                eachFieldHeight: 50.0,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.fade,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('কোড পান নাই?'),
              TextButton(onPressed: () {}, child: const Text('পুনরায় পাঠান')),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('এগিয়ে যান',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    padding: EdgeInsets.only(left: 100, right: 100, top: 5, bottom: 5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}