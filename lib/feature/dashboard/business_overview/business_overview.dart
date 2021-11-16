import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format

var now = DateTime.now();
var day = DateFormat.yMMMMd().format(now);
var year = DateFormat.y().format(now);
var month = DateFormat.MMMM().format(now);

Widget ReportContainer(String asset, String reportName) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: Container(
      width: 140,
      height: 150,
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
                    height: 180,
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
                  top: 280,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0, bottom: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        // Divider(
                        //   thickness: 30,
                        //   height: 29,
                        //   color: Colors.black,
                        // ),
                        Card(
                          child: Container(
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
                        Card(
                          child: Container(
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
                        Card(
                          child: Container(
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
                        Card(
                          child: Container(
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
                        Card(
                          child: Container(
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
                      ],
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

  List<Widget> reportCardWidget = [
    ReportContainer("images/shop_features/pw.png", 'Products Wise Sale Report'),
    SizedBox(
      width: 7,
    ),
    ReportContainer("images/shop_features/cs.png", 'Customer Wise Sale Report'),
    SizedBox(
      width: 7,
    ),
    ReportContainer("images/shop_features/er.png", 'Employee Wise Sale Report'),
  ];
}
