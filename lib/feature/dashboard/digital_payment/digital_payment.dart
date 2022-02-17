import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/digital_payment/dp_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/new_link.dart';
import 'package:hishabee_business_manager_fl/models/digital_payment/digital_payment.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dotted_border/dotted_border.dart';
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
        appBar: AppBar(
          leading: IconButton(
            icon:  Icon(
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
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "create_link".tr,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF185ADB).withOpacity(.05)
                    ),
                    child: DottedBorder(
                      radius: Radius.circular(6),
                      borderType: BorderType.RRect,
                      dashPattern: [8, 4],
                      strokeWidth: 2,
                      color: Color(0xFF185ADB),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('how_to_use_digital_payment'.tr,textAlign: TextAlign.center, style: TextStyle(
                              fontFamily: 'Roboto', fontSize: 12,
                            ),),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset('images/svg_image/share_blue_cover.svg'),
                                        Text('share_link'.tr,textAlign: TextAlign.center, style: TextStyle(
                                            fontSize: 10, fontFamily: 'Roboto',color: Color(0xFF707070)
                                        ),)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset('images/svg_image/payment_blue_cover.svg'),
                                        Text('customer_will_confirm_payment_by_sharing_payment_link'.tr,textAlign: TextAlign.center, style: TextStyle(
                                            fontSize: 10, fontFamily: 'Roboto',color: Color(0xFF707070)
                                        ),)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset('images/svg_image/digital_blue_cover.svg'),
                                        Text('payment_will_be_added_on_your_digital_balance'.tr,textAlign: TextAlign.center, style: TextStyle(
                                            fontSize: 10, fontFamily: 'Roboto',color: Color(0xFF707070)
                                        ),)
                                      ],
                                    ),
                                  )


                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                Column(
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
              ),

////,
            ]),
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
