import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';

// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/due/due_history_details.dart';
import 'package:hishabee_business_manager_fl/models/due/due_item_model.dart';
import 'package:hishabee_business_manager_fl/models/due/due_model.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

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

class DueHistory extends StatefulWidget {
  @override
  State<DueHistory> createState() => _DueHistoryState();
}

class _DueHistoryState extends State<DueHistory> {
  DueController _dueController = Get.find();
  Shop shop = Get.arguments;
  int flag = 3;
  var giveDue;
  var takeDue;

  @override
  void initState() {
    // startDate = 'Start Date';
    // endDate = 'End Date';
    now = DateTime.now();
    day = DateFormat.yMMMMd().format(now);
    dayMain = DateTime.now().day;
    print('dayMain:$dayMain');

    month = DateTime.now().month.toInt();
    print('month: $month');
    year = DateTime.now().year.toInt();
    week = Jiffy([year, month, dayMain]).week;
    weekFirst =
        DateFormat.yMd().format(DateTime.utc(year, month, ((week - 1) * 7)));
    weekLast = DateFormat.yMd()
        .format(DateTime.utc(year, month, ((week - 1) * 7) + 6));

    // print(startOfMonth);
    // print(startOfMonth);
    _dueController.getAllDueHistory(shopId: shop.id, startDate: startOfMonth,
        endDate:lastOfTheMonth ).then((value) {
      if (value != null) {
        // _dueController.dueList.value = getAllDueResponseModelFromJson(value);
        _dueController.dueHistoryList.value =
            getDueItemResponseModelFromJson(value['data']);
      }
      for(int j = 0; j<_dueController.dueHistoryList.length; j++){
        for(int i = 0; i<_dueController.dueHistoryList.length; i++) {
          if(_dueController.dueHistoryList[j].version >= 0){
            if (_dueController.dueHistoryList[i].amount < 0) {
              setState(() {
                giveDue = _dueController.dueHistoryList
                    .map((e) => e.amount)
                    .fold(0, (previousValue, element) => previousValue + element);
              });

            } else{
              setState(() {
                takeDue = _dueController.dueHistoryList
                    .map((e) => e.amount)
                    .fold(0, (previousValue, element) => previousValue + element);
              });

            }
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        backgroundColor: Colors.amber,
        titleSpacing: 0,
        title: Text('due_history'.tr,style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: DEFAULT_BLUE,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'total_due'.tr,
                    style: TextStyle(color: Color(0xFFFECD1A)),
                  ),
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
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 16,
                          )),
                      if (flag == 1)
                        Text(
                          DateFormat.yMMMMd().format(now),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16),
                        ),
                      if (flag == 2)
                        Text(
                          '$weekFirst - $weekLast',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16),
                        ),
                      if (flag == 4)
                        Text(
                          '$year',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16),
                        ),
                      if (flag == 3)
                        Text(
                          months[month - 1],
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16),
                        ),
                      IconButton(
                          onPressed: () {
                            if (flag == 1) {
                              dayAdd();
                            } else if (flag == 3) {
                              monthAdd();
                            } else if (flag == 4) {
                              yearAdd();
                            } else if (flag == 2) {
                              weekAdd();
                            }
                          },
                          icon: Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 16))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60,
                        width: size.width / 2.5,
                        decoration: BoxDecoration(
                          color: Color(0xFFC4C4C4).withOpacity(.35),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                '৳$giveDue',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'lend'.tr,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: size.width / 2.5,
                        decoration: BoxDecoration(
                          color: Color(0xFFC4C4C4).withOpacity(.35),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                '৳$takeDue',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'borrowed'.tr,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
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
                          _dueController
                              .getAllDueHistory(
                              shopId: '${shop.id}',
                              startDate: "$now",
                              endDate: "$now")
                              .then((value) {
                            _dueController.dueHistoryList.value =
                                getDueItemResponseModelFromJson(value['data']);
                            // setState(() {

                              // _expenseController.totalExpense.value =
                              //     _expenseController.allExpenseList
                              //         .map((e) => e.amount)
                              //         .fold(
                              //         0,
                              //             (previousValue, element) =>
                              //         previousValue + element);
                            // });
                          });
                          // _expenseController.totalExpense.value = _expenseController
                          //     .allExpenseList
                          //     .map((e) => e.amount)
                          //     .fold(0, (previousValue, element) => previousValue + element);
                          // print(
                          //     'expense list: ${_expenseController.allExpenseList.value}');
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
                          _dueController
                              .getAllDueHistory(
                              shopId: '${shop.id}',
                              startDate: "$startOfTheWeek",
                              endDate: "$now")
                              .then((value) {
                            _dueController.dueHistoryList.value =
                                getDueItemResponseModelFromJson(value['data']);
                            // setState(() {

                              // _expenseController.totalExpense.value =
                              //     _expenseController.allExpenseList
                              //         .map((e) => e.amount)
                              //         .fold(
                              //         0,
                              //             (previousValue, element) =>
                              //         previousValue + element);
                            // });
                          });
                          // _expenseController.totalExpense.value = _expenseController
                          //     .allExpenseList
                          //     .map((e) => e.amount)
                          //     .fold(0, (previousValue, element) => previousValue + element);
                          // print('expense list: ${_expenseController.allExpenseList.value}');
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
                          _dueController
                              .getAllDueHistory(
                              shopId: '${shop.id}',
                              startDate: "$startOfMonth",
                              endDate: "$lastOfTheMonth")
                              .then((value) {
                            setState(() {
                              _dueController.dueHistoryList.value =
                                  getDueItemResponseModelFromJson(value['data']);
                              // _dueController.totalExpense.value =
                              //     _expenseController.allExpenseList
                              //         .map((e) => e.amount)
                              //         .fold(
                              //         0,
                              //             (previousValue, element) =>
                              //         previousValue + element);
                            });
                          });
                          // _expenseController.totalExpense.value = _expenseController
                          //     .allExpenseList
                          //     .map((e) => e.amount)
                          //     .fold(0, (previousValue, element) => previousValue + element);
                          // print('expense list: ${_expenseController.allExpenseList.value}');
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
                          _dueController
                              .getAllDueHistory(
                              shopId: '${shop.id}',
                              startDate: "$startOfTheYear",
                              endDate: "$now")
                              .then((value) {
                            _dueController.dueHistoryList.value =
                                getDueItemResponseModelFromJson(value['data']);
                          });
                          // _expenseController.totalExpense.value = _expenseController
                          //     .allExpenseList
                          //     .map((e) => e.amount)
                          //     .fold(0, (previousValue, element) => previousValue + element);
                          // print('expense list: ${_expenseController.allExpenseList.value}');
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
            Obx(()=>Expanded(
                child: ListView.builder(
                itemCount: _dueController.dueHistoryList.length,
                itemBuilder: (context, index){
                  return _dueController.dueHistoryList[index].version <0 ? Container():
                  InkWell(
                      onTap: (){
                        Get.to(DueHistoryDetails(
                          amount: _dueController.dueHistoryList[index].amount,
                          description: _dueController.dueHistoryList[index].note,
                          image: _dueController.dueHistoryList[index].image,
                          createdAt: _dueController.dueHistoryList[index].createdAt,
                          updatedAt: _dueController.dueHistoryList[index].updatedAt,
                          uniqueId: _dueController.dueHistoryList[index].uniqueId,
                          dueLeft: _dueController.dueHistoryList[index].uniqueId,
                          dueUniqueId: _dueController.dueHistoryList[index].dueLeft,
                          name: _dueController.dueHistoryList[index].contactName,
                          dueType: _dueController.dueHistoryList[index].type,
                          // dueTotalAmount: ,
                          // dueTakerType: _dueController.dueHistoryList[index].type,
                          version: _dueController.dueHistoryList[index].version,
                        ), arguments: shop);
                      },
                    child: ListTile(
                      leading: Image.asset('images/assets/emptyImage.png'),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('${_dueController.dueHistoryList[index].contactName}'),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${_dueController.dueHistoryList[index].contactMobile}'),
                          Text('${DateFormat.yMMMd().format(_dueController.dueHistoryList[index].createdAt)}')
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            '৳${_dueController.dueHistoryList[index].amount}',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          ),
                          Text('${_dueController.dueHistoryList[index].contactType}'),
                        ],
                      ),
                    ),
                  );
                })))

          ],
        ),
      ),
    );
  }

  void getDataForDropDown(var startDate, var endDate) {
    _dueController
        .getAllDueHistory(
            shopId: '${shop.id}', startDate: "$startDate", endDate: "$endDate")
        .then((value) {
      if (value != null) {
        _dueController.dueHistoryList.value =
            getDueItemResponseModelFromJson(value['data']);
        for(int j = 0; j<_dueController.dueHistoryList.length; j++){
          for(int i = 0; i<_dueController.dueHistoryList.length; i++) {
            if(_dueController.dueHistoryList[j].version >= 0){
              if (_dueController.dueHistoryList[i].amount < 0) {
                setState(() {
                  giveDue = _dueController.dueHistoryList
                      .map((e) => e.amount)
                      .fold(0, (previousValue, element) => previousValue + element);
                });

              } else{
                setState(() {
                  takeDue = _dueController.dueHistoryList
                      .map((e) => e.amount)
                      .fold(0, (previousValue, element) => previousValue + element);
                });

              }
            }
          }
        }
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
      month = Jiffy([
        year,
        month,
        Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime.day
      ]).subtract(months: 1).month;
      print(Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime.day);
      print(Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
    });
    getDataForDropDown(
        Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime,
        Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
  }

  monthAdd() {
    setState(() {
      month = Jiffy([
        year,
        month,
        Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime.day
      ]).add(months: 1).month;
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

  weekMinus() {
    setState(() {
      // week = Jiffy([year, month, dayMain]).subtract(weeks: 1).week;
      // weekDay = ((week-1)*7) + (true ? 0 : 6);
      // print(DateTime.utc(year, 1, weekDay));
      final now = DateTime.now();
      final diff = now.difference(startOfTheWeek).inDays;
      return diff <= 7;
    });
  }

  weekAdd() {
    setState(() {
      week = Jiffy([year, month, dayMain]).subtract(weeks: 1).week;
      weekDay = ((week - 1) * 7) + (false ? 0 : 6);
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
