import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:intl/intl.dart';

Widget textFormFeildForExpense(
    {String hintText,
      // String mainText,
      String labelText,
      IconButton iconButton,
      int maxLine,
      TextEditingController texteditingController}) {
  return TextFormField(
    cursorColor: Colors.black,
    minLines: maxLine,
    controller: texteditingController,
    // initialValue: mainText,
    onChanged: (value) {
      // controller.mobileNumber.value = value;
    },
    maxLines: maxLine,
    decoration: InputDecoration(
      suffix: iconButton,
      labelText: labelText,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(
          color: Color(0xFFC4C4C4).withOpacity(.35),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(
          color: Color(0xFFC4C4C4).withOpacity(.35),
        ),
      ),
      counterText: "",
      hintText: hintText,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black26,
      ),
    ),
  );
}
// int flag = 0;
int flagDate = 0;
var now = DateTime.now();
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);
bool imageChanged = false;
class ExpenseEditDelete extends StatefulWidget {
  String amount;
  String reason;
  String description;
  String types;
  String categoryId;
  String shopId;
  String userId;
  String date;
  File image;

  ExpenseEditDelete(
      {this.amount,
      this.reason,
      this.description,
      this.types,
      this.shopId,
      this.categoryId,
      this.userId,
      this.date,
        this.image
      });

  @override
  State<ExpenseEditDelete> createState() => _ExpenseEditDeleteState();
}

class _ExpenseEditDeleteState extends State<ExpenseEditDelete> {
  ApiService _apiService = ApiService();
  Shop shop = Get.arguments;
  String imageSource;
  TextEditingController _textEditingControllerAmount = TextEditingController();
  TextEditingController _textEditingControllerReason = TextEditingController();
  TextEditingController _textEditingControllerDescription =
      TextEditingController();
  ExpenseController _expenseController = Get.find();
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
                          widget.image = value;
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
                          widget.image = value;
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
                          widget.image = value;
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
                          widget.image = value;
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
        widget.date = DateFormat.yMMMMd().format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingControllerAmount.text = widget.amount;
    _textEditingControllerDescription.text = widget.description;
    _textEditingControllerReason.text = widget.reason;
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: () async{
          print('is image changed or not $imageChanged');
          if(flag != 0){
            await _expenseController.updateExpense(
                imageChange: imageChanged,
                imageUrl: widget.image,
                shopId: widget.shopId,
                categoryid: widget.categoryId,
                type: widget.types,
                purpose: _textEditingControllerReason.text == '' ? widget.reason : _textEditingControllerReason.text ,
                description: _textEditingControllerDescription.text == '' ? widget.description : _textEditingControllerDescription.text,
                amount: _textEditingControllerAmount.text == '' ? widget.amount : _textEditingControllerAmount.text,
                date: flagDate == 0 ? '${DateFormat("MMMM d, y").parse(widget.date)}' : '$selectedDate'
            );
          }
          else{
            await _expenseController.updateExpenseWithoutImage(
                shopId: widget.shopId,
                categoryid: widget.categoryId,
                type: widget.types,
                purpose: _textEditingControllerReason.text == '' ? widget.reason : _textEditingControllerReason.text ,
                description: _textEditingControllerDescription.text == '' ? widget.description : _textEditingControllerDescription.text,
                amount: _textEditingControllerAmount.text == '' ? widget.amount : _textEditingControllerAmount.text,
                date: flagDate == 0 ? '${DateFormat("MMMM d, y").parse(widget.date)}' : '$selectedDate'
            );
          }


          await _expenseController
              .getAllExpense(
              shopId: '${widget.shopId}',
              userId: '${widget.userId}',
              startDate: '$startOfMonth',
              endDate: '$lastOfTheMonth')
              .then((value) {
            setState(() {

              _expenseController.allExpenseList.value =
                  getExpenseFromModel(value);
              _expenseController.totalExpense.value =
                  _expenseController.allExpenseList
                      .map((e) => e.amount)
                      .fold(
                      0,
                          (previousValue, element) =>
                      previousValue + element);
              _expenseController.totalFixedExpense.value = _expenseController.totalExpense.value;
            });
          });
          await _expenseController
              .getAllExpense(
              shopId: '${widget.shopId}',
              userId: '${widget.userId}',
              startDate: '$startOfMonth',
              endDate: '$lastOfTheMonth'
          )
              .then((value) {
            setState(() {
              // _expenseList = getExpenseFromModel(value);
              _expenseController.allExpenseList.value =
                  getExpenseFromModel(value);
              _expenseController.totalExpense.value =
                  _expenseController.allExpenseList
                      .map((e) => e.amount)
                      .fold(
                      0,
                          (previousValue, element) =>
                      previousValue + element);
              _expenseController.totalFixedExpense.value = _expenseController.totalExpense.value;
            });
          });
          Get.back();
          Get.back();
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                color: DEFAULT_BLUE,
                borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text('save'.tr,textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.white, fontSize: 18
                ),),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: Text('edit_expense'.tr, style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text('Name of type of the Expense'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('amount'.tr, style: TextStyle(fontSize: 16,fontFamily: 'Roboto'),),
                      TextFormField(
                        cursorColor: Colors.black,
                        minLines: 1,
                        controller: _textEditingControllerAmount,
                        maxLines: 1,
                        decoration: InputDecoration(
                          // suffix: iconButton,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Color(0xFFC4C4C4).withOpacity(.35),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Color(0xFFC4C4C4).withOpacity(.35),
                            ),
                          ),
                          counterText: "",
                          // hintText: hintText,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('purpose'.tr, style: TextStyle(fontSize: 16,fontFamily: 'Roboto'),),
                      textFormFeildForExpense(
                        // labelText: 'purpose'.tr,
                          hintText: '${widget.reason}',
                          // mainText: '${widget.reason}',
                          texteditingController: _textEditingControllerReason),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('description'.tr, style: TextStyle(fontSize: 16,fontFamily: 'Roboto'),),
                      textFormFeildForExpense(
                        // labelText: 'description'.tr,
                          hintText: '${widget.description}',
                          // mainText: '${widget.description}',
                          texteditingController:
                          _textEditingControllerDescription),
                      const SizedBox(
                        height: 30,
                      ),
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
                                child: (widget.image == null)
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
                                    imageUrl: '${widget.image.path}',
                                    alignment: Alignment.topLeft,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    height: 100,
                                  ) : Image.file(
                                      File(widget.image.path),
                                    alignment: Alignment.topLeft,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    height: 100,
                                  ),
                                ),

                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                getDialog();
                              },
                              child: Container(
                                width: 180,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 7),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_today),
                                      Text(widget.date),
                                    ],
                                  ),
                                  //asdasdasd
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
