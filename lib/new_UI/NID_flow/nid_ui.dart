import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/constants_widgets.dart';
import 'dart:io';

class NIDFlow extends StatefulWidget {
  @override
  _NIDFlowState createState() => _NIDFlowState();
}

class _NIDFlowState extends State<NIDFlow> {
  XFile imageFileFront;
  XFile imageFileBack;

  final imagePicker = ImagePicker();

  _openCamerForFront() async {
    var pictureFront = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFileFront = pictureFront;
    });
  }

  _openCamerForback() async {
    var pictureBack = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFileBack = pictureBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'NID Verification',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'NID Number',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWithBorder(
                      lengthInputFormater: 10,
                      regEx: '(0-9)',
                      maxLength: 10,
                      hintText: 'Give your NID Number'),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NID Front Side',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            _openCamerForFront();
                          },
                          child: (imageFileFront == null)
                              ? Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.camera_alt),
                                      Text(
                                          'Take the pciture of front side of the NID')
                                    ],
                                  ),
                                )
                              : Image.file(
                                  File(imageFileFront.path),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NID Back Side',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            _openCamerForback();
                          },
                          child: (imageFileBack == null)
                              ? Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.camera_alt),
                                      Text(
                                          'Take the pciture of back side of the NID')
                                    ],
                                  ),
                                )
                              : Image.file(
                                  File(imageFileBack.path),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  elevatedButtonStyled(
                    buttonColor: Colors.black,
                    buttonTextColor: Colors.white,
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    text: 'Save Here',
                    sizedBoxWidth: 0,
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
