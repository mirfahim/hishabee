import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/controllers/business_overview/bo_controller.dart';
import 'package:hishabee_business_manager_fl/models/business_overview/employee_report.dart';
import 'package:intl/intl.dart'; // for date format

var now = DateTime.now();
var day = DateFormat.yMMMMd().format(now);
var year = DateFormat.y().format(now);
var month = DateFormat.MMMM().format(now);

class EmployeWiseReport extends StatefulWidget {
  @override
  State<EmployeWiseReport> createState() => _EmployeWiseReportState();
}

class _EmployeWiseReportState extends State<EmployeWiseReport> {
  List<EmployeReportModel> _list = <EmployeReportModel>[];
  List<EmployeReportModel> _foundData = <EmployeReportModel>[];
  BoController controller = Get.find();
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int flag = 1;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
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
                  Positioned(
                    top: 63,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          label: Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 12.0),
                            child: Text(
                              'Start Date',
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
                          onPressed: () {},
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
                              'End Date',
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
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 10,
                    right: 10,
                    child: Padding(
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
                                        });
                                      },
                                      child: Text(
                                        ' Day ',
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
                                        });
                                      },
                                      child: Text(
                                        '  Week  ',
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
                                        });
                                      },
                                      child: Text(
                                        ' Month ',
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
                                        });
                                      },
                                      child: Text(
                                        ' Year ',
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
                                          day = DateFormat.yMMMMd().format(
                                              now.subtract(Duration(days: 1)));
                                          // day = DateFormat.yMMMMd().format(now);
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.arrow_back_ios)),
                                if (flag == 1) Text(day),
                                if (flag == 4) Text(year),
                                if (flag == 3) Text(month),
                                IconButton(
                                    onPressed: () {
                                      if (flag == 1) {
                                        setState(() {
                                          day = DateFormat.yMMMMd().format(
                                              now.add(Duration(days: 1)));
                                        });
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
                                    bottom: 12.0, top: 12.0),
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
                                )),

                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: _foundData.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
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
                                                padding: EdgeInsets.all(12.0),
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
                                                          const EdgeInsets.only(
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
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              Text(
                                                                  "Sold-" +
                                                                      _foundData[
                                                                              index]
                                                                          .transactionCount
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
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
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                fontSize: 11.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .red[700]),
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
                                    ))

////,
                            ,
                          ]),
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
        .fetchEmployeWiseReport(shopId: "", statDate: "", endDate: "")
        .then((value) {
      if (value != null) {
        setState(() {
          _list = employeReportModelFromJson(value);
          _foundData = _list;
          // checkingDone = true;
        });
      }

      //  isLoading = false;
    });
  }
}
