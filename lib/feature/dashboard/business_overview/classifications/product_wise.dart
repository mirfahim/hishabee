import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format

var now = DateTime.now();
var day = DateFormat.yMMMMd().format(now);
var year = DateFormat.y().format(now);
var month = DateFormat.MMMM().format(now);

class ProductWise extends StatefulWidget {
  @override
  State<ProductWise> createState() => _ProductWiseState();
}

class _ProductWiseState extends State<ProductWise> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int flag = 1;
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
                  child: Container(
                    color: Colors.red,
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
                                      primary: flag == 1
                                          ? Colors.black
                                          : Colors.white,
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
                                      primary: flag == 2
                                          ? Colors.black
                                          : Colors.white,
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
                                      primary: flag == 3
                                          ? Colors.black
                                          : Colors.white,
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
                                      primary: flag == 4
                                          ? Colors.black
                                          : Colors.white,
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
                          // Divider(
                          //   thickness: 30,
                          //   height: 29,
                          //   color: Colors.black,
                          // ),
                          //
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
