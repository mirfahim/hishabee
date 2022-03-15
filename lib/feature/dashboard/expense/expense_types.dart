import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import 'expense_details_edit_delete.dart';
import 'expense_front.dart';
import 'expense_total_details.dart';


var now;
var day;
var firstDayOfWeek;
var lastDayOfWeek;
var startOfTheWeek = now.subtract(Duration(days: now.weekday - 1));
var endOfTheWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);
var startOfTheYear = DateTime(DateTime.now().year);
var weekDay;
var weekFirst;
var weekLast;

int year;
int month;
int week;
var dayMain;
DateTime firstDatePicked;
DateTime endDatePicked;
var startDate;
var endDate;

class ExpenseList2 extends StatefulWidget {
  @override
  _ExpenseList2State createState() => _ExpenseList2State();
}

class _ExpenseList2State extends State<ExpenseList2> {
  Shop shop = Get.arguments;
  ExpenseController _expenseController = Get.find();
  List<ExpenseResponseModel> _expenseList;
  ExpenseResponseModel _expenseResponseModel;
  var getShopId = GetStorage();
  int flag = 3;
  @override
  void initState() {
    startDate = 'Start Date';
    endDate = 'End Date';
    now = DateTime.now();
    day = DateFormat.yMMMMd().format(now);
    dayMain = DateTime.now().day;
    print('dayMain:$dayMain');

    month = DateTime.now().month.toInt();
    print('month: $month');
    year = DateTime.now().year.toInt();
    week = Jiffy([year, month, dayMain]).week;
    weekFirst = DateFormat.yMd().format(DateTime.utc(year, month, ((week-1)*7))) ;
    weekLast = DateFormat.yMd().format(DateTime.utc(year, month, ((week-1)*7) + 6));
    _expenseController
        .getAllExpense(
        shopId: '${shop.id}',
        userId: '${shop.userId}',
        startDate: '$startOfMonth',
        endDate: '$lastOfTheMonth')
        .then((value) {
      // setState(() {
      _expenseController.allExpenseList.value = getExpenseFromModel(value);
      _expenseController.totalExpense.value = _expenseController.allExpenseList
          .map((e) => e.amount)
          .fold(0, (previousValue, element) => previousValue + element);
      _expenseController.totalFixedExpense.value =
          _expenseController.totalExpense.value;
      // _isLoading = false;

      // });
    });
    super.initState();
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
        title:  Text('expense_book'.tr, style: TextStyle(
            color: Colors.black
        ),),
        backgroundColor: bgColor,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Container(
          // height: height,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              children: [
                Container(
                  // height: 250,
                  decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('total_cost'.tr,style: TextStyle(
                            color: Color(0xFFFECD1A),
                            fontFamily: 'Roboto',
                            fontSize: 16),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (flag == 1) {
                                    setState(() {
                                      dayMinus();
                                      // day = DateFormat.yMMMMd().format(now);
                                    });
                                    // dayMinus();
                                  } else if (flag == 3) {
                                    monthMinus();
                                  } else if (flag == 4) {
                                    yearMinus();
                                  } else if (flag == 2) {
                                    weekMinus();
                                  }
                                },
                                icon: Icon(Icons.arrow_back_ios, color: Colors.white,size: 16,)),
                            if (flag == 1) Text(DateFormat.yMMMMd().format(now),style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 16),),
                            if (flag == 2)
                              Text(
                                '$weekFirst - $weekLast',style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 16),),
                            if (flag == 4) Text('$year',style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 16),),
                            if (flag == 3) Text(months[month - 1],style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 16),),
                            IconButton(
                                onPressed: () {
                                  if (flag == 1) {
                                    dayAdd();
                                  } else if (flag == 3) {
                                    monthAdd();
                                  } else if (flag == 4) {
                                    yearAdd();
                                  } else if(flag == 2){
                                    weekAdd();
                                  }
                                },
                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white,size: 16))
                          ],
                        ),
                        Obx(() =>
                            Text('৳ ${_expenseController.totalExpense.value}',style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 16),))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 27,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              flag = 1;
                              _expenseController
                                  .getAllExpense(
                                  shopId: '${shop.id}',
                                  startDate: "$now",
                                  endDate: "$now")
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
                                });
                              });
                              // _expenseController.totalExpense.value = _expenseController
                              //     .allExpenseList
                              //     .map((e) => e.amount)
                              //     .fold(0, (previousValue, element) => previousValue + element);
                              print(
                                  'expense list: ${_expenseController.allExpenseList.value}');
                            });
                          },
                          child: Text(
                            'day'.tr,
                            style: TextStyle(
                                color: flag == 1 ? Colors.white : Colors.black,
                                fontSize: 10),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 1, color: Colors.black),
                            primary: flag == 1 ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 27,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              flag = 2;
                              _expenseController
                                  .getAllExpense(
                                  shopId: '${shop.id}',
                                  startDate: "$startOfTheWeek",
                                  endDate: "$now")
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
                                });
                              });
                              // _expenseController.totalExpense.value = _expenseController
                              //     .allExpenseList
                              //     .map((e) => e.amount)
                              //     .fold(0, (previousValue, element) => previousValue + element);
                              print(
                                  'expense list: ${_expenseController.allExpenseList.value}');
                            });
                          },
                          child: Text(
                            'week'.tr,
                            style: TextStyle(
                                color: flag == 2 ? Colors.white : Colors.black,
                                fontSize: 10),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side:
                            const BorderSide(width: 1, color: Colors.black),
                            primary: flag == 2 ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 27,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              flag = 3;
                              _expenseController
                                  .getAllExpense(
                                  shopId: '${shop.id}',
                                  startDate: "$startOfMonth",
                                  endDate: "$lastOfTheMonth")
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
                                });
                              });
                              // _expenseController.totalExpense.value = _expenseController
                              //     .allExpenseList
                              //     .map((e) => e.amount)
                              //     .fold(0, (previousValue, element) => previousValue + element);
                              print(
                                  'expense list: ${_expenseController.allExpenseList.value}');
                            });
                          },
                          child: Text(
                            'month'.tr,
                            style: TextStyle(
                                color: flag == 3 ? Colors.white : Colors.black,
                                fontSize: 10),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side:
                            const BorderSide(width: 1, color: Colors.black),
                            primary: flag == 3 ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 27,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              flag = 4;
                              _expenseController
                                  .getAllExpense(
                                  shopId: '${shop.id}',
                                  startDate: "$startOfTheYear",
                                  endDate: "$now")
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
                                });
                              });
                              // _expenseController.totalExpense.value = _expenseController
                              //     .allExpenseList
                              //     .map((e) => e.amount)
                              //     .fold(0, (previousValue, element) => previousValue + element);
                              print(
                                  'expense list: ${_expenseController.allExpenseList.value}');
                            });
                          },
                          child: Text(
                            'year'.tr,
                            style: TextStyle(
                                color: flag == 4 ? Colors.white : Colors.black,
                                fontSize: 10),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side:
                            const BorderSide(width: 1, color: Colors.black),
                            primary: flag == 4 ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          child: _expenseController.allExpenseList.length != 0
                              ? ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                            _expenseController.allExpenseList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    print('Image from details ${_expenseController.allExpenseList[index].image}');
                                    Get.to(ExpenseTotalDetails(

                                      imageUrl: _expenseController.allExpenseList[index].image,
                                            date: '${DateFormat.yMMMMd().format(_expenseController.allExpenseList[index].createdAt)}',
                                            amount:
                                            '${_expenseController.allExpenseList[index].amount}',
                                            reason:
                                            '${_expenseController.allExpenseList[index].purpose}',
                                            description:
                                            '${_expenseController.allExpenseList[index].details}' == 'null' ? '[Not Given]' : '${_expenseController.allExpenseList[index].details}',
                                            types:
                                            '${_expenseController.allExpenseList[index].type}',
                                            shopId:
                                            '${_expenseController.allExpenseList[index].shopId}',
                                            categoryId:
                                            '${_expenseController.allExpenseList[index].id}',
                                            userId:
                                            '${_expenseController.allExpenseList[index].userId}',
                                    ), arguments: shop);
                                    // Get.to(
                                    //     ExpenseEditDelete(
                                    //       date: '${DateFormat.yMMMMd().format(_expenseController.allExpenseList[index].createdAt)}',
                                    //       amount:
                                    //       '${_expenseController.allExpenseList[index].amount}',
                                    //       reason:
                                    //       '${_expenseController.allExpenseList[index].purpose}',
                                    //       description:
                                    //       '${_expenseController.allExpenseList[index].details}',
                                    //       types:
                                    //       '${_expenseController.allExpenseList[index].type}',
                                    //       shopId:
                                    //       '${_expenseController.allExpenseList[index].shopId}',
                                    //       categoryId:
                                    //       '${_expenseController.allExpenseList[index].id}',
                                    //       userId:
                                    //       '${_expenseController.allExpenseList[index].userId}',
                                    //     ),
                                    //     arguments: shop);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(
                                          0xFFF1F1F1,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${_expenseController.allExpenseList[index].purpose}', style: TextStyle(
                                                    fontSize: 14, fontFamily: 'Roboto',color: Color(0xFF232323)
                                                ),),
                                                SizedBox(height: 3,),
                                                Text(
                                                    'Type: ${_expenseController.allExpenseList[index].type}', style: TextStyle(
                                                    fontSize: 14, fontFamily: 'Roboto',color: Color(0xFF707070)
                                                ),),
                                                SizedBox(height: 3,),
                                                Text(
                                                    '${DateFormat.yMMMMd().format(_expenseController.allExpenseList[index].createdAt)}', style: TextStyle(
                                                    fontSize: 12, fontFamily: 'Roboto',color: Color(0xFF707070)
                                                ),)
                                              ],
                                            ),
                                          ),
                                          Text(
                                              '৳ ${_expenseController.allExpenseList[index].amount}', style: TextStyle(
                                            fontSize: 18, fontFamily: 'Roboto'
                                          ),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                              : Container(
                            child: Center(child: Text('No Data to Show')),
                          ),
                        ),
                      ),
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

  void getDataForDropDown(var startDate, var endDate) {
    _expenseController
        .getAllExpense(
        shopId: '${shop.id}', startDate: "$startDate", endDate: "$endDate")
        .then((value) {
      if (value != null) {
        setState(() {
          _expenseController.allExpenseList.value = getExpenseFromModel(value);
          _expenseController.totalExpense.value = _expenseController
              .allExpenseList
              .map((e) => e.amount)
              .fold(0, (previousValue, element) => previousValue + element);
          print('expense list: ${_expenseController.allExpenseList.value}');
        });
      }

      //  isLoading = false;
    });
  }

  dayMinus() {
    setState(() {
      now = now.subtract(Duration(days: 1));
      print(now);
    });
    getDataForDropDown(now, now);
  }

  dayAdd() {
    setState(() {
      now = now.add(Duration(days: 1));
    });
    getDataForDropDown(now, now);
  }

  monthMinus() {
    setState(() {
      month = Jiffy([year, month, Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime.day]).subtract(months: 1).month;
      print(Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime.day);
      print(Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
    });
    getDataForDropDown(
        Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime,
        Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
  }

  monthAdd() {
    setState(() {
      month = Jiffy([year, month, Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime.day]).add(months: 1).month;
    });
    getDataForDropDown(
        Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime,
        Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
  }

  yearMinus() {
    setState(() {
      year = Jiffy([year, month, dayMain]).subtract(years: 1).year;
      print(Jiffy([year, month, dayMain]).startOf(Units.YEAR).dateTime);
      print(Jiffy([year, month, dayMain]).endOf(Units.YEAR).dateTime);
    });
    getDataForDropDown(
        Jiffy([year, month, dayMain]).startOf(Units.YEAR).dateTime,
        Jiffy([year, month, dayMain]).endOf(Units.YEAR).dateTime);
  }

  yearAdd() {
    setState(() {
      year = Jiffy([year, month, dayMain]).add(years: 1).year;
      print(year);
    });
    getDataForDropDown(
        Jiffy([year, month, dayMain]).startOf(Units.YEAR).dateTime,
        Jiffy([year, month, dayMain]).endOf(Units.YEAR).dateTime);
  }

  weekMinus(){
    setState(() {
      // week = Jiffy([year, month, dayMain]).subtract(weeks: 1).week;
      // weekDay = ((week-1)*7) + (true ? 0 : 6);
      // print(DateTime.utc(year, 1, weekDay));
      final now = DateTime.now();
      final diff = now.difference(startOfTheWeek).inDays;
      return diff <= 7;
    });
  }
  weekAdd(){
    setState(() {
      week = Jiffy([year, month, dayMain]).subtract(weeks: 1).week;
      weekDay = ((week-1)*7) + (false ? 0 : 6);
      print(DateTime.utc(year, month, weekDay));
    });
  }
  List<String> months = [
    'January'.tr,
    'February'.tr,
    'March'.tr,
    'April'.tr,
    'May'.tr,
    'June'.tr,
    'July'.tr,
    'August'.tr,
    'September'.tr,
    'October'.tr,
    'November'.tr,
    'December'.tr
  ];
}
