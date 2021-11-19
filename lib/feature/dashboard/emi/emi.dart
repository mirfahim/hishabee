import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/models/emi/emi_model.dart';
import 'package:intl/intl.dart'; // for date format

var now = DateTime.now();
var day = DateFormat.yMMMMd().format(now);
var year = DateFormat.y().format(now);
var month = DateFormat.MMMM().format(now);

class EMI extends StatefulWidget {
  @override
  _EMIState createState() => _EMIState();
}

class _EMIState extends State<EMI> {
  List<EmiModel> _list = <EmiModel>[];
  List<EmiModel> _foundData = <EmiModel>[];
  EmiController controller = Get.find();
  @override
  void initState() {
    getData();

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
                          onPressed: () {},
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 14.0, left: 10, right: 15),
                        child: Text(
                          'EMI',
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
                                itemBuilder: (context, index) => Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                  _foundData[index]
                                                      .customerName,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  _foundData[index]
                                                      .customerMobile,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200),
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
                                                _foundData[index]
                                                    .payableAmount
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red[700],
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                _foundData[index].paymentStatus,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.red[700],
                                                    fontWeight:
                                                        FontWeight.w200),
                                              )
                                            ],
                                          ),
                                        ],
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

  void getData() {
    controller.fetchAllEmi(shopId: "").then((value) {
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
}
