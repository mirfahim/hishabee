import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:image_picker/image_picker.dart';

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

class ExpenseCopy2 extends StatefulWidget {
  @override
  _ExpenseCopy2State createState() => _ExpenseCopy2State();
}

class _ExpenseCopy2State extends State<ExpenseCopy2> {
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
        title: const Text('Expense book'),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              children: [
                textFormFeildForExpense(
                    labelText: 'Amount of Expenses', regEx: '[0-9]'),
                SizedBox(
                  height: 10,
                ),
                textFormFeildForExpense(
                    labelText: 'Expense Type', regEx: '[a-zA-z]'),
                SizedBox(
                  height: 10,
                ),
                textFormFeildForExpense(
                    labelText: 'Expense Description',
                    maxLine: 7,
                    regEx: '[a-zA-z]'),
                SizedBox(
                  height: 20,
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
                                width: 50,
                                height: 200,
                              ),
                      ),
                    ),
                    Text('18th September, 2021')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: DEFAULT_BLUE, fixedSize: Size(width, 50)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
