import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/customer_contact.dart';
import 'package:hishabee_business_manager_fl/app/_utils/employee_contact.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/_utils/supplier_contact.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/customerDialog.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:intl/intl.dart';

int flagDate = 0;
var now = DateTime.now();
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);
bool imageChanged = false;
class DueNew extends StatefulWidget {


  @override
  State<DueNew> createState() => _DueNewState();
}

class _DueNewState extends State<DueNew> {
  File image;
  Shop shop = Get.arguments;
  DueController _dueController = Get.find();
  String _value = 'customer';
  String dueType = '';
  int dueTypeFlagGet = 0;
  int dueTypeFlagGiven = 0;
  int flag = 0;
  DateTime selectedDate;
  DateTime initialDate = DateTime.now();
  DateTime endDate;

  void getDialog() async {
    await _selectStartDate(context);
    // await _selectEndDate(context);
    // widgets.controller.getRangeTransaction();
  }
  _showPictureOptionDialogue() {

    try {
      if (Platform.isIOS) {
        showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text("Picture option"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      ImageHelper.getImageFromCamera().then((value) {
                        setState(() {
                          image = value;
                          flag = 1;
                          imageChanged = true;
                        });


                        navigator.pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              height: 80,
                              image: AssetImage('images/icons/camera.png'),
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //getImageFromGallery(option);
                      ImageHelper.getImageFromGallery().then((value) {
                        setState(() {
                          image = value;
                          flag = 1;
                          imageChanged = true;
                        });


                        navigator.pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              height: 80,
                              image: AssetImage('images/icons/gallery.png'),
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    navigator.pop();
                  },
                )
              ],
            ));
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Picture option"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      ImageHelper.getImageFromCamera().then((value) {
                        setState(() {
                          image = value;
                          flag = 1;
                          imageChanged = true;
                        });

                        navigator.pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              height: 80,
                              image: AssetImage('images/icons/camera.png'),
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //getImageFromGallery(option);
                      ImageHelper.getImageFromGallery().then((value) {
                        setState(() {
                          image = value;
                          flag = 1;
                          imageChanged = true;
                        });


                        navigator.pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              height: 80,
                              image: AssetImage('images/icons/gallery.png'),
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    navigator.pop();
                  },
                )
              ],
            ));
      }
    } catch (e) {}
  }
  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "start_date".tr,
      context: context,
      initialDate: initialDate,
      // Refer step 1
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
      setState(() {
        // widgets.controller.selectedStartDate.value = picked;
        flagDate = 1;
        selectedDate = picked;
        initialDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,
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
          'due_new'.tr,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'select_class'.tr,
                  style: TextStyle(
                      color: Colors.black, fontSize: 16, fontFamily: 'Roboto'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: 'customer'.tr,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {

                          _value = value;
                          dueType = _value;
                          print('dueType: $dueType');
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    Text('customer'.tr,style: TextStyle(fontSize: 16),),
                    Radio(
                      value: 'supplier'.tr,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          dueType = _value;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    Text('supplier'.tr,style: TextStyle(fontSize: 16),),
                    Radio(
                      value: 'employee'.tr,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          dueType = _value;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    Text('employee'.tr,style: TextStyle(fontSize: 16),),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'select_due_type'.tr,
                  style: TextStyle(
                      color: Colors.black, fontSize: 16, fontFamily: 'Rubik'),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dueTypeFlagGet = 0;
                            dueTypeFlagGiven = 0;
                          });
                        },
                        child: Center(
                          child: Text(
                            'get/profit'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:dueTypeFlagGet == 0 ? Colors.white : Colors.black,
                                fontSize: 12,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: dueTypeFlagGet == 0 ? DEFAULT_BLUE : Colors.white,
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dueTypeFlagGiven = 1;
                            dueTypeFlagGet = 1;
                          });
                        },
                        child: Center(
                          child: Text(
                            'given/due'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: dueTypeFlagGiven == 1 ? Colors.white : Colors.black,
                                fontSize: 12,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: dueTypeFlagGiven == 1 ? DEFAULT_BLUE : Colors.white,
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('name'.tr,style: TextStyle(fontSize: 16),),
                TextFormField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-Z0-9]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: (){
                        if(dueType == 'customer'.tr){
                          Future.delayed(Duration.zero, () async {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (context, _, __) =>
                                    CustomerContact(),
                                opaque: false));
                          });
                        }else if(dueType == 'supplier'.tr){
                          Future.delayed(Duration.zero, () async {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (context, _, __) =>
                                    SupplierContact(),
                                opaque: false));
                          });
                        }else{
                          Future.delayed(Duration.zero, () async {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (context, _, __) =>
                                    EmployeeContact(),
                                opaque: false));
                          });
                        }

                      },
                       icon: Icon(Icons.arrow_drop_down),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'name'.tr,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('mobile'.tr,style: TextStyle(fontSize: 16),),
                TextFormField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'mobile'.tr,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('due_amount'.tr,style: TextStyle(fontSize: 16),),
                TextFormField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'due_amount'.tr,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('description'.tr,style: TextStyle(fontSize: 16),),
                TextFormField(
                  maxLines: 5,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-Z0-9]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'description'.tr,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          getDialog();
                        },
                        child: Container(
                          // width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 7),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today),
                                Text('${DateFormat.yMMMMd().format(now)}'),
                              ],
                            ),
                            //asdasdasd
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text('add_receipt'.tr),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: InkWell(
                                onTap: () {
                                  print('hello');
                                  _showPictureOptionDialogue();
                                },
                                child: (image == null)
                                    ? Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black)),
                                  child: Icon(Icons.camera_alt),
                                )
                                    : Container(
                                  height: 50,
                                  width: 50,
                                  child: flag == 0 ? CachedNetworkImage(
                                    imageUrl: '${image.path}',
                                    alignment: Alignment.topLeft,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    height: 100,
                                  ) : Image.file(
                                    image,
                                    alignment: Alignment.topLeft,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    height: 100,
                                  ),
                                ),

                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 30,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.35),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'sms_free_20'.tr,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        Switch(
                          activeColor: Colors.blue,
                          onChanged: (bool value) {},
                          value: true,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'save'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: DEFAULT_BLUE,
                      fixedSize: Size(width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
