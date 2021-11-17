import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:image_picker/image_picker.dart';

import 'helper_for_dialog.dart';

Widget textFormFeildForExpense(
    {int lengthInputFormater,
    String regEx,
    String hintText,
    String labelText,
    IconButton iconButton,
    int maxLine}) {
  return TextFormField(
    cursorColor: Colors.black,
    keyboardType: TextInputType.number,
    minLines: maxLine,
    inputFormatters: [
      LengthLimitingTextInputFormatter(lengthInputFormater),
      FilteringTextInputFormatter.allow(
        RegExp(regEx),
      ),
    ],
    // maxLength: maxLength,
    onChanged: (value) {
      // controller.mobileNumber.value = value;
    },
    maxLines: maxLine,
    decoration: InputDecoration(
      label: Text(labelText),
      suffix: iconButton,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      counterText: "",
      hintText: hintText,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black26,
      ),
    ),
  );
}

class NewExpense extends StatefulWidget {
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  XFile imageFileFront;

  XFile imageFileBack;

  final imagePicker = ImagePicker();

  _openCamerForback() async {
    var pictureBack = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFileBack = pictureBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('New Expense'),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text('Give your Mobile Number'),
                  textFormFeildForExpense(
                      labelText: 'Mobile Number',
                      hintText: 'Give Your Mobile Number',
                      iconButton: IconButton(
                        icon: Icon(Icons.people),
                        color: DEFAULT_BLUE,
                        onPressed: () {
                          DialogHelper.exit(context);
                          // Material(
                          //     type: MaterialType.transparency,
                          //     child: showGeneralDialog(
                          //       barrierColor: Colors.black,
                          //       barrierDismissible: false,
                          //       context: context,
                          //       transitionDuration: Duration(milliseconds: 300),
                          //       pageBuilder: (BuildContext context,
                          //           Animation animation,
                          //           Animation secondAnimation) {
                          //         return Center(
                          //           child: Container(
                          //             decoration:
                          //                 BoxDecoration(color: Colors.white),
                          //             width: 300,
                          //             height: 500,
                          //             child: Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Column(
                          //                 children: [Text('Contact List')],
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     ));
                        },
                      ),
                      regEx: '[0-9]'),
                  SizedBox(
                    height: 20,
                  ),
                  // const Text('Amount of expenses'),
                  textFormFeildForExpense(
                      labelText: 'Amount of Expenses',

                      // iconButton: IconButton(
                      //   icon: Icon(Icons.people),
                      //   color: buttonColor,
                      //   onPressed: () {},
                      // ),
                      regEx: '[0-9]'),
                  SizedBox(
                    height: 20,
                  ),
                  textFormFeildForExpense(
                      labelText: 'Expense Reason',

                      // iconButton: IconButton(
                      //   icon: Icon(Icons.people),
                      //   color: buttonColor,
                      //   onPressed: () {},
                      // ),
                      regEx: '[a-zA-z]'),
                  SizedBox(
                    height: 20,
                  ),
                  textFormFeildForExpense(
                      labelText: 'Expense Description',
                      maxLine: 7,

                      // iconButton: IconButton(
                      //   icon: Icon(Icons.people),
                      //   color: buttonColor,
                      //   onPressed: () {},
                      // ),
                      regEx: '[a-zA-z]'),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            _openCamerForback();
                          },
                          child: (imageFileBack == null)
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Icon(Icons.camera_alt),
                                )
                              : Image.file(
                                  File(imageFileBack.path),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                ),
                        ),
                      ),
                      Text('18th September, 2021')
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'Enter',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: DEFAULT_BLUE,
                      fixedSize: Size(width, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// void showCustomeDialog(BuildContext context) {
//   Scaffold(
//     body: ,
//   );
//   showGeneralDialog(
//     barrierColor: Colors.black,
//     barrierDismissible: false,
//     context: context,
//     transitionDuration: Duration(milliseconds: 300),
//     pageBuilder:
//         (BuildContext context, Animation animation, Animation secondAnimation) {
//       return Center(
//         child: Container(
//           decoration: BoxDecoration(color: Colors.white),
//           width: 300,
//           height: 500,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [Text('Contact List')],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
