import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'expense_front.dart';

Widget textFormFeildForExpense(
    {int lengthInputFormater,
    String regEx,
    String hintText,
    String labelText,
    IconButton iconButton,
    int maxLine,
    TextInputType keyboardType,
    TextEditingController textEditingController}) {
  return TextFormField(
    cursorColor: Colors.black,
    keyboardType: keyboardType,
    minLines: maxLine,
    controller: textEditingController,
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

var now = DateTime.now();
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);

class NewExpense extends StatefulWidget {
  String shopId;
  String type;
  String userId;
  NewExpense({this.shopId, this.type, this.userId});
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  XFile imageFileFront;
  DateTime startDate = DateTime.now();
  DateTime endDate;
  XFile imageFileBack;
  ExpenseController _expenseController = Get.find();
  final imagePicker = ImagePicker();
  Shop shop = Get.arguments;
  bool _isLoading = false;
  TextEditingController _textEditingControllerAmount = TextEditingController();
  TextEditingController _textEditingControllerReason = TextEditingController();
  TextEditingController _textEditingControllerDescription =
      TextEditingController();
  _openCamerForback() async {
    var pictureBack = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFileBack = pictureBack;
    });
  }

  void getDialog() async {
    await _selectStartDate(context);
    // await _selectEndDate(context);
    // widgets.controller.getRangeTransaction();
  }

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
      setState(() {
        // widgets.controller.selectedStartDate.value = picked;
        startDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: Text('new_expense'.tr, style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: DEFAULT_YELLOW_BG,
      ),
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          opacity: 1,
          child: _expenseController.listCount.value != 0
              ? SingleChildScrollView(
            child: Container(
              height: 800,
              color: Colors.white,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textFormFeildForExpense(
                        labelText: 'amount'.tr,
                        keyboardType: TextInputType.number,
                        regEx: '[0-9]',
                        textEditingController:
                        _textEditingControllerAmount),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      controller: _textEditingControllerReason,

                      // maxLength: maxLength,
                      onChanged: (value) {
                        // controller.mobileNumber.value = value;
                      },
                      decoration: InputDecoration(
                        label: Text('Expense Reason'),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        counterText: "",
                        // hintText: hintText,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      maxLines: 7,
                      controller: _textEditingControllerDescription,

                      // maxLength: maxLength,
                      onChanged: (value) {
                        // controller.mobileNumber.value = value;
                      },
                      decoration: InputDecoration(
                        label: Text('Expense Description'),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        counterText: "",
                        // hintText: hintText,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
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
                                    border: Border.all(
                                        color: Colors.black)),
                                child: Icon(Icons.camera_alt),
                              )
                                  : Image.file(
                                File(imageFileBack.path),
                                width: MediaQuery.of(context)
                                    .size
                                    .width,
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            getDialog();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 7),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today),
                                  Text(
                                      '${DateFormat.yMMMMd().format(startDate)}'),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        await _expenseController.createNewExpense(
                          shopId: widget.shopId,
                          type: widget.type,
                          purpose: _textEditingControllerReason.text,
                          details:
                          _textEditingControllerDescription.text,
                          amount: _textEditingControllerAmount.text,
                        );

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
                            // _isLoading = false;
                            // print('expense list: ${_expenseController.allExpenseList.value}');
                          });
                        });
                        await _expenseController
                            .getAllExpense(
                            shopId: '${widget.shopId}',
                            userId: '${widget.userId}',
                            startDate: '$startOfMonth',
                            endDate: '$lastOfTheMonth')
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
                            // _isLoading = false;
                            // print(
                            //     'expense list: ${_expenseController.allExpenseList.value}');
                          });
                        });

                        await _expenseController
                            .getAllExpenseCategory(
                            shopId: '${widget.shopId}')
                            .then((value) {
                          setState(() {
                            _expenseController.allExpenseCategory.value =
                                expenseCategoryResponseModelFromModel(
                                    value);
                            // print(
                            //     'category: ${_expenseController.allExpenseCategory}');
                          });
                        });
                        Get.back();
                        Get.back();
                      },
                      child: Center(
                        child: Text(
                          'save'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: DEFAULT_BLUE_DARK,
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
          )
              : Container(),
        ),
      ),
    );
  }
}
