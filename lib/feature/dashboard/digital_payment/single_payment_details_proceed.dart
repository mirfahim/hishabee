import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/digital_payment/dp_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/digital_payments_details.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/new_link.dart';
import 'package:hishabee_business_manager_fl/models/digital_payment/digital_payment.dart';
import 'package:share_plus/share_plus.dart';

class SinglePaymentDetailsAndProceed extends StatefulWidget {
  @override
  State<SinglePaymentDetailsAndProceed> createState() => _DigitalPaymentState();
}

class _DigitalPaymentState extends State<SinglePaymentDetailsAndProceed> {
  List<DigitalPaymentModel> _list = [];
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
                        onPressed: () => Get.back(),
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
                    top: 150,
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
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    String url =
                                        "https://app.hishabee.business/pay/@" +
                                            shop.slug.toString();
                                    Utility.launchURL(url);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(.35)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'images/svg_image/visit.svg'),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10,
                                              top: 20,
                                              bottom: 20),
                                          child: Text(
                                            'visit'.tr,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                color: DEFAULT_BLUE),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text:
                                            "https://app.hishabee.business/pay/@" +
                                                shop.slug.toString()));
                                    var snackBar = SnackBar(
                                      content: Text('Copied to clipboard '),
                                      duration: Duration(milliseconds: 200),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(.35)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'images/svg_image/copy.svg',
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10,
                                                top: 20,
                                                bottom: 20),
                                            child: Align(
                                                child: Text(
                                              'copy_url'.tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto',
                                                  color: DEFAULT_BLUE),
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(.8),
                          indent: 5,
                          endIndent: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'share_link'.tr,
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Roboto'),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        String shopUrl =
                                            "https://app.hishabee.business/pay/@" +
                                                shop.slug.toString();
                                        Share.share(
                                            'Check out our website $shopUrl');
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            'images/svg_image/sms.svg',
                                            height: 50,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'sms'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        String shopUrl =
                                            "https://app.hishabee.business/pay/@" +
                                                shop.slug.toString();
                                        Share.share(
                                            'Check out our website $shopUrl');
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            'images/svg_image/whatsapp.svg',
                                            height: 50,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'whatsapp'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        String shopUrl =
                                            "https://app.hishabee.business/pay/@" +
                                                shop.slug.toString();
                                        Share.share(
                                            'Check out our website $shopUrl');
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            'images/svg_image/messenger.svg',
                                            height: 50,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'messenger'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        String shopUrl =
                                            "https://app.hishabee.business/pay/@" +
                                                shop.slug.toString();
                                        Share.share(
                                            'Check out our website $shopUrl');
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            'images/svg_image/gmail.svg',
                                            height: 50,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'email'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        String shopUrl =
                                            "https://app.hishabee.business/pay/@" +
                                                shop.slug.toString();
                                        Share.share(
                                            'Check out our website $shopUrl');
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            'images/svg_image/scanner.svg',
                                            height: 50,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'scanner'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        String shopUrl =
                                            "https://app.hishabee.business/pay/@" +
                                                shop.slug.toString();
                                        Share.share(
                                            'Check out our website $shopUrl');
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            'images/svg_image/others.svg',
                                            height: 50,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'others'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          String url =
                                              "https://app.hishabee.business/pay/@" +
                                                  shop.slug.toString();
                                          Utility.launchURL(url);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(.35)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'images/svg_image/visit.svg'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 20,
                                                    bottom: 20),
                                                child: Text(
                                                  'visit'.tr,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Roboto',
                                                      color: DEFAULT_BLUE),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                              text:
                                                  "https://app.hishabee.business/pay/@" +
                                                      shop.slug.toString()));
                                          var snackBar = SnackBar(
                                            content:
                                                Text('Copied to clipboard '),
                                            duration:
                                                Duration(milliseconds: 200),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(.35)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'images/svg_image/copy.svg',
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10,
                                                          top: 20,
                                                          bottom: 20),
                                                  child: Align(
                                                      child: Text(
                                                    'copy_url'.tr,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'Roboto',
                                                        color: DEFAULT_BLUE),
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
    controller.fetchDp(shopId: "8").then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          _list = digitalPaymentModelFromJson(value);
        });
      }
    });
  }
}
