import 'dart:io';
import 'dart:math';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_app_bar.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_left_menue.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/widgets/sell_receipt.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';

class SoldPage extends StatefulWidget {
  final Shop shop;
  final int route;
  final int totalPrice;
  final int discount;
  final int vat;
  final int totalAmount;
  final Transactions transaction;
  final RxList<Product> productList;

  const SoldPage(
      {Key key,
      this.shop,
      this.discount,
      this.totalPrice,
      this.vat,
      this.route,
      this.totalAmount,
      this.productList,
      this.transaction})
      : super(key: key);

  @override
  _SoldPageState createState() => _SoldPageState();
}

class _SoldPageState extends State<SoldPage> {
  ConfettiController _controllerCenter;
  ConfettiController _controllerCenterRight;
  ConfettiController _controllerCenterLeft;
  ConfettiController _controllerTopCenter;
  ConfettiController _controllerBottomCenter;
  final SellController sc = Get.find();

  bool hideDone = false;

  File file;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(microseconds: 100));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));

    super.initState();
    _controllerCenter.play();
    //to generatePdf
    //generatePdf(widget.shop, widget.transaction);

    Future.delayed(const Duration(seconds: 5), () {
      _controllerCenter.stop();
      setState(() {
        hideDone = true;
      });
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height - 70,
              width: size.width,
              child: Stack(
                children: <Widget>[
                  //CENTER -- Blast
                  Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: _controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      // don't specify a direction, blast randomly
                      shouldLoop: true,
                      // start again as soon as the animation is finished
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple
                      ],
                      // manually specify the colors to be used
                      createParticlePath:
                          drawStar, // define a custom shape/path.
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ScaleAnimatedWidget.tween(
                      enabled: true,
                      duration: Duration(milliseconds: 800),
                      scaleDisabled: 0.5,
                      scaleEnabled: 1,
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: Colors.lightBlueAccent, width: 5),
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  hideDone == false
                      ? Align(
                          alignment: Alignment.center,
                          child: ScaleAnimatedWidget.tween(
                            enabled: true,
                            duration: Duration(milliseconds: 800),
                            scaleDisabled: 0.5,
                            scaleEnabled: 1,
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: Colors.lightBlueAccent, width: 5),
                                color: Colors.blue,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 100.0, bottom: 100),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: size.width,
                                        color: DEFAULT_YELLOW_BG,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Receipt",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${widget.shop.name}",
                                                      style: TextStyle(
                                                          color: DEFAULT_BLACK,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${widget.shop.publicNumber}",
                                                      style: TextStyle(
                                                          color: DEFAULT_BLACK,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${widget.shop.address}",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Customer",
                                                    style: TextStyle(
                                                        color: DEFAULT_BLACK,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    widget.shop.name.isEmpty ||
                                                            widget.shop.name ==
                                                                null
                                                        ? "Not Given"
                                                        : "${widget.shop.name}",
                                                    style: TextStyle(
                                                        color: DEFAULT_BLACK,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Sell Time",
                                                    style: TextStyle(
                                                        color: DEFAULT_BLACK,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    Utility.dateTimeFormat
                                                        .format(DateTime.now()),
                                                    style: TextStyle(
                                                        color: DEFAULT_BLACK,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Total Amount",
                                                    style: TextStyle(
                                                        color: DEFAULT_BLACK,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "${widget.totalPrice}",
                                                    style: TextStyle(
                                                        color: DEFAULT_BLACK,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Divider(
                                        color: DEFAULT_BLACK,
                                        thickness: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: size.width * 0.35,
                                              child: Text(
                                                "Product Name",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8,
                                                left: 5,
                                                right: 5),
                                            child: Container(
                                              width: size.width * 0.15,
                                              child: Center(
                                                child: Text(
                                                  "price",
                                                  style: TextStyle(
                                                      color: DEFAULT_BLACK,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8,
                                                left: 5,
                                                right: 5),
                                            child: Container(
                                              width: size.width * 0.15,
                                              child: Text(
                                                "Quantity",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 8,
                                                  left: 5,
                                                  right: 5),
                                              child: Container(
                                                width: size.width * 0.17,
                                                child: Text(
                                                  "Total Price",
                                                  style: TextStyle(
                                                      color: DEFAULT_BLACK,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Divider(
                                        color: DEFAULT_BLACK,
                                        thickness: 2,
                                      ),
                                      MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: sc.cart.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Product item = sc.cart[index];

                                            return Container(
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width:
                                                              size.width * 0.35,
                                                          child: Text(
                                                            "${item.name}",
                                                            style: TextStyle(
                                                                color:
                                                                    DEFAULT_BLACK,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 8,
                                                                left: 5,
                                                                right: 5),
                                                        child: Container(
                                                          width:
                                                              size.width * 0.15,
                                                          child: Center(
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "${item.sellingPrice}",
                                                                style: TextStyle(
                                                                    color:
                                                                        DEFAULT_BLACK,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 8,
                                                                left: 5,
                                                                right: 5),
                                                        child: Container(
                                                          width:
                                                              size.width * 0.15,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "1",
                                                              style: TextStyle(
                                                                  color:
                                                                      DEFAULT_BLACK,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0,
                                                                  bottom: 8,
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Container(
                                                            width: size.width *
                                                                0.17,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "${item.sellingPrice * 1}",
                                                                style: TextStyle(
                                                                    color:
                                                                        DEFAULT_BLACK,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: DEFAULT_BLACK
                                                        .withOpacity(0.5),
                                                    thickness: 2,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                "Total price :",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Container(
                                                  width: size.width * 0.17,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "${widget.totalPrice} Tk",
                                                      style: TextStyle(
                                                          color: DEFAULT_BLACK,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                "(-) Discount :",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Container(
                                                  width: size.width * 0.17,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      " ${widget.discount.toString()} Tk",
                                                      style: TextStyle(
                                                          color: DEFAULT_BLACK,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                "vat :",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Container(
                                                  width: size.width * 0.17,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      " ${widget.vat.toString()}" +
                                                          " tk",
                                                      style: TextStyle(
                                                          color: DEFAULT_BLACK,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            width: 100,
                                            child: Divider(
                                              color: DEFAULT_BLACK
                                                  .withOpacity(0.5),
                                            )),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                "Total Amount :",
                                                style: TextStyle(
                                                    color: DEFAULT_BLACK,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Container(
                                                  width: size.width * 0.17,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "${widget.totalPrice} Tk",
                                                      style: TextStyle(
                                                          color: DEFAULT_BLACK,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 10),
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          //
                                                          Get.to(() =>
                                                              SellReceiptPage(
                                                                  widget.shop,
                                                                  widget
                                                                      .transaction));
                                                        },
                                                        icon: Icon(Icons
                                                            .arrow_circle_down)),
                                                    Text("Receipt Print"),
                                                  ],
                                                ),
                                                SizedBox(width: 20),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Get.to(() =>
                                                              SellReceiptPage(
                                                                  widget.shop,
                                                                  widget
                                                                      .transaction));
                                                          //*
                                                        },
                                                        icon: Icon(Icons
                                                            .arrow_circle_down)),
                                                    Text("Receipt Share"),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: _controllerTopCenter,
                      blastDirection: pi / 2,
                      maxBlastForce: 5,
                      // set a lower max blast force
                      minBlastForce: 2,
                      // set a lower min blast force
                      emissionFrequency: 0.05,
                      numberOfParticles: 50,
                      // a lot of particles at once
                      gravity: 1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Container(
                        width: size.width,
                        child: Column(
                          children: [
                            hideDone == true
                                ? Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.cancel_presentation,
                                            size: 32,
                                            color: DEFAULT_BLACK,
                                          ),
                                          onPressed: () {
                                            if (widget.route == 1) {
                                              Get.back();
                                              Get.back();
                                            } else {
                                              Get.back();
                                              Get.back();
                                              Get.back();
                                              Get.back();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "sold".tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${widget.totalPrice} TK",
                                  style: TextStyle(
                                      color: DEFAULT_BLUE,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "worth_of_product".tr,
                                  style: TextStyle(
                                      color: DEFAULT_BLACK,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //BOTTOM CENTER
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ConfettiWidget(
                      confettiController: _controllerBottomCenter,
                      blastDirection: -pi / 2,
                      emissionFrequency: 0.01,
                      numberOfParticles: 20,
                      maxBlastForce: 100,
                      minBlastForce: 80,
                      gravity: 0.3,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          hideDone == false
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    width: size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "change_amount".tr,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "0 TK",
                                            style: TextStyle(
                                                color: DEFAULT_BLUE,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          hideDone == true
                              ? InkWell(
                                  onTap: () {
                                    if (widget.route == 1) {
                                      Get.back();
                                      Get.back();
                                    } else {
                                      Get.back();
                                      Get.back();
                                      Get.back();
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: DEFAULT_BLACK,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "start_another_sale".tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
