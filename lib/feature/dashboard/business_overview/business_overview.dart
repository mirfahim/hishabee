import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/business_overview/bo_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/business_overview/classifications/customer_wise_report.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/business_overview/classifications/employe_wise_report.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/business_overview/classifications/product_wise.dart';
import 'package:hishabee_business_manager_fl/models/business_overview/overview.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart'; // for date format
import 'package:intl/intl.dart'; // for date format

var now = DateTime.now();
var day = DateFormat.yMMMMd().format(now);
var year = DateFormat.y().format(now);
var month = DateFormat.MMMM().format(now);

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
  int flag = 1;
  BoController _controller = Get.find();
  // var now = DateTime.now();
  // var month = DateFormat.yMMMMd().format(now);
  bool _isLoading = true;
  OverviewModel _overView;
  @override
  void initState() {
    _controller
        .fetchOverview(shopId: "", statDate: "", endDate: "")
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14, right: 15.0),
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
                        Positioned(
                          top: 80,
                          child: SizedBox(
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
                        ),
                        Positioned(
                          top: 250,
                          left: 10,
                          right: 10,
                          child: Padding(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              day = DateFormat.yMMMMd().format(
                                                  now.subtract(
                                                      Duration(days: 1)));
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
                                  thickness: 2,
                                  color: Colors.grey[400],
                                ),
                                getCardView("Total Product Sold",
                                    _overView.totalProduct.toString()),
                                getCardView("Total Collected",
                                    _overView.totalProductAmount.toString()),
                                getCardView(
                                    "Total Due", _overView.totalDue.toString()),
                                getCardView("Total Expense",
                                    _overView.totalExpense.toString()),
                                getCardView("Total Profit",
                                    _overView.totalProfit.toString()),
                              ],
                            ),
  int flag = 1;
  // var now = DateTime.now();
  // var month = DateFormat.yMMMMd().format(now);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                          Icons.arrow_back,
                          size: 35,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 14.0, left: 10, right: 15),
                      child: Text(
                        'Business OverView',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 80,
                  child: SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: reportCardWidget.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return reportCardWidget[index];
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 10,
                  right: 10,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Center(
                            child: Text(
                          'General Sales Report',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        )),
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
                                      day = DateFormat.yMMMMd()
                                          .format(now.add(Duration(days: 1)));
                                    });
                                  }
                                },
                                icon: Icon(Icons.arrow_forward_ios))
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            height: 50,
                            width: size.width,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Total Product Sold'),
                                  Text('0')
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8.0),
                          child: Container(
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Total Product Sold'),
                                  Text('0')
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            height: 50,
                            width: size.width,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Total Product Sold'),
                                  Text('0')
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            height: 50,
                            width: size.width,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Total Product Sold'),
                                  Text('0')
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8.0),
                          child: Container(
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Total Product Sold'),
                                  Text('0')
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
              ],
            ),
          ),
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
}
