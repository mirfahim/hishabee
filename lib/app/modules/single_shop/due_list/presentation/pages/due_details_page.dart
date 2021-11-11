// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:intl/intl.dart';
import 'package:darq/darq.dart';
import 'add_due_page.dart';
import 'due_payment_page.dart';

class DueDetailsPage extends StatelessWidget {
  final Shop shop;
  final Due due;

  DueDetailsPage({this.shop, this.due});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dueItemList = due.dueListItems
        .orderByDescending(
            (element) => element.updatedAt.microsecondsSinceEpoch)
        .toList();
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Stack(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                    color: DEFAULT_BLACK,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  'due_details'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 80,
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 70,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  width: 80,
                                  child: Text(
                                    'total_due'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  ' : ',
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: Text(
                                  "${due.dueAmount} " + "tk".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 135,
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 190,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Container(
                                      width: 80,
                                      child: Text(
                                        'name'.tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10, top: 10),
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        "${due.customerName}",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Container(
                                      width: 80,
                                      child: Text(
                                        'address'.tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10, top: 10),
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        "${due.customerAddress}",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Container(
                                      width: 80,
                                      child: Text(
                                        'mobile'.tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10, top: 10),
                                    child: Text(
                                      "${due.customerMobile}",
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 15, right: 5),
                                    child: InkWell(
                                      onTap: () {
                                        String number =
                                            "tel:${due.customerMobile}";
                                        Utility.launchURL(number);
                                      },
                                      child: Container(
                                        width: size.width * 0.41,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.green),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: Colors.lightGreen),
                                              child: Icon(
                                                Icons.call,
                                                color: Colors.black,
                                                size: 18,
                                              ),
                                            ),
                                            Text(
                                              'CALL',
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 15, right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        String number =
                                            "sms:${due.customerMobile}";
                                        Utility.launchURL(number);
                                      },
                                      child: Container(
                                        width: size.width * 0.41,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: DEFAULT_YELLOW_BG),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: DEFAULT_YELLOW_BG),
                                              child: Icon(
                                                Icons.email,
                                                color: Colors.black,
                                                size: 18,
                                              ),
                                            ),
                                            Text(
                                              'MESSAGE',
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'due_history'.tr,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLACK,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10, right: 10, bottom: 100),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dueItemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dueItem = dueItemList[index];
                        return Container(
                          height: size.height * 0.08,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.3,
                                  child: Text(
                                    DateFormat("dd MMM yyyy")
                                        .format(dueItem.createdAt),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: size.width * 0.35,
                                          child: Text(
                                            "${dueItem.amount} /=",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: dueItem.type == "LEND"
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                    //width: size.width * 0.2,
                                    child: Text(
                                      "${dueItem.type}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: dueItem.type == "LEND"
                                              ? Colors.red
                                              : Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 8),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => AddDuePage(),
                                arguments: {
                                  "shop": shop,
                                  "due": due,
                                },
                                binding: DueListBinding());
                          },
                          child: Container(
                            height: 50,
                            width: size.width * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                "add_due".tr,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, bottom: 8),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => DuePaymentPage(),
                                arguments: {
                                  "shop": shop,
                                  "due": due,
                                },
                                binding: DueListBinding());
                          },
                          child: Container(
                            height: 50,
                            width: size.width * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Text(
                                "received_payment".tr,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 16,
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
            ),
          ],
        ),
      ),
    );
  }
}
