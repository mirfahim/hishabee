import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:intl/intl.dart';

import 'employee_expense_edit_delete.dart';


class ExpenseDetailsEmployee extends StatefulWidget {
  String amount;
  String reason;
  String description;
  String types;
  String categoryId;
  String shopId;
  String userId;
  String date;
  String imageUrl;
  String contactName;

  ExpenseDetailsEmployee({this.amount,
    this.reason,
    this.description,
    this.types,
    this.shopId,
    this.categoryId,
    this.userId,
    this.date, this.imageUrl, this.contactName});

  @override
  State<ExpenseDetailsEmployee> createState() => _ExpenseDetailsEmployeeState();
}

class _ExpenseDetailsEmployeeState extends State<ExpenseDetailsEmployee> {
  ExpenseController _expenseController = Get.find();
  TextEditingController _contactName = TextEditingController();
  Shop shop = Get.arguments;

  @override
  void initState() {
    super.initState();
    _contactName.text = widget.contactName;
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
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
                    widget.imageUrl == null ? Get.to(
                        EmployeeExpenseEdit(
                          contactName: widget.contactName,
                          date:
                          widget.date,
                          amount:
                          widget.amount,
                          reason:
                          widget.reason,
                          description:
                          widget.description,
                          types:
                          widget.types,
                          shopId:
                          widget.shopId,
                          categoryId:
                          widget.categoryId,
                          userId:
                          widget.userId,
                        ),
                        arguments: shop) :
                    Get.to(
                        EmployeeExpenseEdit(
                            contactName: widget.contactName,
                          image: File(widget.imageUrl) ,
                          date:
                          widget.date,
                          amount:
                          widget.amount,
                          reason:
                          widget.reason,
                          description:
                          widget.description,
                          types:
                          widget.types,
                          shopId:
                          widget.shopId,
                          categoryId:
                          widget.categoryId,
                          userId:
                          widget.userId,
                        ),
                        arguments: shop);
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
            SizedBox(width: 20,),
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
      ),
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
                      Text('employee_name'.tr, style: TextStyle(fontSize: 16,fontFamily: 'Roboto'),),
                      SizedBox(height: 5,),
                      SizedBox(height: 5,),
                      Container(
                        decoration: Utils.getBoxShape(),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0),
                                child: TextFormField(
                                  enabled: false,
                                  controller: _contactName,
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('amount'.tr, style: TextStyle(fontSize: 16,fontFamily: 'Roboto'),),
                      TextFormField(
                        enabled: false,
                        cursorColor: Colors.black,
                        // controller: texteditingController,
                        // initialValue: mainText,
                        onChanged: (value) {
                          // controller.mobileNumber.value = value;
                        },
                        maxLines: 1,
                        initialValue: widget.amount,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          counterText: "",

                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('purpose'.tr, style: TextStyle(fontSize: 16,fontFamily: 'Roboto'),),
                      TextFormField(
                        enabled: false,
                        cursorColor: Colors.black,
                        // controller: texteditingController,
                        // initialValue: mainText,
                        onChanged: (value) {
                          // controller.mobileNumber.value = value;
                        },
                        maxLines: 1,
                        initialValue: widget.reason,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          counterText: "",

                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('description'.tr, style: TextStyle(fontSize: 16,fontFamily: 'Roboto'),),
                      TextFormField(
                        enabled: false,
                        cursorColor: Colors.black,
                        // controller: texteditingController,
                        // initialValue: mainText,
                        onChanged: (value) {
                          // controller.mobileNumber.value = value;
                        },
                        maxLines: 1,
                        initialValue: widget.description,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          counterText: "",

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
                            child: (widget.imageUrl == null)
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
                              child: CachedNetworkImage(
                                imageUrl: widget.imageUrl,
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context)
                                    .size
                                    .width,
                                height: 100,
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
                                    Text(widget.date),
                                  ],
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
