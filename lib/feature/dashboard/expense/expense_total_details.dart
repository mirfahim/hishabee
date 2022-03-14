import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'expense_details_edit_delete.dart';

class ExpenseTotalDetails extends StatelessWidget {
  String amount;
  String reason;
  String description;
  String types;
  String categoryId;
  String shopId;
  String userId;
  String date;
  String imageUrl;

  ExpenseTotalDetails({this.amount,
    this.reason,
    this.description,
    this.types,
    this.shopId,
    this.categoryId,
    this.userId,
    this.date, this.imageUrl});
  ExpenseController _expenseController = Get.find();
  Shop shop = Get.arguments;
  @override
  Widget build(BuildContext context) {
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
                      TextFormField(
                        enabled: false,
                        cursorColor: Colors.black,
                        // controller: texteditingController,
                        // initialValue: mainText,
                        onChanged: (value) {
                          // controller.mobileNumber.value = value;
                        },
                        maxLines: 1,
                        initialValue: amount,
                        decoration: InputDecoration(
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

                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                        initialValue: reason,
                        decoration: InputDecoration(
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

                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                        initialValue: description,
                        decoration: InputDecoration(
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
                            child: (_expenseController.image.value == null)
                                ? Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black)),
                              child: Icon(Icons.camera_alt),
                            )
                                : Obx(()=>
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.file(
                                    _expenseController.image.value,
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
                                    Text(date),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                  Get.to(
                                      ExpenseEditDelete(
                                        date:
                                            date,
                                        amount:
                                            amount,
                                        reason:
                                            reason,
                                        description:
                                            description,
                                        types:
                                            types,
                                        shopId:
                                            shopId,
                                        categoryId:
                                            categoryId,
                                        userId:
                                            userId,
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
