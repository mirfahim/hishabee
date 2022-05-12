import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/models/due/due_item_model.dart';
import 'package:hishabee_business_manager_fl/models/due/due_model.dart';
import 'package:intl/intl.dart';

int flagDate = 0;
var now = DateTime.now();
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);
bool imageChanged = false;

class TakenDue extends StatefulWidget {
  int totalDue;
  String uniqueId;
  String dueUniqueId;
  String createdAt;
  String updatedAt;
  String contactType;
  int dueLeft;
  int version;
  String name;
  String mobile;
  TakenDue(
      {this.uniqueId,
        this.totalDue,
        this.dueUniqueId,
        this.createdAt,
        this.updatedAt,
        this.contactType,
        this.dueLeft,
        this.version,
        this.name,
        this.mobile});
  @override
  State<TakenDue> createState() => _TakenDueState();
}

class _TakenDueState extends State<TakenDue> {
  File image;
  int dueTypeFlagGet = 1;
  int dueTypeFlagGiven = 1;
  Shop shop = Get.arguments;
  int flag = 0;
  DateTime selectedDate;
  DateTime initialDate = DateTime.now();
  DateTime endDate;
  TextEditingController _amount = TextEditingController();
  TextEditingController _description = TextEditingController();
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
  DueController _dueController = Get.find();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('due'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('transaction_type'.tr, style: TextStyle(
                fontSize: 18
            ),),
            SizedBox(height: 10,),
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
            SizedBox(height: 10,),
            Text('amount'.tr, style: TextStyle(
                fontSize: 18
            ),),
            SizedBox(height: 10,),
            TextFormField(
              controller: _amount,
              decoration: InputDecoration(
                hintText: 'amount'.tr,
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey.withOpacity(.35)),
                    borderRadius: BorderRadius.circular(6)
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('description'.tr, style: TextStyle(
                fontSize: 18
            ),),
            SizedBox(height: 10,),
            TextFormField(
              controller: _description,
              decoration: InputDecoration(
                hintText: 'description'.tr,
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey.withOpacity(.35)),
                    borderRadius: BorderRadius.circular(6)
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('date'.tr, style: TextStyle(
                    fontSize: 18
                ),),
                Text('picture'.tr, style: TextStyle(
                    fontSize: 18
                ),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () async{
                      await _selectStartDate(context);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
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
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                var changedDue = widget.totalDue - int.parse(_amount.text);
                print(changedDue);

                _dueController.dueTaken(
                    amount: -(int.parse(_amount.text)),
                    shopId: shop.id,
                    uniqueId: widget.uniqueId,
                    dueUniqueId: widget.dueUniqueId,
                    createdDate: widget.createdAt,
                    contactType: widget.contactType,
                    updatedDate: widget.updatedAt,
                    dueLeft: widget.dueLeft,
                    version: 0,
                    mobile: widget.mobile,
                    name: widget.name);

                _dueController.editDue(
                    uniqueId: widget.uniqueId,
                    amount: changedDue,
                    shopId: shop.id,
                    contactType: widget.contactType,
                    mobile: widget.mobile,
                    name: widget.name,
                    updatedDate: widget.updatedAt,
                    createdDate: widget.createdAt,
                    version: ++widget.version
                );
                _dueController
                    .getAllItemWithUniqueID(uniqueId: widget.uniqueId)
                    .then((value) {
                  _dueController.dueItemList.value = getDueItemResponseModelFromJson(value);

                });
                _dueController.getAllDue(shopId: shop.id).then((value){
                  if(value != null){
                    _dueController.dueList.value = getAllDueResponseModelFromJson(value['data']);
                    _dueController.filterList.value = getAllDueResponseModelFromJson(value['data']);
                    for(int i = 0; i<_dueController.filterList.length; i++){
                      if(_dueController.filterList[i].dueAmount < 0){
                        _dueController.payDue.value = _dueController.filterList
                            .map((e) => e.dueAmount)
                            .fold(0, (previousValue, element) => previousValue + element);
                      }else if(_dueController.filterList[i].dueAmount > 0){
                        _dueController.takeDue.value = _dueController.filterList
                            .map((e) => e.dueAmount)
                            .fold(0, (previousValue, element) => previousValue + element);
                      }
                    }
                  }
                  Get.back();
                  Get.back();
                });

              },
              child: Container(
                width: width,
                decoration: BoxDecoration(
                    color: DEFAULT_BLUE,
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Text('save'.tr, style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
