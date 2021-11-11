import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class QuickAddProduct extends StatefulWidget {
  @override
  _QuickAddProductState createState() => _QuickAddProductState();
}

class _QuickAddProductState extends State<QuickAddProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: ListView(
            children: [
              Stack(
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(
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
                              'quickAdd'.tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.search,
                                    color: DEFAULT_BLUE,
                                    size: 28,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    width: size.width / 5,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintText: "search_product".tr,
                                        hintStyle: TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
