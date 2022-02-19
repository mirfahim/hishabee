import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/digital_payment/dp_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/digital_payments_details.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/new_link.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/single_payment_details_proceed.dart';
import 'package:hishabee_business_manager_fl/models/digital_payment/digital_payment.dart';
import 'package:share_plus/share_plus.dart';

class DigitalPaymentDashboard extends StatefulWidget {
  @override
  State<DigitalPaymentDashboard> createState() => _DigitalPaymentState();
}

class _DigitalPaymentState extends State<DigitalPaymentDashboard> {
  List<DigitalPaymentModel> _list = [];
  bool isLoading = true;
  DpController _dpController = Get.find();
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'digital_payment'.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Roboto'
            ),
          ),
          actions: [
            InkWell(
              onTap: () => Get.to(Newlink()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: DEFAULT_BLUE),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10 ),
                      child: Text('create_link'.tr, style: TextStyle(
                        fontFamily: 'Roboto', fontSize: 12,color: DEFAULT_BLUE
                      ),),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  DottedBorder(
                    radius: Radius.circular(6),
                    borderType: BorderType.RRect,
                    dashPattern: [8, 4],
                    strokeWidth: 2,
                    color: Color(0xFF185ADB),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'how_to_use_digital_payment'.tr,
                              textAlign:
                              TextAlign.center,
                              style: TextStyle(
                                color:
                                Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 12
                              )),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    SvgPicture.asset('images/svg_image/share_blue_cover.svg'),
                                    SizedBox(height: 5,),
                                    Text('share_link'.tr, textAlign: TextAlign.center, style: TextStyle(
                                      fontFamily: 'Roboto',fontSize: 10,color: Color(0xFF707070)
                                    ),)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset('images/svg_image/payment_blue_cover.svg'),
                                      SizedBox(height: 5,),
                                      Text('customer_will_confirm_payment_by_sharing_payment_link'.tr, textAlign: TextAlign.center, style: TextStyle(
                                          fontFamily: 'Roboto',fontSize: 10,color: Color(0xFF707070)
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset('images/svg_image/digital_blue_cover.svg'),
                                      SizedBox(height: 5,),
                                      Text('payment_will_be_added_on_your_digital_balance'.tr, textAlign: TextAlign.center, style: TextStyle(
                                          fontFamily: 'Roboto',fontSize: 10,color: Color(0xFF707070)
                                      ),)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,bottom: 10),
                    child: Text('your_digital_payment_link'.tr, style: TextStyle(
                      fontSize: 14, fontFamily: 'Roboto'
                    ),),
                  ), 
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color(0xFFF1F1F1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(6.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "https://app.hishabee.business/pay/@" +
                                shop.slug.toString(),
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xFF707070),
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
                          style: ElevatedButton.styleFrom(
                            primary: DEFAULT_BLUE,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            "share_link".tr,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "digital_payment_link".tr,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(DigitalPaymentDetails(), arguments: shop);
                              },
                              child: Text(
                                "view_details".tr,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                    fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                ]),
              ),
              _list.length > 0
                  ? Expanded(
                    child: Container(
                child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (context, index) =>
                          GestureDetector(
                            onTap: () {
                              Get.to(SinglePaymentDetailsAndProceed(
                                name: _list[index].customerName,
                                mobileNumber: _list[index].customerMobile,
                                date: _list[index].createdAt,
                                digitalPaymentAmount: _list[index].amount,
                                status: _list[index].paymentStatus,
                              ),
                                  arguments: shop);
                            },
                            child: Card(
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Text(
                                            "" +
                                                _list[index]
                                                    .customerName
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Roboto',
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          "#" +
                                              _list[index]
                                                  .id
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF707070),
                                              fontWeight:
                                              FontWeight.bold),
                                        ),

                                        Text(
                                          "" +
                                              _list[index]
                                                  .createdAt
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                              FontWeight.w400,
                                          color: Color(0xFF707070)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                            "৳" +
                                                _list[index].amount
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.w700)),
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(color: _list[index]
                                                    .paymentStatus
                                                    .toString() == 'Pending' ? Colors.red : DEFAULT_BLUE)
                                            ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                                "" +
                                                    _list[index]
                                                        .paymentStatus
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: _list[index]
                                                        .paymentStatus
                                                        .toString() == 'Pending' ? Colors.red : Colors.green,
                                                    fontWeight:
                                                    FontWeight.w700)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
              ),
                  )
                  : Expanded(child: Center(child: Text("No Payments found")))
            ],
          ),
        ),
      ),
    );
  }

  void getData() {
    _dpController.fetchDp(shopId: shop.id).then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          _list = digitalPaymentModelFromJson(value);
          // print('shop id: ${shop.id}');
        });
      }
    });
  }
}
