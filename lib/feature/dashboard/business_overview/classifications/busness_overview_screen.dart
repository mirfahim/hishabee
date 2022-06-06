import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/business_overview/business_overview_controller.dart';
//import 'package:hishabee_business_manager_fl/controllers/business_overview/bo_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/business_overview/classifications/customer_wise_report.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/business_overview/classifications/employe_wise_report.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/business_overview/classifications/product_wise.dart';
import 'package:hishabee_business_manager_fl/models/business_overview/overview.dart';
import 'package:hishabee_business_manager_fl/new_UI/business_overview/business_over_view.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart'; // for date format
import 'package:jiffy/jiffy.dart';
var now;
var day;

// var week = ;
var startOfTheWeek = now.subtract(Duration(days: now.weekday - 1));
var endOfTheWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);
var startOfTheYear = DateTime(DateTime.now().year);
int year;
// var year = DateFormat.y().format(now);
int month;
int week;
var dayMain;
// var month = DateFormat.MMMM().format(now);
// ignore: non_constant_identifier_names
Widget ReportContainer(String asset, String reportName) {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
    child: Container(
      width: 150,
      height: 100,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              child: Image.asset(
                asset,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Center(
                  child: Text(
                    reportName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      ),
    ),
  );
}

class BusinessOverView extends StatefulWidget {
  @override
  _BusinessOverViewState createState() => _BusinessOverViewState();
}

class _BusinessOverViewState extends State<BusinessOverView> {
  Shop shop = Get.arguments;
  var getStorageId = GetStorage('shop_id');
  int flag = 1;
  BusinessOverViewController _controller = Get.find();
  // var now = DateTime.now();
  // var month = DateFormat.yMMMMd().format(now);
  bool _isLoading = true;
  OverviewModel _overView;
  @override
  void initState() {
    now = DateTime.now();
    day = DateFormat.yMMMMd().format(now);
    dayMain =DateTime.now().day.toInt();
    month = DateTime.now().month.toInt();
    year = DateTime.now().year.toInt();
    // month = DateFormat.MMMM().format(now);
    _controller.count.value = 0;
    _controller.countAdd.value = 0;
    _controller
        .fetchOverview(shopId: '${shop.id}', startDate: '$now', endDate: '$now')
        .then((value) {
      // print("here is our value from network");
      // print(value);
      setState(() {
        _overView = overviewModelFromJson(value);
        _isLoading = false;
      });
    });

    super.initState();
  }

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    getStorageId.write('shop_id', shop.id);
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _isLoading,
          child: _overView != null
              ? SingleChildScrollView(
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
                            padding: const EdgeInsets.only(
                                top: 14, right: 15.0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 35,
                                color: Colors.black,
                              ),
                              onPressed: () => Get.back(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 10, right: 15),
                            child: Text(
                              'Business OverView',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: reportCardWidget.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () => index == 0
                                    ? Get.to(ProductWise(),
                                    arguments: Get.arguments)
                                    : index == 1
                                    ? Get.to(CustomerWiseReport(),
                                    arguments: Get.arguments)
                                    : Get.to(EmployeWiseReport(),
                                    arguments: Get.arguments),
                                child: reportCardWidget[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Center(
                                child: Text(
                                  'General Sales Report',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 27,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          flag = 1;
                                          _controller
                                              .fetchOverview(
                                              shopId: '${shop.id}',
                                              startDate: '$now',
                                              endDate: '$now')
                                              .then((value) {
                                            // print("here is our value from network");
                                            // print(value);
                                            setState(() {
                                              _overView =
                                                  overviewModelFromJson(
                                                      value);
                                              _isLoading = false;
                                            });
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
                                            width: 1,
                                            color: Colors.black),
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

                                          _controller
                                              .fetchOverview(
                                              shopId: '${shop.id}',
                                              startDate:
                                              '$startOfTheWeek',
                                              endDate: '$now')
                                              .then((value) {
                                            // print("here is our value from network");
                                            // print(value);
                                            setState(() {
                                              _overView =
                                                  overviewModelFromJson(
                                                      value);
                                              _isLoading = false;
                                            });
                                          });
                                          print(startOfTheWeek);
                                          print(now);
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
                                            width: 1,
                                            color: Colors.black),
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

                                          _controller
                                              .fetchOverview(
                                              shopId: '${shop.id}',
                                              startDate:
                                              '$startOfMonth',
                                              endDate:
                                              '$lastOfTheMonth')
                                              .then((value) {
                                            // print("here is our value from network");
                                            // print(value);
                                            setState(() {
                                              _overView =
                                                  overviewModelFromJson(
                                                      value);
                                              _isLoading = false;
                                            });
                                          });
                                          print(startOfMonth);
                                          print(lastOfTheMonth);
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
                                            width: 1,
                                            color: Colors.black),
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

                                          _controller
                                              .fetchOverview(
                                              shopId: '${shop.id}',
                                              startDate:
                                              '$startOfTheYear',
                                              endDate: '$now')
                                              .then((value) {
                                            // print("here is our value from network");
                                            // print(value);
                                            setState(() {
                                              _overView =
                                                  overviewModelFromJson(
                                                      value);
                                              _isLoading = false;
                                            });
                                          });
                                          print(startOfTheYear);
                                          print(now);
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
                                            width: 1,
                                            color: Colors.black),
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
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (flag == 1) {
                                        setState(() {
                                          // day = DateFormat.yMMMMd().format(now);
                                          _controller.count.value++;
                                        });
                                        dayMinus();
                                      }
                                      else if(flag == 3){
                                        monthMinus();
                                      }
                                      else if(flag == 4){
                                        yearMinus();
                                      }
                                      else if(flag == 2){
                                        // weekMinus();
                                      }
                                    },
                                    icon: Icon(Icons.arrow_back_ios)),
                                if (flag == 1) Text(DateFormat.yMMMMd().format(now)),
                                if(flag ==2) Text('${DateFormat.yMMMMd().format(startOfTheWeek)} - ${DateFormat.yMMMMd().format(endOfTheWeek)}'),
                                if (flag == 4) Text('$year'),
                                if (flag == 3) Text(months[month - 1]),
                                IconButton(
                                    onPressed: () {
                                      if (flag == 1) {
                                        setState(() {
                                          _controller.countAdd.value++;
                                        });
                                        dayAdd();
                                      }
                                      else if(flag == 3){
                                        setState(() {

                                        });
                                        monthAdd();
                                      }
                                      else if(flag == 4){
                                        yearAdd();
                                      }
                                    },
                                    icon: Icon(Icons.arrow_forward_ios))
                              ],
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.grey[400],
                            ),
                            getCardView("Total Product Sold",
                                _overView.totalProduct.toString()),
                            getCardView("Total Collected",
                                _overView.totalProductAmount.toString()),
                            getCardView("Total Due",
                                _overView.totalDue.toString()),
                            getCardView("Total Expense",
                                _overView.totalExpense.toString()),
                            getCardView("Total Profit",
                                _overView.totalProfit.toString()),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
              : Container(),
        ),
      ),
    );
  }

  List<Widget> reportCardWidget = [
    ReportContainer("images/shop_features/pw.png", 'Products Wise Sale Report'),
    ReportContainer("images/shop_features/cs.png", 'Customer Wise Sale Report'),
    ReportContainer("images/shop_features/er.png", 'Employee Wise Sale Report'),
  ];

  getCardView(String label, String value) => Padding(
    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
    child: Container(
        height: 50,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Padding(
          padding: Utils.getPaddingBothSide(),
          child: Row(children: [
            Expanded(flex: 2, child: Text(label)),
            Text(value ?? "0")
          ]),
        )),
  );

  void getDataForDropDown(var startDate, var endDate) {
    _controller
        .fetchOverview(
        shopId: '${getStorageId.read('shop_id')}',
        startDate: "$startDate",
        endDate: "$endDate")
        .then((value) {
      if (value != null) {
        setState(() {
          _overView = overviewModelFromJson(value);
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
      now =now.add(Duration(days: 1));
    });
    getDataForDropDown(now, now);
  }
  monthMinus(){
    setState(() {
      month = Jiffy([year, month, dayMain]).subtract(months: 1).month;
      print(Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime);
      print(Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
    });
    getDataForDropDown(Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime, Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
  }
  monthAdd(){
    setState(() {
      month = Jiffy([year, month, dayMain]).add(months: 1).month;
    });
    getDataForDropDown(Jiffy([year, month, dayMain]).startOf(Units.MONTH).dateTime, Jiffy([year, month, dayMain]).endOf(Units.MONTH).dateTime);
  }
  yearMinus(){
    setState(() {
      year = Jiffy([year, month, dayMain]).subtract(years: 1).year;
      print(Jiffy([year, month, dayMain]).startOf(Units.YEAR).dateTime);
      print(Jiffy([year, month, dayMain]).endOf(Units.YEAR).dateTime);
    });
    getDataForDropDown(Jiffy([year, month, dayMain]).startOf(Units.YEAR).dateTime, Jiffy([year, month, dayMain]).endOf(Units.YEAR).dateTime);

  }
  yearAdd(){
    setState(() {
      year = Jiffy([year, month, dayMain]).add(years: 1).year;
      print(year);
    });
    getDataForDropDown(Jiffy([year, month, dayMain]).startOf(Units.YEAR).dateTime, Jiffy([year, month, dayMain]).endOf(Units.YEAR).dateTime);
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
