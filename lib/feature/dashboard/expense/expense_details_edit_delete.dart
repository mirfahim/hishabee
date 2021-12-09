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
    String labelText,
    IconButton iconButton,
    int maxLine,
    TextEditingController texteditingController}) {
  return TextFormField(
    cursorColor: Colors.black,
    minLines: maxLine,
    controller: texteditingController,
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

var now = DateTime.now();

class ExpenseEditDelete extends StatefulWidget {
  String amount;
  String reason;
  String description;
  String types;
  String categoryId;
  String shopId;
  String userId;

  ExpenseEditDelete(
      {this.amount,
      this.reason,
      this.description,
      this.types,
      this.shopId,
      this.categoryId,
      this.userId});

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

  DateTime startDate = DateTime.now();

  DateTime endDate;

  void getDialog() async {
    await _selectStartDate(context);
    // await _selectEndDate(context);
    // widget.controller.getRangeTransaction();
  }

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "start_date".tr,
      context: context,
      initialDate: startDate,
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
        // widget.controller.selectedStartDate.value = picked;
        startDate = picked;
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
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('New Expense'),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
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
                    const Text('Name of type of the Expense'),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormFeildForExpense(
                        hintText: '${widget.amount}',
                        texteditingController: _textEditingControllerAmount),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormFeildForExpense(
                        hintText: '${widget.reason}',
                        texteditingController: _textEditingControllerReason),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormFeildForExpense(
                        hintText: '${widget.description}',
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
                                Text(
                                    '${DateFormat.yMMMMd().format(startDate)}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: const Center(
                    //     child: Text(
                    //       'Enter',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(color: Colors.white, fontSize: 12),
                    //     ),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     primary: DEFAULT_BLUE,
                    //     fixedSize: Size(width, 40),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(2),
                    //     ),
                    //   ),
                    // ),
                    TextButton(
                      onPressed: () {
                        _expenseController.updateExpense(
                          shopId: widget.shopId,
                          categoryid: widget.categoryId,
                          type: widget.types,
                          purpose: _textEditingControllerReason.text,
                          description: _textEditingControllerDescription.text,
                          amount: _textEditingControllerAmount.text,
                        );

                        _expenseController
                            .getAllExpense(
                                shopId: '${widget.shopId}',
                                userId: '${widget.userId}')
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
                            // _isLoading = false;
                            // print('expense list: ${_expenseController.allExpenseList.value}');
                          });
                        });
                        _expenseController
                            .getAllExpense(
                                shopId: '${widget.shopId}',
                                userId: '${widget.userId}')
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
                            // _isLoading = false;
                            print(
                                'expense list: ${_expenseController.allExpenseList.value}');
                          });
                        });

                        _expenseController
                            .getAllExpenseCategory(shopId: '${widget.shopId}')
                            .then((value) {
                          setState(() {
                            _expenseController.allExpenseCategory.value =
                                expenseCategoryResponseModelFromModel(value);
                            print(
                                'category: ${_expenseController.allExpenseCategory}');
                          });
                        });
                      },
                      style: TextButton.styleFrom(primary: Colors.blue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.edit),
                          Text('Edit the type')
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        _expenseController.deleteExpense(
                            categoryid: widget.categoryId);

                        await _expenseController
                            .getAllExpense(
                                shopId: '${widget.shopId}',
                                userId: '${widget.userId}')
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
                            // _isLoading = false;
                            // print('expense list: ${_expenseController.allExpenseList.value}');
                          });
                        });
                        await _expenseController
                            .getAllExpense(
                                shopId: '${widget.shopId}',
                                userId: '${widget.userId}')
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
                            // _isLoading = false;
                            // print(
                            // 'expense list: ${_expenseController.allExpenseList.value}');
                          });
                        });

                        await _expenseController
                            .getAllExpenseCategory(shopId: '${widget.shopId}')
                            .then((value) {
                          setState(() {
                            _expenseController.allExpenseCategory.value =
                                expenseCategoryResponseModelFromModel(value);
                            print(
                                'category: ${_expenseController.allExpenseCategory}');
                          });
                        });
                      },
                      style: TextButton.styleFrom(primary: Colors.red),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.delete),
                          Text('Delete the type')
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
