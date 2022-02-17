import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:image_picker/image_picker.dart';
DateTime startDate = DateTime.now();
_selectStartDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    helpText: "start_date".tr,
    context: context,
    initialDate: startDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: DEFAULT_BLACK,
            onPrimary: DEFAULT_BODY_BG_COLOR,
            surface: Colors.green,
            onSurface: DEFAULT_BLACK,
          ),
          dialogBackgroundColor: DEFAULT_BODY_BG_COLOR,
        ),
        child: child,
      );
    },
  );
  if (picked != null) {
    // setState(() {
    //   // widgets.controller.selectedStartDate.value = picked;
    //   startDate = picked;
    // });
  }
}
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

class DuePageEditDelete extends StatefulWidget {
  @override
  State<DuePageEditDelete> createState() => _DuePageEditDeleteState();
}

class _DuePageEditDeleteState extends State<DuePageEditDelete> {
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
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'due_history'.tr,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text('Give your Mobile Number'),
                  textFormFeildForExpense(
                      labelText: 'due'.tr,
                      hintText: 'due',
                      regEx: '[0-9]'),
                  SizedBox(
                    height: 20,
                  ),
                  textFormFeildForExpense(
                      labelText: 'description'.tr,
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
                        child: (imageFileBack == null)
                            ? Row(
                              children: [
                                SvgPicture.asset('images/svg_image/empty-image.svg'),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    _openCamerForback();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      color: DEFAULT_BLUE,
                                    ),
                                    child: Icon(Icons.add, color: Colors.white,),
                                  ),
                                )
                              ],
                            )
                            : Image.file(
                                File(imageFileBack.path),
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                              ),
                      ),
                      InkWell(child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('১৮ অক্টোবর , ২০২১'),
                          )
                      ), onTap: (){
                        _selectStartDate(context);
                      },),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('product_details'.tr, style: TextStyle(
                            fontSize: 14, fontFamily: 'Roboto'

                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_drop_down),
                        )
                      ],
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
                          color: Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            Text('delete'.tr,style: TextStyle(
                              fontSize: 12, fontFamily: 'Roboto'
                            ),)
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            Text('edit'.tr, style: TextStyle(
                                fontSize: 12, fontFamily: 'Roboto'
                            ),),
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
