import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/utils/employee_popup.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
class PaySalaryPageExpense extends StatefulWidget {
  String shopId;
  String type;
  String userId;
  String contactName;
  PaySalaryPageExpense({this.shopId, this.type, this.userId, this.contactName});

  @override
  _PaySalaryPageExpenseState createState() => _PaySalaryPageExpenseState();
}

class _PaySalaryPageExpenseState extends State<PaySalaryPageExpense> {
  File image;
  DateTime startDate = DateTime.now();
  DateTime endDate;
  String imageSource;
  ExpenseController _expenseController = Get.find();
  Shop shop = Get.arguments;
  bool _isLoading = false;
  TextEditingController _textEditingControllerAmount = TextEditingController();
  TextEditingController _textEditingControllerReason = TextEditingController();
  TextEditingController _textEditingControllerDescription =
  TextEditingController();

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

  // @override
  // void initState() {
  //   super.initState();
  //
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back,color: Colors.black, ),
        ),
        title: Text('new_expenses'.tr, style: TextStyle(
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
                    // const Text('Give your Mobile Number'),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // // const Text('Amount of expenses'),
                    Container(
                      decoration: Utils.getBoxShape(),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "name|".tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0),
                              child: TextFormField(
                                controller: _expenseController.employeeNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "name".tr,
                                  hintStyle:
                                  TextStyle(fontSize: 14.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (_) {
                                  return EmployeePopup(shop: shop);
                                }),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        label: Text('expense_reason'.tr),
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
                        label: Text('expense_description'.tr),
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
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: GestureDetector(
                            onTap: () {
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
                              child: Image.file(
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
                    GestureDetector(
                        onTap: () async{
                          // print('print from create expense ${image.path}');
                          await _expenseController.createNewExpenseEmployee(
                            contactName: _expenseController.employeeNameController.text,
                              shopId: widget.shopId,
                              type: widget.type,
                              purpose: _textEditingControllerReason.text,
                              details:
                              _textEditingControllerDescription.text == '' ? '[Nothing Given]' : _textEditingControllerDescription.text,
                              amount: _textEditingControllerAmount.text,
                              imageURL: image
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

                          await _expenseController
                              .getAllExpenseCategory(
                              shopId: '${widget.shopId}')
                              .then((value) {
                            setState(() {
                              _expenseController.allExpenseCategory.value =
                                  expenseCategoryResponseModelFromModel(
                                      value);
                              print(
                                  'category: ${_expenseController.allExpenseCategory}');
                            });
                          });
                          Get.back();
                          Get.back();
                        },
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
                        )

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
