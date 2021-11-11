import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class StockCountsPage extends StatefulWidget {
  @override
  _StockCountsPageState createState() => _StockCountsPageState();
}

class _StockCountsPageState extends State<StockCountsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width,
              child: Image.asset(
                "images/topBg.png",
                fit: BoxFit.fill,
              ),
            ),
            ListView(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        // left: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 32,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Text(
                                'Stock Count',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: FlatButton(
                              color: DEFAULT_BLUE,
                              onPressed: () {},
                              child: Text(
                                'AUDIT',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 80.0,
                        left: 10,
                      ),
                      child: Text(
                        'Shop 1',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: DEFAULT_BLUE,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 130,
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        height: 45,
                        child: FlatButton(
                          minWidth: double.infinity,
                          color: DEFAULT_BLUE,
                          onPressed: () {},
                          child: Text(
                            'UPDATE STOCK',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.3,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 0.2, color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.search,
                          color: DEFAULT_BLUE,
                          size: 28,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          width: size.width / 3,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Search Product",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: VerticalDivider(
                          thickness: 0.6,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: size.width / 5,
                          child: Row(
                            children: [
                              Image(
                                height: 15,
                                image:
                                    AssetImage('images/icons/barcodeIcon.png'),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Scan',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  // fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: VerticalDivider(
                          thickness: 0.6,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: size.width / 5,
                          child: Row(
                            children: [
                              Image(
                                height: 15,
                                image:
                                    AssetImage('images/icons/filterIcon.png'),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  // fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
