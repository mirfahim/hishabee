import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/digital_payment/dp_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/new_link.dart';
import 'package:hishabee_business_manager_fl/models/digital_payment/digital_payment.dart';
import 'package:share_plus/share_plus.dart';

class DigitalPaymentDashboard extends StatefulWidget {
  @override
  State<DigitalPaymentDashboard> createState() => _DigitalPaymentState();
}

class _DigitalPaymentState extends State<DigitalPaymentDashboard> {
  List<DigitalPaymentModel> _list = <DigitalPaymentModel>[];
  bool isLoading = true;
  DpController controller = Get.find();
  Shop shop = Get.arguments;
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
              child: Stack(children: [
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
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
                      padding: EdgeInsets.only(top: 14.0, right: 55),
                      child: Text(
                        'Digital Payment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: ElevatedButton(
                        onPressed: () => Get.to(Newlink()),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: Text(
                          "New Link",
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 80,
                    left: 10,
                    right: 10,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'images/shop_features/question.png',
                              height: 100,
                              width: 70,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'How does this work?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                                Text(
                                  '1.Share payment link',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11),
                                ),
                                Text(
                                  '2.Customer opens the link and pay',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11),
                                ),
                                Text(
                                  '3.Payment is credited to your digital balance',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11),
                                ),
                                Text(
                                  '4.Request for a payout from app',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),

                Positioned(
                    top: 230,
                    left: 10,
                    right: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow.shade100,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "https://app.hishabee.business/pay/@" +
                                  shop.slug.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () => Share.share(
                              "https://app.hishabee.business/pay/@" +
                                  shop.slug.toString(),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text(
                              "SHARE  LINK",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Active Links",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 16.0),
                          ),
                        ),
                        _list.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: _list.length,
                                itemBuilder: (context, index) => Card(
                                      elevation: 2.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "#" +
                                                      _list[index]
                                                          .id
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "" +
                                                      _list[index]
                                                          .amount
                                                          .toString() +
                                                      " BDT",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "" +
                                                      _list[index]
                                                          .createdAt
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                "" +
                                                    _list[index]
                                                        .paymentStatus
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w700))
                                          ],
                                        ),
                                      ),
                                    ))
                            : Center(child: CircularProgressIndicator())
                      ],
                    )),

////,
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void getData() {
    controller.fetchDp(shopId: "").then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          _list = digitalPaymentModelFromJson(value);
        });
      }
    });
  }
}
