import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_navigation/auth_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/login_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/pin_confrimation_new.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/pages/register_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/exchange_page.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class LoginPageSecond extends StatelessWidget {
  LoginPageSecond({@required this.controller});

  final LoginController controller;
  TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/loginModel.jpg',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              // height: 400,
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset('images/slogan.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              'অল ইন ওয়ান',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
            ),
            Text(
              'বিজনেস স্যলুশন অ্যাপ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Align(alignment: Alignment.bottomLeft,child: Text('আপনার মোবাইল নম্বর দিন')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
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
                      fontWeight: FontWeight.w700,
                      color: Colors.black26,
                      fontFamily: 'Roboto'
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async{
                  CustomDialog.showLoadingDialog(message: 'Loading');
                  var responseCode = await controller.newLogin(mobileNumber: controller.mobileNumber.value).

                  then((value){
                    return value['code'];
                  });
                  var message = await controller.newLogin(mobileNumber: controller.mobileNumber.value).

                  then((value){
                    return value['message'];
                  });
                  print('from number check: $responseCode');
                  if(responseCode == 200 || responseCode == 201){
                    CustomDialog.hideDialog();
                      Get.to(PinVerification(loginController: controller,));
                      // CustomDialog.hideDialog();
                      print('from number check: $responseCode');
                  }
                  else if(responseCode == 400){
                    Utils.showToast(message);
                    CustomDialog.hideDialog();

                  }
                  else if(responseCode == 403 || responseCode == 404){
                    CustomDialog.hideDialog();
                    Get.toNamed(AuthRoutes.REGISTER);

                  }

                },
                child: Text('এগিয়ে যান',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  primary: DEFAULT_BLUE,
                  fixedSize: Size(width, 40)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
