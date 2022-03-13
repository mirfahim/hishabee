import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
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
int flag = 0;
var now = DateTime.now();
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);

class ExpenseEditDelete extends StatefulWidget {
  String amount;
  String reason;
  String description;
  String types;
  String categoryId;
  String shopId;
  String userId;
  String date;

  ExpenseEditDelete(
      {this.amount,
      this.reason,
      this.description,
      this.types,
      this.shopId,
      this.categoryId,
      this.userId,
      this.date
      });

  @override
  State<ExpenseEditDelete> createState() => _ExpenseEditDeleteState();
}

class _ExpenseEditDeleteState extends State<ExpenseEditDelete> {
  Shop shop = Get.arguments;
  TextEditingController _textEditingControllerAmount = TextEditingController();
  TextEditingController _textEditingControllerReason = TextEditingController();
  TextEditingController _textEditingControllerDescription =
      TextEditingController();
  ExpenseController _expenseController = Get.find();

  DateTime selectedDate;
  DateTime initialDate = DateTime.now();
  DateTime endDate;

  void getDialog() async {
    await _selectStartDate(context);
    // await _selectEndDate(context);
    // widgets.controller.getRangeTransaction();
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
        flag = 1;
        selectedDate = picked;
        initialDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
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
                      textFormFeildForExpense(
                        // labelText: 'amount'.tr,
                          hintText: '${widget.amount}',
                          // mainText: '${widget.amount}',
                          texteditingController: _textEditingControllerAmount),
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
                                  Text('${widget.date}' ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextButton(
                                onPressed: () async{
                                  await _expenseController.updateExpense(
                                    shopId: widget.shopId,
                                    categoryid: widget.categoryId,
                                    type: widget.types,
                                    purpose: _textEditingControllerReason.text == '' ? widget.reason : _textEditingControllerReason.text ,
                                    description: _textEditingControllerDescription.text == '' ? widget.description : _textEditingControllerDescription.text,
                                    amount: _textEditingControllerAmount.text == '' ? widget.amount : _textEditingControllerAmount.text,
                                    date: flag == 0 ? '${widget.date}' : '$selectedDate'
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

                                  // _expenseController
                                  //     .getAllExpenseCategory(shopId: '${widget.shopId}')
                                  //     .then((value) {
                                  //   setState(() {
                                  //     _expenseController.allExpenseCategory.value =
                                  //         expenseCategoryResponseModelFromModel(value);
                                  //     print(
                                  //         'category: ${_expenseController.allExpenseCategory}');
                                  //   });
                                  // });
                                  Get.back();
                                  Get.back();
                                },
                                style: TextButton.styleFrom(primary: Colors.blue),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Icon(Icons.edit),
                                    Text('edit'.tr)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextButton(
                                onPressed: () async {
                                  _expenseController.deleteExpense(
                                      categoryid: widget.categoryId);

                                  for(int i = 0; i<_expenseController.allExpenseCategory.length;i++) {
                                    _expenseController.allExpenseCategory
                                        .removeWhere((element) =>
                                    element.id ==
                                        _expenseController
                                            .allExpenseCategory[i]
                                            .id);
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
                                    });
                                  });

                                  await _expenseController
                                      .getAllExpenseCategory(shopId: '${widget.shopId}')
                                      .then((value) {
                                    setState(() {
                                      _expenseController.allExpenseCategory.value =
                                          expenseCategoryResponseModelFromModel(value);
                                      // print(
                                      //     'category: ${_expenseController.allExpenseCategory}');
                                    });
                                  });
                                  Get.back();
                                  Get.back();
                                  Get.back();
                                },
                                style: TextButton.styleFrom(primary: Colors.red),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Icon(Icons.delete),
                                    Text('delete'.tr)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
