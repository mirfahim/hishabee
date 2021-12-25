import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:intl/intl.dart';

import 'expense_details_edit_delete.dart';


var now;
var day;

var startOfTheWeek = now.subtract(Duration(days: now.weekday - 1));
var endOfTheWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);
var startOfTheYear = DateTime(DateTime.now().year);

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
  var getShopId = GetStorage();
  int flag = 1;
  @override
  void initState() {
    startDate = 'Start Date';
    endDate = 'End Date';
    now = DateTime.now();
    day = DateFormat.yMMMMd().format(now);
    dayMain = DateTime.now().day.toInt();
    month = DateTime.now().month.toInt();
    year = DateTime.now().year.toInt();
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
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text('Expense book'),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: height,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: DEFAULT_BLUE,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Total Cost'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (flag == 1) {
                                    setState(() {
                                    });
                                    // dayMinus();
                                  } else if (flag == 3) {
                                    // monthMinus();
                                  } else if (flag == 4) {
                                    // yearMinus();
                                  } else if (flag == 2) {
                                    // weekMinus();
                                  }
                                },
                                icon: Icon(Icons.arrow_back_ios)),
                            if (flag == 1)
                              Text(DateFormat.yMMMMd().format(now)),
                            if (flag == 2)
                              Text(
                                  '${DateFormat.yMMMMd().format(startOfTheWeek)} - ${DateFormat.yMMMMd().format(endOfTheWeek)}'),
                            if (flag == 4) Text('$year'),
                            if (flag == 3) Text(months[month - 1]),
                            IconButton(
                                onPressed: () {
                                  if (flag == 1) {
                                    setState(() {
                                      // controller.countAdd.value++;
                                    });
                                    // dayAdd();
                                  } else if (flag == 3) {
                                    setState(() {});
                                    // monthAdd();
                                  } else if (flag == 4) {
                                    // yearAdd();
                                  }
                                },
                                icon: Icon(Icons.arrow_forward_ios))
                          ],
                        ),
                        Obx(()=>Text('${_expenseController.totalExpense.value}'))
                      ],
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
                                // controller
                                //     .fetchEmployeWiseReport(
                                //     shopId:
                                //     '${getStorageId.read('shop_id')}',
                                //     startDate: "$now",
                                //     endDate: "$now")
                                //     .then((value) {
                                //   if (value != null) {
                                //     setState(() {
                                //       _list =
                                //           employeReportModelFromJson(
                                //               value);
                                //       _foundData = _list;
                                //       print(getStorageId
                                //           .read('shop_id'));
                                //       print(now);
                                //       // checkingDone = true;
                                //     });
                                //   }
                                //
                                //   //  isLoading = false;
                                // });
                              });
                            },
                            child: Text(
                              'Day',
                              style: TextStyle(
                                  color:
                                      flag == 1 ? Colors.white : Colors.black,
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
                                // controller
                                //     .fetchEmployeWiseReport(
                                //     shopId:
                                //     '${getStorageId.read('shop_id')}',
                                //     startDate: "$startOfTheWeek",
                                //     endDate: "$now")
                                //     .then((value) {
                                //   if (value != null) {
                                //     setState(() {
                                //       _list =
                                //           employeReportModelFromJson(
                                //               value);
                                //       _foundData = _list;
                                //       print(getStorageId
                                //           .read('shop_id'));
                                //       print(startOfTheWeek);
                                //       print(now);
                                //       // checkingDone = true;
                                //     });
                                //   }
                                //
                                //   //  isLoading = false;
                                // });
                              });
                            },
                            child: Text(
                              'Week',
                              style: TextStyle(
                                  color:
                                      flag == 2 ? Colors.white : Colors.black,
                                  fontSize: 10),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
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
                                // controller
                                //     .fetchEmployeWiseReport(
                                //     shopId:
                                //     '${getStorageId.read('shop_id')}',
                                //     startDate: "$startOfMonth",
                                //     endDate: "$lastOfTheMonth")
                                //     .then((value) {
                                //   if (value != null) {
                                //     setState(() {
                                //       _list =
                                //           employeReportModelFromJson(
                                //               value);
                                //       _foundData = _list;
                                //       print(getStorageId
                                //           .read('shop_id'));
                                //       print(startOfMonth);
                                //       print(lastOfTheMonth);
                                //       // checkingDone = true;
                                //     });
                                //   }
                                //
                                //   //  isLoading = false;
                                // });
                              });
                            },
                            child: Text(
                              'Month',
                              style: TextStyle(
                                  color:
                                      flag == 3 ? Colors.white : Colors.black,
                                  fontSize: 10),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
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
                                // controller
                                //     .fetchEmployeWiseReport(
                                //     shopId:
                                //     '${getStorageId.read('shop_id')}',
                                //     startDate: "$startOfTheYear",
                                //     endDate: "$now")
                                //     .then((value) {
                                //   if (value != null) {
                                //     setState(() {
                                //       _list =
                                //           employeReportModelFromJson(
                                //               value);
                                //       _foundData = _list;
                                //       print(getStorageId
                                //           .read('shop_id'));
                                //       print(startOfTheYear);
                                //       print(now);
                                //       // checkingDone = true;
                                //     });
                                //   }
                                //
                                //   //  isLoading = false;
                                // });
                              });
                            },
                            child: Text(
                              'Year',
                              style: TextStyle(
                                  color:
                                      flag == 4 ? Colors.white : Colors.black,
                                  fontSize: 10),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        height: 350,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _expenseController.allExpenseList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                      ExpenseEditDelete(
                                        amount:
                                            '${_expenseController.allExpenseList[index].amount}',
                                        reason:
                                            '${_expenseController.allExpenseList[index].purpose}',
                                        description:
                                            '${_expenseController.allExpenseList[index].details}',
                                        types:
                                            '${_expenseController.allExpenseList[index].type}',
                                        shopId:
                                            '${_expenseController.allExpenseList[index].shopId}',
                                        categoryId:
                                            '${_expenseController.allExpenseList[index].id}',
                                        userId:
                                            '${_expenseController.allExpenseList[index].userId}',
                                      ),
                                      arguments: shop);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(
                                        0xFFF1F1F1,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                '${_expenseController.allExpenseList[index].purpose}'),
                                            Text(
                                                'Type: ${_expenseController.allExpenseList[index].type}'),
                                            Text(
                                                '${DateFormat.yMMMMd().format(_expenseController.allExpenseList[index].createdAt)}')
                                          ],
                                        ),
                                        Text(
                                            '${_expenseController.allExpenseList[index].amount}')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'Octobar',
    'November',
    'December'
  ];
}
