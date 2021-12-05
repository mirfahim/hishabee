import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/controllers/business_overview/bo_controller.dart';
import 'package:hishabee_business_manager_fl/models/business_overview/employee_report.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart'; // for date format

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
var endDate; // BoController _boController = BoController();

class EmployeWiseReport extends StatefulWidget {
  @override
  State<EmployeWiseReport> createState() => _EmployeWiseReportState();
}

class _EmployeWiseReportState extends State<EmployeWiseReport> {
  List<EmployeReportModel> _list = <EmployeReportModel>[];
  List<EmployeReportModel> _foundData = <EmployeReportModel>[];
  BoController controller = BoController();
  int flag = 1;
  var getStorageId = GetStorage('shop_id');
  @override
  void initState() {
    startDate = 'Start Date';
    endDate = 'End Date';
    now = DateTime.now();
    day = DateFormat.yMMMMd().format(now);
    dayMain = DateTime.now().day.toInt();
    month = DateTime.now().month.toInt();
    year = DateTime.now().year.toInt();

    controller.count.value = 0;
    controller.countAdd.value = 0;
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width,
                  child: Image.asset(
                    "images/topBg.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 14, right: 15.0),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              size: 25,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 14.0, left: 10, right: 15),
                          child: Text(
                            'Employee Wise Report',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          label: Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 12.0),
                            child: Text(
                              startDate ?? 'Start Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.black,
                            size: 40.0,
                          ),
                          style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all<Size>(
                                  Size(150, 48)),
                              elevation: MaterialStateProperty.all<double>(1.0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white.withOpacity(0.9)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: BorderSide(
                                          color: Colors.grey.shade100,
                                          width: 2.0)))),
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018, 3, 5),
                                maxTime: DateTime(2222, 6, 7),
                                onChanged: (startDateTime) {
                              setState(() {
                                firstDatePicked = startDateTime;
                                startDate =
                                    DateFormat.yMMMd().format(firstDatePicked);
                                // getDataForDropDown(startDate, endDate);
                              });
                            });
                          },
                        ),
                        Text(
                          'to',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton.icon(
                          label: Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 12.0),
                            child: Text(
                              endDate ?? 'End Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.black,
                            size: 40.0,
                          ),
                          style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all<Size>(
                                  Size(150, 48)),
                              elevation: MaterialStateProperty.all<double>(1.0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white.withOpacity(0.9)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: BorderSide(
                                          color: Colors.grey.shade100,
                                          width: 2.0)))),
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018, 3, 5),
                                maxTime: DateTime(2222, 6, 7),
                                onChanged: (endDateTime) {
                              setState(() {
                                endDatePicked = endDateTime;
                                endDate =
                                    DateFormat.yMMMd().format(endDatePicked);
                                getDataForDropDown(startDate, endDate);
                              });
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                          controller
                                              .fetchEmployeWiseReport(
                                                  shopId:
                                                      '${getStorageId.read('shop_id')}',
                                                  startDate: "$now",
                                                  endDate: "$now")
                                              .then((value) {
                                            if (value != null) {
                                              setState(() {
                                                _list =
                                                    employeReportModelFromJson(
                                                        value);
                                                _foundData = _list;
                                                print(getStorageId
                                                    .read('shop_id'));
                                                print(now);
                                                // checkingDone = true;
                                              });
                                            }

                                            //  isLoading = false;
                                          });
                                        });
                                      },
                                      child: Text(
                                        'Day',
                                        style: TextStyle(
                                            color: flag == 1
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 10),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1, color: Colors.black),
                                        primary: flag == 1
                                            ? Colors.black
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                          controller
                                              .fetchEmployeWiseReport(
                                                  shopId:
                                                      '${getStorageId.read('shop_id')}',
                                                  startDate: "$startOfTheWeek",
                                                  endDate: "$now")
                                              .then((value) {
                                            if (value != null) {
                                              setState(() {
                                                _list =
                                                    employeReportModelFromJson(
                                                        value);
                                                _foundData = _list;
                                                print(getStorageId
                                                    .read('shop_id'));
                                                print(startOfTheWeek);
                                                print(now);
                                                // checkingDone = true;
                                              });
                                            }

                                            //  isLoading = false;
                                          });
                                        });
                                      },
                                      child: Text(
                                        'Week',
                                        style: TextStyle(
                                            color: flag == 2
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 10),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        side: const BorderSide(
                                            width: 1, color: Colors.black),
                                        primary: flag == 2
                                            ? Colors.black
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                          controller
                                              .fetchEmployeWiseReport(
                                                  shopId:
                                                      '${getStorageId.read('shop_id')}',
                                                  startDate: "$startOfMonth",
                                                  endDate: "$lastOfTheMonth")
                                              .then((value) {
                                            if (value != null) {
                                              setState(() {
                                                _list =
                                                    employeReportModelFromJson(
                                                        value);
                                                _foundData = _list;
                                                print(getStorageId
                                                    .read('shop_id'));
                                                print(startOfMonth);
                                                print(lastOfTheMonth);
                                                // checkingDone = true;
                                              });
                                            }

                                            //  isLoading = false;
                                          });
                                        });
                                      },
                                      child: Text(
                                        'Month',
                                        style: TextStyle(
                                            color: flag == 3
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 10),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        side: const BorderSide(
                                            width: 1, color: Colors.black),
                                        primary: flag == 3
                                            ? Colors.black
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                          controller
                                              .fetchEmployeWiseReport(
                                                  shopId:
                                                      '${getStorageId.read('shop_id')}',
                                                  startDate: "$startOfTheYear",
                                                  endDate: "$now")
                                              .then((value) {
                                            if (value != null) {
                                              setState(() {
                                                _list =
                                                    employeReportModelFromJson(
                                                        value);
                                                _foundData = _list;
                                                print(getStorageId
                                                    .read('shop_id'));
                                                print(startOfTheYear);
                                                print(now);
                                                // checkingDone = true;
                                              });
                                            }

                                            //  isLoading = false;
                                          });
                                        });
                                      },
                                      child: Text(
                                        'Year',
                                        style: TextStyle(
                                            color: flag == 4
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 10),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        side: const BorderSide(
                                            width: 1, color: Colors.black),
                                        primary: flag == 4
                                            ? Colors.black
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (flag == 1) {
                                        setState(() {
                                          controller.count.value++;
                                          // day = DateFormat.yMMMMd().format(now);
                                        });
                                        dayMinus();
                                      } else if (flag == 3) {
                                        monthMinus();
                                      } else if (flag == 4) {
                                        yearMinus();
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
                                          controller.countAdd.value++;
                                        });
                                        dayAdd();
                                      } else if (flag == 3) {
                                        setState(() {});
                                        monthAdd();
                                      } else if (flag == 4) {
                                        yearAdd();
                                      }
                                    },
                                    icon: Icon(Icons.arrow_forward_ios))
                              ],
                            ),
                            Divider(
                              thickness: 3,
                              color: Colors.grey[300],
                            ),

                            ///

                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12.0, top: 12.0, left: 10, right: 10),
                              child: Container(
                                height: 50.0,
                                child: TextField(
                                  onChanged: (value) => _runFilter(value),
                                  style: TextStyle(fontSize: 14.0),
                                  decoration: InputDecoration(
                                      hintText: 'Search',
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.blue[900])),
                                      hintStyle: TextStyle(fontSize: 12.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.blue[900])),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.blue[900],
                                        size: 30,
                                      )),
                                ),
                              ),
                            ),

                            Container(
                              height: size.height - 450,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _foundData.length,
                                    itemBuilder: (context, index) => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey[400]),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6.0))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    height: 100,
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: Center(
                                                      child: Text("1"),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      right: BorderSide(
                                                        color: Colors.grey[400],
                                                        width: 1,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 9,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0,
                                                                  right: 12.0,
                                                                  top: 6.0,
                                                                  bottom: 6.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    _foundData[
                                                                            index]
                                                                        .name
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  Text(
                                                                      "Sold-" +
                                                                          _foundData[index]
                                                                              .transactionCount
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              12.0))
                                                                ],
                                                              ),
                                                              Text(
                                                                "" +
                                                                    _foundData[
                                                                            index]
                                                                        .monthlySalary
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0,
                                                                  bottom: 3.0,
                                                                  left: 12.0,
                                                                  right: 12.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Mobile -",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                            .red[
                                                                        700]),
                                                              ),
                                                              Text(
                                                                  "" +
                                                                      _foundData[
                                                                              index]
                                                                          .mobile
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                              .red[
                                                                          900]))
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                              ),
                            )

////,
                            ,
                          ]),
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

  void _runFilter(String enteredKeyword) {
    List<EmployeReportModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = _list;
    } else {
      results = _list
          .where((item) =>
              item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundData = results;
    });
  }

  void getData() {
    controller
        .fetchEmployeWiseReport(
            shopId: '${getStorageId.read('shop_id')}',
            startDate: "$now",
            endDate: "$now")
        .then((value) {
      if (value != null) {
        setState(() {
          _list = employeReportModelFromJson(value);
          _foundData = _list;
          print(getStorageId.read('shop_id'));
          print(now);
          // checkingDone = true;
        });
      }

      //  isLoading = false;
    });
  }

  void getDataForDropDown(var startDate, var endDate) {
    controller
        .fetchEmployeWiseReport(
            shopId: '${getStorageId.read('shop_id')}',
            startDate: "$startDate",
            endDate: "$endDate")
        .then((value) {
      if (value != null) {
        setState(() {
          _list = employeReportModelFromJson(value);
          _foundData = _list;
          // print(getStorageId.read('shop_id'));
          // print(now);
          // checkingDone = true;
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
      month = Jiffy([year, month, dayMain]).subtract(months: 1).month;
      print(Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime);
      print(Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
    });
    getDataForDropDown(
        Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime,
        Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
  }

  monthAdd() {
    setState(() {
      month = Jiffy([year, month, dayMain]).add(months: 1).month;
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

  // weekMinus(){
  //   setState(() {
  //     week = Jiffy([year, month, dayMain]).subtract(weeks: 1).week;
  //     print(week);
  //   });
  // }
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
