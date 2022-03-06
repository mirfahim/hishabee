import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/emi_payment_link.dart';
import 'package:hishabee_business_manager_fl/models/emi/utils/bank_model.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class EmiDetails extends StatefulWidget {
  @override
  _EmiDetailsState createState() => _EmiDetailsState();
}

class _EmiDetailsState extends State<EmiDetails> {
  EmiController _emiController = Get.find();
  Shop shop = Get.arguments[6];
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            color: Colors.black,
            onPressed: (){
              _emiController.nameController.clear();
              _emiController.addressController.clear();
              _emiController.mobileController.clear();
              _emiController.emiMoney.clear();
              _emiController.bankName.value = '';
              Get.back();
            },
          ),
          title: Text(
            'emi'.tr,
          ),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: Utils.getBoxShape(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                            "৳ ${Get.arguments[4]} টাকা কাস্টমার পেমেন্ট করার সাথে সাথে পুরো টাকাটি আপনার ডিজিটাল ব্যালেন্সে যুক্ত হবে| এই টাকা কাস্টমার ব্যাংকের কিস্তির মাধ্যমে পরিশোধ করবে| ", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("৳ ${Get.arguments[4]}" + '  ' +bank.name + ' '+"for".tr,style: TextStyle(
                  fontFamily: 'Roboto',fontSize: 16
                  )),
                  SizedBox(height: 10,),
                  Text('emi_options:'.tr,style: TextStyle(
                      fontFamily: 'Roboto',fontSize: 16
                  )),
                  SizedBox(height: 20,),
                  bank.month3Fee != null
                      ? Container(
                          decoration: Utils.getBoxShape(),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                onTap: () => Get
                                    .to(EmiPaymentLink(),
                                    arguments: [
                                      shop.id, //shop 0
                                  Get.arguments[1], // name 1
                                  Get.arguments[2], //phone 2
                                  Get.arguments[3], //address 3
                                  Get.arguments[4], // amount 4
                                  "3", //5
                                  getAmount(
                                      double.parse(Get.arguments[4]),
                                      Utils
                                          .month3fee), //6 // with interest
                                  getMonthly(
                                      //monthly
                                      getAmount(
                                          double.parse(
                                              Get.arguments[4]),
                                          Utils.month3fee),
                                      3), // 7,
                                  shop //8
                                ],
                                ),
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
                                          "3_months_emi".tr,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        Text(
                                          "total_payable_amount:".tr +
                                              " ৳"+getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils.month3fee)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "৳"+getMonthly(
                                                  getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month3fee),
                                                  3)
                                              .toString() +
                                          "/month".tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
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
                                  shop.id, //shop 0
                                  Get.arguments[1], // name 1
                                  Get.arguments[2], //phone 2
                                  Get.arguments[3], //address 3
                                  Get.arguments[4], // amount 4
                                  "6", //5
                                  getAmount(
                                      double.parse(Get.arguments[4]),
                                      Utils
                                          .month6fee), // with interest 6
                                  getMonthly(
                                      //monthly
                                      getAmount(
                                          double.parse(
                                              Get.arguments[4]),
                                          Utils.month6fee),
                                      6), //7
                                  shop //8
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
                                          "6_months_emi".tr,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        Text(
                                          "total_payable_amount:".tr +
                                              " ৳"+getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils.month6fee)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "৳"+getMonthly(
                                                  getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month6fee),
                                                  6)
                                              .toString() +
                                          "/month".tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
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
                                  shop.id, //shop
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
                                      9),
                                  shop // 8
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
                                          "9_months_emi".tr,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        Text(
                                          "total_payable_amount:".tr +
                                              " ৳"+getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils.month9fee)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "৳"+getMonthly(
                                                  getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month9fee),
                                                  9)
                                              .toString() +
                                          "/month".tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
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
                                  shop.id, //shop
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
                                      12),
                                  shop
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
                                          "12_months_emi".tr,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        Text(
                                          "total_payable_amount:".tr +
                                              " ৳"+getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month12fee)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "৳"+getMonthly(
                                                  getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month12fee),
                                                  12)
                                              .toString() +
                                          "/month".tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
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
                                  shop.id, //shop
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
                                      18),
                                  shop
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
                                          "18_months_emi".tr,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        Text(
                                          "total_payable_amount:".tr +
                                              " ৳"+getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month18fee)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "৳"+getMonthly(
                                                  getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month18fee),
                                                  18)
                                              .toString() +
                                          "/month".tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
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
                                  shop.id, //shop
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
                                      24),
                                  shop
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
                                          "24_months_emi".tr,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        Text(
                                          "total_payable_amount:".tr +
                                              " ৳"+getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month24fee)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "৳"+getMonthly(
                                                  getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month24fee),
                                                  24)
                                              .toString() +
                                          "/month".tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
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
                                  shop.id, //shop
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
                                      30),
                                  shop
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
                                          "30_months_emi".tr,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        Text(
                                          "total_payable_amount:".tr +
                                              " ৳"+getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month30fee)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "৳"+getMonthly(
                                                  getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month30fee),
                                                  30)
                                              .toString() +
                                          "/month".tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
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
                                  shop.id, //shop
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
                                      36),
                                  shop // 8
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
                                          "36_months_emi".tr,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        Text(
                                          "total_payable_amount:".tr +
                                              " ৳"+getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month36fee)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "৳"+getMonthly(
                                                  getAmount(
                                                      double.parse(
                                                          Get.arguments[
                                                              4]),
                                                      Utils
                                                          .month36fee),
                                                  36)
                                              .toString() +
                                          "/month".tr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Roboto',
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
