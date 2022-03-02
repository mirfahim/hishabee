import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_pages/updated_UI/controller/due_history_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_pages/updated_UI/due_history_edit_delete.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'model/due_history.dart';
var now;
var day;

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
  _DueHistoryState createState() => _DueHistoryState();
}

class _DueHistoryState extends State<DueHistory> {
  DueHistoryModel _dueHistory;
  DueControllerNew _dueController = Get.find();
  int flag = 3;
  bool _isLoading = false;
  // List<DueHistory> dueHistoryList = [];
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
    weekFirst = DateTime.utc(year, month, ((week-1)*7));
    weekLast = DateTime.utc(year, month, ((week-1)*7) + 6);

    _dueController.getAllDueHistory(shopId: '18', startDate: '2022-01-01', endDate: '2022-06-01')
        .then((value){
      _dueController.dueHistory.value = dueHistoryFromJsonDynamic(value);
      print('length of due: ${_dueController.dueHistory.value.data.length}');
      setState(() {
        _dueHistory = dueHistoryFromJsonDynamic(value);
        _isLoading = false;
        print('length of due: ${_dueHistory.data.length}');
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'due_history'.tr,
          style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.amber,
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        opacity: 1,
        child:_dueHistory!= null ?  Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
              child: Container(
                // height: 250,
                decoration: BoxDecoration(
                    color: DEFAULT_BLUE,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('total_due'.tr,style: TextStyle(
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
                              '${DateFormat.yMMMMd().format(startOfTheWeek)} - ${DateFormat.yMMMMd().format(endOfTheWeek)}',style: TextStyle(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFC4C4C4).withOpacity(.35),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '৳700',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'give/due'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFC4C4C4).withOpacity(.35),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '৳700',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'receive/taken'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 27,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            flag = 1;
                            // _expenseController
                            //     .getAllExpense(
                            //     shopId: '${shop.id}',
                            //     startDate: "$now",
                            //     endDate: "$now")
                            //     .then((value) {
                            //   setState(() {
                            //     _expenseController.allExpenseList.value =
                            //         getExpenseFromModel(value);
                            //     _expenseController.totalExpense.value =
                            //         _expenseController.allExpenseList
                            //             .map((e) => e.amount)
                            //             .fold(
                            //             0,
                            //                 (previousValue, element) =>
                            //             previousValue + element);
                            //   });
                            // });
                            // // _expenseController.totalExpense.value = _expenseController
                            // //     .allExpenseList
                            // //     .map((e) => e.amount)
                            // //     .fold(0, (previousValue, element) => previousValue + element);
                            // print(
                            //     'expense list: ${_expenseController.allExpenseList.value}');
                          });
                        },
                        child: Text(
                          'day'.tr,
                          style: TextStyle(
                              color: flag == 1 ? Colors.white : Colors.black,
                              fontSize: 12),
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
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 27,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            flag = 2;
                            // _expenseController
                            //     .getAllExpense(
                            //     shopId: '${shop.id}',
                            //     startDate: "$startOfTheWeek",
                            //     endDate: "$now")
                            //     .then((value) {
                            //   setState(() {
                            //     _expenseController.allExpenseList.value =
                            //         getExpenseFromModel(value);
                            //     _expenseController.totalExpense.value =
                            //         _expenseController.allExpenseList
                            //             .map((e) => e.amount)
                            //             .fold(
                            //             0,
                            //                 (previousValue, element) =>
                            //             previousValue + element);
                            //   });
                            // });
                            // // _expenseController.totalExpense.value = _expenseController
                            // //     .allExpenseList
                            // //     .map((e) => e.amount)
                            // //     .fold(0, (previousValue, element) => previousValue + element);
                            // print(
                            //     'expense list: ${_expenseController.allExpenseList.value}');
                          });
                        },
                        child: Text(
                          'week'.tr,
                          style: TextStyle(
                              color: flag == 2 ? Colors.white : Colors.black,
                              fontSize: 12),
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
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 27,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            flag = 3;
                            // _expenseController
                            //     .getAllExpense(
                            //     shopId: '${shop.id}',
                            //     startDate: "$startOfMonth",
                            //     endDate: "$lastOfTheMonth")
                            //     .then((value) {
                            //   setState(() {
                            //     _expenseController.allExpenseList.value =
                            //         getExpenseFromModel(value);
                            //     _expenseController.totalExpense.value =
                            //         _expenseController.allExpenseList
                            //             .map((e) => e.amount)
                            //             .fold(
                            //             0,
                            //                 (previousValue, element) =>
                            //             previousValue + element);
                            //   });
                            // });
                            // // _expenseController.totalExpense.value = _expenseController
                            // //     .allExpenseList
                            // //     .map((e) => e.amount)
                            // //     .fold(0, (previousValue, element) => previousValue + element);
                            // print(
                            //     'expense list: ${_expenseController.allExpenseList.value}');
                          });
                        },
                        child: Text(
                          'month'.tr,
                          style: TextStyle(
                              color: flag == 3 ? Colors.white : Colors.black,
                              fontSize: 12),
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
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 27,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            flag = 4;
                            // _expenseController
                            //     .getAllExpense(
                            //     shopId: '${shop.id}',
                            //     startDate: "$startOfTheYear",
                            //     endDate: "$now")
                            //     .then((value) {
                            //   setState(() {
                            //     _expenseController.allExpenseList.value =
                            //         getExpenseFromModel(value);
                            //     _expenseController.totalExpense.value =
                            //         _expenseController.allExpenseList
                            //             .map((e) => e.amount)
                            //             .fold(
                            //             0,
                            //                 (previousValue, element) =>
                            //             previousValue + element);
                            //   });
                            // });
                            // // _expenseController.totalExpense.value = _expenseController
                            // //     .allExpenseList
                            // //     .map((e) => e.amount)
                            // //     .fold(0, (previousValue, element) => previousValue + element);
                            // print(
                            //     'expense list: ${_expenseController.allExpenseList.value}');
                          });
                        },
                        child: Text(
                          'year'.tr,
                          style: TextStyle(
                              color: flag == 4 ? Colors.white : Colors.black,
                              fontSize: 12),
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _dueController.dueHistory.value.data.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Get.to(DuePageEditDelete());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 8),
                          child: ListTile(
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('৳ ${_dueController.dueHistory.value.data[index].amount}', style: TextStyle(
                                    fontSize: 16, fontFamily: 'Roboto'
                                ),),
                                Text('${_dueController.dueHistory.value.data[index].contactType}'.tr, style: TextStyle(
                                    fontSize: 14, fontFamily: 'Roboto',color: Color(0xFF232323)
                                ),)
                              ],
                            ),
                            leading: SvgPicture.asset('images/svg_image/empty-image.svg'),
                            title: Text('${_dueController.dueHistory.value.data[index].contactName}', textAlign: TextAlign.start, style: TextStyle(
                                fontSize: 16, fontFamily: 'Roboto'
                            ),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('123456', style: TextStyle(
                                    fontSize: 14, fontFamily: 'Roboto'
                                ),),
                                Text('15th January, 2022', style: TextStyle(
                                    fontSize: 14, fontFamily: 'Roboto'
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ) :Container() ,
      ) ,
    );
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
      print(DateTime.utc(year, 1, weekDay));
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
  void getDataForDropDown(var startDate, var endDate) {
    // _expenseController
    //     .getAllExpense(
    //     shopId: '${shop.id}', startDate: "$startDate", endDate: "$endDate")
    //     .then((value) {
    //   if (value != null) {
    //     setState(() {
    //       _expenseController.allExpenseList.value = getExpenseFromModel(value);
    //       _expenseController.totalExpense.value = _expenseController
    //           .allExpenseList
    //           .map((e) => e.amount)
    //           .fold(0, (previousValue, element) => previousValue + element);
    //       print('expense list: ${_expenseController.allExpenseList.value}');
    //     });
    //   }
    //
    //   //  isLoading = false;
    // }
    // );
  }
}
