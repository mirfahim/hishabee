import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/models/due/due_item_model.dart';
import 'package:hishabee_business_manager_fl/models/due/due_model.dart';

class DueFullEdit extends StatelessWidget {
  String name;
  int shopId;
  String mobileNumber;
  var dueTotalAmount;
  String uniqueId;
  String contactType;
  String createdAt;
  String updatedAt;
  int dueLeft;
  String dueUniqueId;
  String image;
  int version;
  DueFullEdit({this.name,
    this.shopId,
    this.image,
    this.mobileNumber,
    this.dueTotalAmount,
    this.uniqueId,
    this.contactType,
    this.createdAt,
    this.updatedAt,
    this.dueLeft,
    this.dueUniqueId,
    this.version});
  final formKey = GlobalKey<FormState>();

  DueController _dueController = Get.find();
  Shop shop =Get.arguments;
  @override
  Widget build(BuildContext context) {
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
          'update_information'.tr,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          if (Platform.isIOS) {
                            showDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                      title: Text("Picture option"),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              ImageHelper.getImageFromCamera()
                                                  .then((value) {
                                                _dueController
                                                    .contactImage.value = value;
                                                navigator.pop();
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image(
                                                      height: 80,
                                                      image: AssetImage(
                                                          'images/icons/camera.png'),
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
                                              ImageHelper.getImageFromGallery()
                                                  .then((value) {
                                                _dueController
                                                    .contactImage.value = value;
                                                navigator.pop();
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image(
                                                      height: 80,
                                                      image: AssetImage(
                                                          'images/icons/gallery.png'),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              ImageHelper.getImageFromCamera()
                                                  .then((value) {
                                                _dueController
                                                    .contactImage.value = value;
                                                navigator.pop();
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image(
                                                      height: 80,
                                                      image: AssetImage(
                                                          'images/icons/camera.png'),
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
                                              ImageHelper.getImageFromGallery()
                                                  .then((value) {
                                                _dueController
                                                    .contactImage.value = value;
                                                navigator.pop();
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image(
                                                      height: 80,
                                                      image: AssetImage(
                                                          'images/icons/gallery.png'),
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
                      },
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.yellow, width: 1),
                          color: Colors.white,
                        ),
                        child: Obx(
                          () => _dueController.contactImage.value == null
                              ? Image.asset(
                                  'images/icons/profile_placeholder.png',
                                  height: 60,
                                  width: 60,
                                )
                              : Container(
                                  height: 60,
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.file(
                                      _dueController.contactImage.value,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'name'.tr,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  initialValue: name,
                  // controller: _textEditingControllerEmail,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6.0))),
                ),
                SizedBox(height: 10,),
                Text(
                  'mobile_number'.tr,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10,),
                TextFormField(

                  initialValue: mobileNumber,
                  // controller: _textEditingControllerEmail,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    mobileNumber = value;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Mobile Number',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6.0))),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    // print('shop id ${shop.id}');
                    _dueController.editDue(
                      amount: dueTotalAmount,
                      shopId: shopId,
                      contactType: contactType,
                      mobile: mobileNumber,
                      name: name,
                      updatedDate: updatedAt,
                      createdDate: createdAt,
                      version: ++version,
                      uniqueId: uniqueId
                    );
                    _dueController
                        .getAllDueItem(shopId: shopId)
                        .then((value) {
                      _dueController.dueItemList.value = getDueItemResponseModelFromJson(value['data']);
                    });
                    print('due item list: ${_dueController.dueItemList}');
                    _dueController.getAllDue(shopId: shopId).then((value){
                      if(value != null){
                        _dueController.dueList.value = getAllDueResponseModelFromJson(value['data']);
                        _dueController.filterList.value = getAllDueResponseModelFromJson(value['data']);
                      }
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Center(
                      child: Text('save'.tr, textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.white
                      ),),
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
