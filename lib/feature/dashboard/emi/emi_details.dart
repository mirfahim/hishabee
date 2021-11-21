import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/emi_payment_link.dart';
import 'package:hishabee_business_manager_fl/models/emi/utils/bank_model.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class EmiDetails extends StatefulWidget {
  @override
  _EmiDetailsState createState() => _EmiDetailsState();
}

class _EmiDetailsState extends State<EmiDetails> {
  BankModel bank;
  @override
  void initState() {
    bank = Get.arguments[5];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int flag = 1;
    var storage = GetStorage();
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
                          onPressed: () => Get.back(),
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
                    left: 15,
                    right: 15,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: Utils.getBoxShape(),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  Get.arguments[4] +
                                      " টাকা কাস্টমার পেমেন্ট করার সাথে সাথে পুরো টাকাটি আপনার ডিজিটাল ব্যালেন্সে যুক্ত হবে| এই টাকা কাস্টমার ব্যাংকের কিস্তির মাধ্যমে পরিশোধ করবে| ",
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(22.0),
                                child: Text(Get.arguments[4] +
                                    "  " +
                                    bank.name +
                                    "\nEMI Options"),
                              ),
                            ),
                            bank.month3Fee != null
                                ? Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () => Get
                                              .to(EmiPaymentLink(), arguments: [
                                              storage.read("shop_id"), //shop
                                            Get.arguments[1], // name
                                            Get.arguments[2], //phone
                                            Get.arguments[3], //address
                                            Get.arguments[4], // amount
                                            "3",
                                            getAmount(
                                                double.parse(Get.arguments[4]),
                                                Utils
                                                    .month3fee), // with interest
                                            getMonthly(
                                                //monthly
                                                getAmount(
                                                    double.parse(
                                                        Get.arguments[4]),
                                                    Utils.month3fee),
                                                3)
                                          ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "3 Monhts EMI",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Total Payable Amount: " +
                                                        getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils.month3fee)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                getMonthly(
                                                            getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month3fee),
                                                            3)
                                                        .toString() +
                                                    "/Month",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 10,
                            ),
                            bank.month6Fee != null
                                ? Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () => Get
                                              .to(EmiPaymentLink(), arguments: [
                                            Get.arguments[0], //shop
                                            Get.arguments[1], // name
                                            Get.arguments[2], //phone
                                            Get.arguments[3], //address
                                            Get.arguments[4], // amount
                                            "6",
                                            getAmount(
                                                double.parse(Get.arguments[4]),
                                                Utils
                                                    .month6fee), // with interest
                                            getMonthly(
                                                //monthly
                                                getAmount(
                                                    double.parse(
                                                        Get.arguments[4]),
                                                    Utils.month6fee),
                                                6)
                                          ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "6 Monhts EMI",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Total Payable Amount: " +
                                                        getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils.month6fee)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                getMonthly(
                                                            getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month6fee),
                                                            6)
                                                        .toString() +
                                                    "/Month",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            bank.month9Fee != null
                                ? Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () => Get
                                              .to(EmiPaymentLink(), arguments: [
                                            Get.arguments[0], //shop
                                            Get.arguments[1], // name
                                            Get.arguments[2], //phone
                                            Get.arguments[3], //address
                                            Get.arguments[4], // amount
                                            "9",
                                            getAmount(
                                                double.parse(Get.arguments[4]),
                                                Utils
                                                    .month9fee), // with interest
                                            getMonthly(
                                                //monthly
                                                getAmount(
                                                    double.parse(
                                                        Get.arguments[4]),
                                                    Utils.month9fee),
                                                9)
                                          ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "9 Monhts EMI",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Total Payable Amount: " +
                                                        getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils.month9fee)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                getMonthly(
                                                            getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month9fee),
                                                            9)
                                                        .toString() +
                                                    "/Month",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            bank.month12Fee != null
                                ? Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () => Get
                                              .to(EmiPaymentLink(), arguments: [
                                            Get.arguments[0], //shop
                                            Get.arguments[1], // name
                                            Get.arguments[2], //phone
                                            Get.arguments[3], //address
                                            Get.arguments[4], // amount
                                            "12",
                                            getAmount(
                                                double.parse(Get.arguments[4]),
                                                Utils
                                                    .month12fee), // with interest
                                            getMonthly(
                                                //monthly
                                                getAmount(
                                                    double.parse(
                                                        Get.arguments[4]),
                                                    Utils.month12fee),
                                                12)
                                          ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "12 Monhts EMI",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Total Payable Amount: " +
                                                        getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month12fee)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                getMonthly(
                                                            getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month12fee),
                                                            12)
                                                        .toString() +
                                                    "/Month",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            bank.month18Fee != null
                                ? Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () => Get
                                              .to(EmiPaymentLink(), arguments: [
                                            Get.arguments[0], //shop
                                            Get.arguments[1], // name
                                            Get.arguments[2], //phone
                                            Get.arguments[3], //address
                                            Get.arguments[4], // amount
                                            "18",
                                            getAmount(
                                                double.parse(Get.arguments[4]),
                                                Utils
                                                    .month18fee), // with interest
                                            getMonthly(
                                                //monthly
                                                getAmount(
                                                    double.parse(
                                                        Get.arguments[4]),
                                                    Utils.month18fee),
                                                18)
                                          ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "18 Monhts EMI",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Total Payable Amount: " +
                                                        getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month18fee)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                getMonthly(
                                                            getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month18fee),
                                                            18)
                                                        .toString() +
                                                    "/Month",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            bank.month24Fee != null
                                ? Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () => Get
                                              .to(EmiPaymentLink(), arguments: [
                                            Get.arguments[0], //shop
                                            Get.arguments[1], // name
                                            Get.arguments[2], //phone
                                            Get.arguments[3], //address
                                            Get.arguments[4], // amount
                                            "24",
                                            getAmount(
                                                double.parse(Get.arguments[4]),
                                                Utils
                                                    .month24fee), // with interest
                                            getMonthly(
                                                //monthly
                                                getAmount(
                                                    double.parse(
                                                        Get.arguments[4]),
                                                    Utils.month24fee),
                                                24)
                                          ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "24 Monhts EMI",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Total Payable Amount: " +
                                                        getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month24fee)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                getMonthly(
                                                            getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month24fee),
                                                            24)
                                                        .toString() +
                                                    "/Month",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            bank.month30Fee != null
                                ? Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () => Get
                                              .to(EmiPaymentLink(), arguments: [
                                            Get.arguments[0], //shop
                                            Get.arguments[1], // name
                                            Get.arguments[2], //phone
                                            Get.arguments[3], //address
                                            Get.arguments[4], // amount
                                            "30",
                                            getAmount(
                                                double.parse(Get.arguments[4]),
                                                Utils
                                                    .month30fee), // with interest
                                            getMonthly(
                                                //monthly
                                                getAmount(
                                                    double.parse(
                                                        Get.arguments[4]),
                                                    Utils.month30fee),
                                                30)
                                          ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "30 Monhts EMI",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Total Payable Amount: " +
                                                        getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month30fee)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                getMonthly(
                                                            getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month30fee),
                                                            30)
                                                        .toString() +
                                                    "/Month",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            bank.month36Fee != null
                                ? Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          onTap: () => Get
                                              .to(EmiPaymentLink(), arguments: [
                                            Get.arguments[0], //shop
                                            Get.arguments[1], // name
                                            Get.arguments[2], //phone
                                            Get.arguments[3], //address
                                            Get.arguments[4], // amount
                                            "36", //5
                                            getAmount(
                                                double.parse(Get.arguments[4]),
                                                Utils
                                                    .month36fee), // with interest 6
                                            getMonthly(
                                                //7
                                                //monthly
                                                getAmount(
                                                    double.parse(
                                                        Get.arguments[4]),
                                                    Utils.month36fee),
                                                36)
                                          ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "36 Monhts EMI",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Total Payable Amount: " +
                                                        getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month36fee)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                getMonthly(
                                                            getAmount(
                                                                double.parse(
                                                                    Get.arguments[
                                                                        4]),
                                                                Utils
                                                                    .month36fee),
                                                            36)
                                                        .toString() +
                                                    "/Month",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : Container(),
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

  getAmount(double amount, double interest) {
    // print((amount + (amount * interest)).toString());
    return (amount + (amount * interest));
  }

  getMonthly(double amount, int sub) {
    return (amount / sub).round();
  }
}
