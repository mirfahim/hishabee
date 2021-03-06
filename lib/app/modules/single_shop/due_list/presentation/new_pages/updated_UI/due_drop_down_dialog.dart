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

class DuePageEditDeleteWithDialog extends StatefulWidget {
  @override
  State<DuePageEditDeleteWithDialog> createState() =>
      _DuePageEditDeleteWithDialogState();
}

class _DuePageEditDeleteWithDialogState
    extends State<DuePageEditDeleteWithDialog> {
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text(
              '??????????????? ??????????????????',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              '??????????????? ??????????????????',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: height,
            color: DEFAULT_BODY_BG_COLOR,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text('Give your Mobile Number'),
                  textFormFeildForExpense(
                      labelText: 'Mobile Number',
                      hintText: 'Give Your Mobile Number',
                      regEx: '[0-9]'),
                  SizedBox(
                    height: 20,
                  ),
                  textFormFeildForExpense(
                      labelText: 'Expense Description',
                      maxLine: 7,
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
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.35),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('?????????????????? ??????????????????????????????'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_drop_down),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('images/pant.png'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('T-Shirt'),
                                    ],
                                  ),
                                  Text('?????????')
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey.withOpacity(.5),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('images/pant.png'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('T-Shirt'),
                                    ],
                                  ),
                                  Text('?????????')
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey.withOpacity(.5),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.35),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            Text('???????????? ???????????????')
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.35),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            Text('???????????? ????????????'),
                          ],
                        ),
                      ),
                    ],
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
