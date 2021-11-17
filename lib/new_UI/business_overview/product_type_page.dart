import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

var now = DateTime.now();
var day = DateFormat.yMMMMd().format(now);
var year = DateFormat.y().format(now);
var month = DateFormat.MMMM().format(now);
DateTime firstDatePicked;
DateTime endDatePicked;
var startDate;
var endDate;

class ProductReportPage extends StatefulWidget {
  const ProductReportPage({Key key}) : super(key: key);

  @override
  _ProductReportPageState createState() => _ProductReportPageState();
}

class _ProductReportPageState extends State<ProductReportPage> {
  int flag = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * 0.2,
            width: size.width,
            child: Image.asset(
              "images/topBg.png",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 20, right: 20),
                      child: Text(
                        'Product Wise Report',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik-VariableFont_wght',
                          color: DEFAULT_BLUE_DARK,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2222, 6, 7),
                            onChanged: (startDateTime) {
                          setState(() {
                            firstDatePicked = startDateTime;
                            startDate =
                                DateFormat.yMMMd().format(firstDatePicked);
                          });
                        });
                      },
                      child: Container(
                        height: 40,
                        width: size.width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Card(
                          child: Center(
                            child: Text(startDate ?? 'Start Date'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text('To'),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2222, 6, 7),
                            onChanged: (endDateTime) {
                          setState(() {
                            endDatePicked = endDateTime;
                            endDate = DateFormat.yMMMd().format(endDatePicked);
                          });
                        });
                      },
                      child: Container(
                        height: 40,
                        width: size.width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Card(
                          child: Center(
                            child: Text(endDate ?? 'End Date'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        flag = 1;
                      });
                    },
                    child: Text(
                      'Day',
                      style: TextStyle(
                          color: flag == 1 ? Colors.white : Colors.black,
                          fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.black),
                      primary: flag == 1 ? Colors.black : Colors.white,
                      fixedSize: Size(60, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        flag = 2;
                      });
                    },
                    child: Text(
                      'Week',
                      style: TextStyle(
                          color: flag == 2 ? Colors.white : Colors.black,
                          fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.black),
                      primary: flag == 2 ? Colors.black : Colors.white,
                      fixedSize: Size(60, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        flag = 3;
                      });
                    },
                    child: Text(
                      'Month',
                      style: TextStyle(
                          color: flag == 3 ? Colors.white : Colors.black,
                          fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.black),
                      primary: flag == 3 ? Colors.black : Colors.white,
                      fixedSize: Size(70, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        flag = 4;
                      });
                    },
                    child: Text(
                      'Year',
                      style: TextStyle(
                          color: flag == 4 ? Colors.white : Colors.black,
                          fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.black),
                      primary: flag == 4 ? Colors.black : Colors.white,
                      fixedSize: Size(60, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (flag == 1) {
                          setState(() {
                            day = DateFormat.yMMMMd()
                                .format(now.subtract(Duration(days: 1)));
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
                thickness: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    fillColor: Colors.white,
                    label: Text('Search Customer'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ///TODO: this bellow widget has to be in list, which will come dynamically
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Text('1'),
                              VerticalDivider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                              IntrinsicWidth(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [Text('soap'), Text('250')],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [Text('soap'), Text('250')],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
