import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/business_overview/business_overview_controller.dart';
//import 'package:hishabee_business_manager_fl/controllers/business_overview/bo_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/digital_payment/dp_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/single_payment_details_proceed.dart';
import 'package:hishabee_business_manager_fl/models/business_overview/customer_report.dart';
import 'package:hishabee_business_manager_fl/models/business_overview/product_report.dart';
import 'package:hishabee_business_manager_fl/models/digital_payment/digital_payment.dart';
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


class DigitalPaymentDetails extends StatefulWidget {
  @override
  _CustomerWiseReportState createState() => _CustomerWiseReportState();
}

class _CustomerWiseReportState extends State<DigitalPaymentDetails> {
  DpController _dpController = Get.put(DpController());
  Shop shop = Get.arguments;
  List<DigitalPaymentModel> _list = [];
  List<DigitalPaymentModel> _foundData = [];
  BusinessOverViewController _boController = BusinessOverViewController();
  int flag = 1;
  double totalComplete = 0.0;
  double totalCompletePercentage = 0.0;
  double totalPending = 0.0;
  double totalPendingPercentage = 0.0;
  double totalCanceled = 0.0;
  double totalCanceledPercentage = 0.0;
  double totalPayment = 0.0;
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
    week = Jiffy([year, month, dayMain]).week;
    weekFirst = DateFormat.yMd().format(DateTime.utc(year, month, ((week-1)*7))) ;
    weekLast = DateFormat.yMd().format(DateTime.utc(year, month, ((week-1)*7) + 6));
    _boController.count.value = 0;
    _boController.countAdd.value = 0;
    getData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'digital_payment'.tr,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Roboto'
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    // height: 250,
                    decoration: BoxDecoration(
                        color: DEFAULT_BLUE,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('digital_payment'.tr,style: TextStyle(
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
                                '${weekFirst} - ${weekLast}',style: TextStyle(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFC4C4C4).withOpacity(.35)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text('৳$totalComplete', style: TextStyle(
                                        color: Colors.white, fontFamily: 'Roboto'
                                    ),),
                                    SizedBox(height: 3,),
                                    Text('$totalCompletePercentage%', style: TextStyle(
                                        color: Colors.white, fontFamily: 'Roboto'
                                    ),),
                                    SizedBox(height: 3,),
                                    Text('complete'.tr, style: TextStyle(
                                      color: Colors.white, fontFamily: 'Roboto'
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFC4C4C4).withOpacity(.35)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text('৳$totalPending', style: TextStyle(
                                        color: Colors.white, fontFamily: 'Roboto'
                                    ),),
                                    SizedBox(height: 3,),
                                    Text('$totalPendingPercentage%', style: TextStyle(
                                        color: Colors.white, fontFamily: 'Roboto'
                                    ),),
                                    SizedBox(height: 3,),
                                    Text('pending', style: TextStyle(
                                        color: Colors.white, fontFamily: 'Roboto'
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFC4C4C4).withOpacity(.35)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text('৳$totalCanceled', style: TextStyle(
                                        color: Colors.white, fontFamily: 'Roboto'
                                    ),),
                                    SizedBox(height: 3,),
                                    Text('$totalCanceledPercentage%', style: TextStyle(
                                        color: Colors.white, fontFamily: 'Roboto'
                                    ),),
                                    SizedBox(height: 3,),
                                    Text('canceled', style: TextStyle(
                                        color: Colors.white, fontFamily: 'Roboto'
                                    ),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(

                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flag = 1;

                        });
                      },
                      child: Text(
                        'day'.tr,
                        style: TextStyle(
                            color: flag == 1 ? Colors.white : Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 10),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50, 10),
                        minimumSize: Size(70, 30),
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

                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flag = 2;

                        });
                      },
                      child: Text(
                        'week'.tr,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: flag == 2 ? Colors.white : Colors.black,
                            fontSize: 10),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50, 10),
                        minimumSize: Size(70, 30),
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

                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flag = 3;

                        });
                      },
                      child: Text(
                        'month'.tr,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: flag == 3 ? Colors.white : Colors.black,
                            fontSize: 10),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50, 10),
                        minimumSize: Size(70, 30),
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

                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flag = 4;

                        });
                      },
                      child: Text(
                        'year'.tr,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: flag == 4 ? Colors.white : Colors.black,
                            fontSize: 10),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50, 10),
                        minimumSize: Size(70, 30),
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

              Expanded(
                flex: 5,
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _foundData.length,
                      itemBuilder: (context, index) => Padding(
                        padding:
                        const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(SinglePaymentDetailsAndProceed(
                              name: _foundData[index].customerName,
                              mobileNumber: _foundData[index].customerMobile,
                              date: _foundData[index].createdAt,
                              digitalPaymentAmount: _foundData[index].amount,
                              status: _foundData[index].paymentStatus,
                            ),
                                arguments: shop);
                          },
                          child: Container(

                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[400]),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(6.0))),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
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
                                            .spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            _foundData[
                                            index]
                                                .customerName
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',

                                              fontSize: 16
                                            ),
                                          ),
                                          Text(
                                              "#" +
                                                  _foundData[index]
                                                      .code
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                  fontFamily: 'Roboto',

                                                  fontSize:
                                                  12.0)),
                                          Text(
                                              "Date-" +
                                                  _foundData[index]
                                                      .updatedAt
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: 'Roboto',
                                                  fontSize:
                                                  12.0))
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .end,
                                        children: [
                                          Text(
                                            "৳" +
                                                _foundData[index]
                                                    .amount
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize:
                                                16),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(color: _foundData[index]
                                                    .paymentStatus
                                                    .toString() == 'Pending' ? Colors.red : DEFAULT_BLUE)
                                            ),
                                            child:
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Center(
                                                child:
                                                Text(
                                                  "" +
                                                      _foundData[index].paymentStatus.toString(),
                                                  style: TextStyle(

                                                      color: _foundData[index]
                                                      .paymentStatus
                                                      .toString() == 'Pending' ? Colors.red : Colors.green,
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<DigitalPaymentModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = _list;
    } else {
      results = _list
          .where((item) => item.customerName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundData = results;
    });
  }

  void getDataForDropDown(var startDate, var endDate) {
    _boController
        .fetchCustomerWiseReport(
            shopId: '${getStorageId.read('shop_id')}',
            startDate: "$startDate",
            endDate: "$endDate")
        .then((value) {
      if (value != null) {
        setState(() {
          _list = digitalPaymentModelFromJson(value);
          _foundData = _list;
          // print(getStorageId.read('shop_id'));
          // print(now);
          // checkingDone = true;
        });
      }

      //  isLoading = false;
    });
  }


  void getData() {
    _dpController.fetchDp(shopId: shop.id).then((value) {
      if (value != null) {
        setState(() {
          _list = digitalPaymentModelFromJson(value);
          _foundData = _list;
          for(int i = 0; i<_foundData.length;i++){
            if(_foundData[i].paymentStatus == 'Complete')
              totalComplete = _foundData.map((e)=> e.amount).fold(0, (previousValue, element) => previousValue + element);
            else if(_foundData[i].paymentStatus == 'Pending'){
              totalPending = _foundData.map((e)=> e.amount).fold(0, (previousValue, element) => previousValue + element);
            }else if(_foundData[i].paymentStatus == 'Canceled'){
              totalCanceled = _foundData.map((e)=> e.amount).fold(0, (previousValue, element) => previousValue + element);
            }
            totalPayment = totalComplete + totalPending + totalCanceled;
            totalPendingPercentage = (totalPending/totalPayment) * 100;
            totalCanceledPercentage = (totalCanceled/totalPayment) * 100;
            totalCompletePercentage = (totalComplete/totalPayment) * 100;
          }
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
  weekAdd(){
    setState(() {
      // week = Jiffy([year, month, dayMain]).subtract(weeks: 1).week;
      // weekDay = ((week-1)*7) + (false ? 0 : 6);
      // print(DateTime.utc(year, month, weekDay));
    });
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

  weekMinus(){
    setState(() {
      // week = Jiffy([year, month, dayMain]).subtract(weeks: 1).week;
      // print(week);
    });
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
