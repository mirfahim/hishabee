import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../constants.dart';

class LoginPageSecond extends GetResponsiveView {
  // LoginPageSecond({required this.controller});

  // final LoginController controller;

  @override
  Widget builder() {
    return Scaffold(
     body: SingleChildScrollView(
       child: GestureDetector(
         onTap: (){
           FocusManager.instance.primaryFocus?.unfocus();
         },
         child: SizedBox(
             height: screen.height,
             width: screen.width,
             child: Column(
               children: [
                 Expanded(
                   flex: 2,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Image.asset(
                         'images/loginModel.jpg',
                         width: double.infinity,
                         fit: BoxFit.fill,
                         // height: 400,
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Image.asset('images/slogan.png'),
                       const SizedBox(
                         height: 10,
                       ),
                       const Text(
                         'অল ইন ওয়ান',
                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                       ),
                       const Text(
                         'বিজনেস স্যলুশন অ্যাপ',
                         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                       ),
                       const SizedBox(
                         height: 20,
                       ),
                       const Text('আপনার মোবাইল নম্বর দিন'),
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
                                 style: TextStyle(
                                     color: DEFAULT_BLACK.withOpacity(0.7), fontWeight: FontWeight.bold),
                               ),
                               contentPadding: EdgeInsets.symmetric(horizontal: 8),
                               border: InputBorder.none,
                               counterText: "",
                               label: Text('Mobile Number'),
                               labelStyle: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black26,
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 20,),
                       ElevatedButton(
                         onPressed: () {},
                         child: Text('এগিয়ে যান',style: TextStyle(color: Colors.white),),
                         style: ElevatedButton.styleFrom(
                             primary: Colors.blueAccent
                         ),
                       )
                     ],
                   ),
                 ),
                 // Expanded(
                 //   flex: 1,
                 //   child: Column(
                 //     mainAxisAlignment: MainAxisAlignment.center,
                 //     children: [
                 //
                 //
                 //     ],
                 //   ),
                 // )
               ],
             )),
       ),
     )
    ) ;

  }
}
