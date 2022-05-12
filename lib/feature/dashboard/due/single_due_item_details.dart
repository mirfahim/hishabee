import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/due/due_Item_edit.dart';
import 'package:hishabee_business_manager_fl/models/due/due_item_model.dart';
import 'package:hishabee_business_manager_fl/models/due/due_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// int flagDate = 0;
// var now = DateTime.now();
// var startOfMonth = DateTime(now.year, now.month, 1);
// var lastOfTheMonth = (now.month < 12)
//     ? new DateTime(now.year, now.month + 1, 0)
//     : new DateTime(now.year + 1, 1, 0);
// bool imageChanged = false;

Widget textFormFeildForExpense(
    {int lengthInputFormater,
    String regEx,
    String hintText,
    String labelText,
    IconButton iconButton,
    int maxLine,
    TextEditingController textEditingController}) {
  return TextFormField(
    readOnly: true,
    controller: textEditingController,
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

class SingleDueDetails extends StatefulWidget {
  var amount;
  var transactionUniqueId;
  String description;
  String image;
  String updatedAt;
  String createdAt;
  String uniqueId;
  String dueUniqueId;
  var dueLeft;
  String dueTakerType;
  String dueType;
  String name;
  String mobile;
  int version;
  var dueTotalAmount;

  SingleDueDetails(
      {this.transactionUniqueId,
      this.amount,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.uniqueId,
      this.dueLeft,
      this.dueUniqueId,
      this.name,
      this.dueType,
      this.dueTakerType,
      this.mobile,
      this.version,
      this.dueTotalAmount});

  @override
  State<SingleDueDetails> createState() => _SingleDueDetailsState();
}

class _SingleDueDetailsState extends State<SingleDueDetails> {
  TextEditingController _textEditingControllerAmount = TextEditingController();
  TextEditingController _textEditingControllerDescription =
      TextEditingController();
  Shop shop = Get.arguments;

  DueController _dueController = Get.find();

  @override
  void initState() {
    _textEditingControllerAmount.text = widget.amount.toString();
    _textEditingControllerDescription.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: bgColor,
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
          'due'.tr,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Container(
          height: height,
          color: DEFAULT_BODY_BG_COLOR,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text('Give your Mobile Number'),
                Text(
                  'amount_of_money'.tr,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                textFormFeildForExpense(
                    textEditingController: _textEditingControllerAmount,
                    hintText: 'amount_of_money'.tr,
                    regEx: '[0-9]'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'due_description'.tr,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                textFormFeildForExpense(
                    textEditingController: _textEditingControllerDescription,
                    maxLine: 1,
                    regEx: '[a-zA-z]'),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: (widget.image == null)
                          ? Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Icon(Icons.camera_alt),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return DetailScreen(widget.image);
                                }));
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                  imageUrl: widget.image,
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                ),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 7),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              Text(widget.createdAt),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     color: Colors.grey.withOpacity(.35),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text('পণ্যের তালিকাসমূহ'),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Icon(Icons.arrow_drop_down),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    widget.transactionUniqueId != null
                        ? InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: 'please_delete_from_sell'.tr,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            gravity: ToastGravity.BOTTOM
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.35),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red.withOpacity(.35),
                              ),
                              Text(
                                'delete'.tr,
                                style: TextStyle(
                                    color:
                                    Colors.black.withOpacity(.35)),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                        : InkWell(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            // title: Text(message),
                            content:
                            Text('Do you want to Delete the due?'),
                            contentTextStyle: TextStyle(
                                fontSize: 16, color: DEFAULT_BLACK),
                            actions: <Widget>[
                              TextButton(
                                child: Text('cancel'.tr,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14)),
                                onPressed: () {
                                  navigator.pop();
                                },
                              ),
                              TextButton(
                                child: Text('delete'.tr,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14)),
                                onPressed: () {
                                  var amountDelete =
                                      widget.dueTotalAmount -
                                          widget.amount;
                                  _dueController.deleteDueItem(
                                      amount: amountDelete,
                                      shopId: shop.id,
                                      uniqueId: widget.uniqueId,
                                      dueUniqueId: widget.dueUniqueId,
                                      dueLeft: widget.dueLeft,
                                      updatedAt: widget.updatedAt,
                                      createdAt: widget.createdAt);
                                  Future.delayed(
                                      const Duration(seconds: 2), () {
                                    _dueController
                                        .getAllDue(shopId: shop.id)
                                        .then((value) {
                                      _dueController.filterList.value =
                                          getAllDueResponseModelFromJson(
                                              value['data']);
                                      _dueController
                                          .getAllItemWithUniqueID(
                                          uniqueId:
                                          widget.dueUniqueId)
                                          .then((value) {
                                        _dueController
                                            .dueItemList.value =
                                            getDueItemResponseModelFromJson(
                                                value);
                                      });
                                    });
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                    // setState(() {
                                    //   // Here you can write your code for open new view
                                    // });
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.35),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              Text(
                                'delete'.tr,
                                style: TextStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ) ,
                    widget.transactionUniqueId != null ? InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: 'please_edit_from_sell'.tr,
                            backgroundColor: Colors.black.withOpacity(.1),
                            textColor: Colors.black,
                            gravity: ToastGravity.BOTTOM
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.35),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.blue.withOpacity(.35),
                              ),
                              Text(
                                'edit'.tr,
                                style: TextStyle(
                                    color:
                                    Colors.black.withOpacity(.35)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) : InkWell(
                      onTap: () {
                        Get.to(
                            DueItemEdit(
                              uniqueId: widget.uniqueId,
                              dueTotalAmount: widget.dueTotalAmount,
                              dueUniqId: widget.dueUniqueId,
                              dueTakerType: widget.dueTakerType,
                              image: widget.image,
                              name: widget.name,
                              mobile: widget.mobile,
                              amount: widget.amount.toString(),
                              details: widget.description,
                              createdAt: widget.createdAt,
                              updatedAt: widget.updatedAt,
                              version: widget.version,
                              dueLeft: widget.dueLeft,
                            ),
                            arguments: shop);
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.35),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              Text(
                                'edit'.tr,
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                widget.dueLeft != 0 ? Column(
                  children: [
                    Text('due_left:'.tr + '৳${widget.dueLeft}'),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: DEFAULT_BLUE,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text('got_due'.tr, style: TextStyle(
                                color: Colors.white,
                              fontSize: 16
                            ),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('if_you_got_due_amount_then_press_this_button'.tr,textAlign: TextAlign.center, style: TextStyle(

                    ),)
                  ],
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String image;

  DetailScreen(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl: '$image',
              fit: BoxFit.cover,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
