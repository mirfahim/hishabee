import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/new_emi.dart';
import 'package:hishabee_business_manager_fl/models/emi/emi_model.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart'; // for date format

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

class EMI extends StatefulWidget {
  @override
  _EMIState createState() => _EMIState();
}

class _EMIState extends State<EMI> {
  List<EmiModel> _list = <EmiModel>[];
  List<EmiModel> _foundData = <EmiModel>[];
  EmiController controller = EmiController();
  Shop shop = Get.arguments;
  int flag = 1;

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
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // var storage = GetStorage();
    // storage.write("shop_id", shop.id.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            color: Colors.black,
            onPressed: () => Get.back(),
          ),
          title: Text(
            'emi'.tr,
            style: TextStyle(
              color: Colors.black
            ),
          ),
          titleSpacing: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, right: 15, bottom: 10),
              child: InkWell(
                onTap: () => Get.to(NewEmi("", "", "", "",shop,""), arguments: shop),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.blue[600], width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Colors.blueAccent.shade700,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'new_emi'.tr,
                          style: TextStyle(
                              color: Colors.blueAccent.shade700,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'name_or_mobile_number'.tr,
                    style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12.0,
                    ),
                    child: Container(
                      height: 50.0,
                      child: TextField(
                        onChanged: (value) => _runFilter(value),
                        style: TextStyle(fontSize: 14.0),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.pink)),
                            hintText: 'Search',
                            hintStyle: TextStyle(fontSize: 12.0),
                            filled: true,
                            fillColor: Color(0xFFC4C4C4).withOpacity(.35),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xFFC4C4C4),
                              size: 30,
                            )),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        'filter'.tr,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 4,
                                child: Text(
                                  startDate ?? 'start_date'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                              ),
                              // Spacer(),
                              Flexible(
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                            // maximumSize: MaterialStateProperty.all<Size>(
                            //     Size(150, 44)),
                            // elevation: MaterialStateProperty.all<double>(1.0),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(.35),
                                        width: 1.0)))),
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              maxTime: DateTime(2222, 6, 7),
                              onChanged: (startDateTime) {
                            setState(() {
                              firstDatePicked = startDateTime;
                              startDate =
                                  DateFormat.MMMMd().format(firstDatePicked);
                              // getDataForDropDown(startDate, endDate);
                            });
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 4,
                                child: Text(
                                  endDate ?? 'end_date'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                            // maximumSize: MaterialStateProperty.all<Size>(
                            //     Size(150, 44)),
                            elevation: MaterialStateProperty.all<double>(1.0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white.withOpacity(0.9)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(.35),
                                        width: 1.0)))),
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              maxTime: DateTime(2222, 6, 7),
                              onChanged: (endDateTime) {
                            setState(() {
                              endDatePicked = endDateTime;
                              endDate =
                                  DateFormat.MMMMd().format(endDatePicked);
                              // getDataForDropDown(startDate, endDate);
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                    });
                                  },
                                  child: Text(
                                    'day'.tr,
                                    style: TextStyle(
                                        color: flag == 1
                                            ? Colors.white
                                            : Colors.grey,
                                        fontSize: 10),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        width: 1, color: Colors.grey),
                                    primary:
                                        flag == 1 ? Colors.black : Colors.white,
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
                                      print('flag of week $flag');
                                    });
                                  },
                                  child: Text(
                                    'week'.tr,
                                    style: TextStyle(
                                        color: flag == 2
                                            ? Colors.white
                                            : Colors.grey,
                                        fontSize: 10),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    side: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    primary:
                                        flag == 2 ? Colors.black : Colors.white,
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
                                    });
                                  },
                                  child: Text(
                                    'month'.tr,
                                    style: TextStyle(
                                        color: flag == 3
                                            ? Colors.white
                                            : Colors.grey,
                                        fontSize: 10),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    side: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    primary:
                                        flag == 3 ? Colors.black : Colors.white,
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
                                    });
                                  },
                                  child: Text(
                                    'year'.tr,
                                    style: TextStyle(
                                        color: flag == 4
                                            ? Colors.white
                                            : Colors.grey,
                                        fontSize: 10),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    side: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    primary:
                                        flag == 4 ? Colors.black : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 5,
                          color: Colors.grey[300],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('list_of_emi'.tr, style: TextStyle(
                            fontSize: 16, fontFamily: 'Roboto'

                          ),),
                        ),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: _foundData.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => _foundData.length != null ?
                            Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0, bottom: 8, top: 8),
                                        child: Icon(
                                          Icons.account_circle_outlined,
                                          size: 40,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _foundData[index].customerName ?? '[Not Given]',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Roboto',
                                                  ),
                                            ),
                                            Text(
                                              _foundData[index].customerMobile ?? '[Not Given]',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w200),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "৳${_foundData[index].payableAmount.toString() ?? ''}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Roboto',
                                                color: Colors.red[700],
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            _foundData[index].paymentStatus ?? '',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'Roboto',
                                                color: Colors.red[700],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ): Center(
                              child: Text('Text Loading', style: TextStyle(fontSize: 16),),
                            )),
                        Center(
                          child: TextButton(onPressed: (){}, child: Text('know_more_about_emi'.tr,style: TextStyle(
                            fontSize: 14, color: DEFAULT_BLUE
                          ),)),
                        )

////,
                        ,
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<EmiModel> results = [];
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

  void getData() async{
    await controller.fetchAllEmi(shopId: "${shop.id}").then((value) {
      if (value != null) {
        setState(() {
          _list = emiModelFromJson(value);
          _foundData = _list;
          //  print(_foundData.length);
          // checkingDone = true;
        });
      }

      //  isLoading = false;
    });
  }
  // void getDataForDropDown(var startDate, var endDate) {
  //   controller
  //       .fetchAllEmi(
  //       shopId: '${shop.id}', startDate: "$startDate", endDate: "$endDate")
  //       .then((value) {
  //     if (value != null) {
  //       setState(() {
  //         _list = emiModelFromJson(value);
  //
  //         print('EMI list: $_list');
  //       });
  //     }
  //
  //     //  isLoading = false;
  //   });
  // }
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
