import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/digital_payment.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class EmiPaymentLink extends StatelessWidget {
  EmiController _controller = EmiController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double withInterestAmount = Get.arguments[6];
    double withoutInterestAmount = double.parse(Get.arguments[4]);
    double serviceCharge = withInterestAmount - withoutInterestAmount;
    var storage = GetStorage();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stackpo(
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
                                  Get.arguments[4].toString() +
                                      " টাকা কাস্টমার পেমেন্ট করার সাথে সাথে পুরো টাকাটি আপনার ডিজিটাল ব্যালেন্সে যুক্ত হবে| এই টাকা কাস্টমার ব্যাংকের কিস্তির মাধ্যমে পরিশোধ করবে| ",
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(22.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Number of Payment "),
                                    Text(
                                      "" + Get.arguments[5].toString(),
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0, right: 22.0, bottom: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("EMI Amount "),
                                    Text(
                                      Get.arguments[7].toString() + "/Month",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 5,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0,
                                    right: 22.0,
                                    top: 30.0,
                                    bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("EMI Amount "),
                                    Text(
                                      "" + Get.arguments[4].toString(),
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0, right: 22.0, bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Service Charge "),
                                    Text(
                                      "" + (serviceCharge).toString(),
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0, right: 22.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Payable(With Charge) "),
                                    Text(
                                      "" + withInterestAmount.toString(),
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 55.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 28.0, right: 25.0),
                              child: InkWell(
                                onTap: () => _controller
                                    .submitEmi(
                                        shop_id: storage.read("shop_id"),
                                        amount:
                                            withoutInterestAmount.toString(),
                                        customerName: Get.arguments[1],
                                        customerPhone: Get.arguments[2],
                                        customerAddress: Get.arguments[3],
                                        installment:
                                            Get.arguments[5].toString(),
                                        payable: withInterestAmount.toString())
                                    .then((value) {
                                  Utils.showToast("Submitted Successfully");
                                  Get.to(DigitalPayment(),
                                      arguments: value["url"]);
                                }),
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35.0, top: 14.0, bottom: 14.0),
                                    child: Text(
                                      "CREATE PAYMENT LINK",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
}
