import 'package:flutter/cupertino.dart';
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
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class SinglePaymentDetailsAndProceed extends StatefulWidget {

  String name;
  String mobileNumber;
  dynamic date;
  var digitalPaymentAmount;
  String status;

  SinglePaymentDetailsAndProceed({this.name, this.mobileNumber, this.date, this.digitalPaymentAmount,this.status});
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
        backgroundColor: Colors.white,
        bottomSheet: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      onPressed: () async{


                      },
                      style: TextButton.styleFrom(primary: Colors.blue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Icon(Icons.edit),
                          Text('edit'.tr)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      onPressed: () async {

                      },
                      style: TextButton.styleFrom(primary: Colors.red),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Icon(Icons.delete),
                          Text('delete'.tr)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
          titleSpacing: 0,
          title: Text(
            'digital_payment'.tr,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,top: 30.0, right: 10),
            child: Column(
              children: [
                Text('${widget.name}', style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16
                ),),
                SizedBox(height: 5,),
                Text('${widget.mobileNumber}', style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  color: Color(0xFF707070)
                ),),
                SizedBox(height: 5,),
                Text('${widget.date}', style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Color(0xFF707070)
                ),),
                SizedBox(height: 30,),
                Text('amount_of_digital_payment'.tr, style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                Text('৳${widget.digitalPaymentAmount}', style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                  color: DEFAULT_BLUE
                ),),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: widget
                          .status
                          .toString() == 'Pending' ? Colors.red : DEFAULT_BLUE)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('${widget.status}', style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: DEFAULT_BLUE
                    ),),
                  ),
                ),
                SizedBox(height: 30,),
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
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 42,
                //   child: ElevatedButton(
                //     onPressed: () => Share.share(
                //       "https://app.hishabee.business/pay/@" +
                //           shop.slug.toString(),
                //     ),
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all<Color>(
                //           Colors.black),
                //     ),
                //     child: Text(
                //       "SHARE  LINK",
                //       style: TextStyle(
                //           fontSize: 14.0,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.white),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // String url =
                          //     "https://app.hishabee.business/pay/@" +
                          //         shop.slug.toString();
                          // Utility.launchURL(url);
                          Share.share(
                            "https://app.hishabee.business/pay/@" +
                                shop.slug.toString(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F1F1),
                              border: Border.all(
                                  color:
                                  Color(0xFFF1F1F1)),
                              borderRadius:
                                  BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share, color: DEFAULT_BLUE,),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10,
                                    top: 20,
                                    bottom: 20),
                                child: Text(
                                  'share'.tr,
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
                            color: Color(0xFFF1F1F1),
                              border: Border.all(
                                  color:
                                      Color(0xFFF1F1F1)),
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('images/svg_image/sms.svg'),
                      ),
                      SizedBox(width: 5,),
                      Text('sms_payment_link_share'.tr, style: TextStyle(
                        fontSize: 12, fontFamily: 'Roboto'
                      ),)
                    ],
                  ),
                )
                // Padding(
                //   padding: EdgeInsets.only(top: 10, bottom: 10),
                //   child: Align(
                //       alignment: Alignment.center,
                //       child: Text(
                //         'share_link'.tr,
                //         style: TextStyle(
                //             fontSize: 20, fontFamily: 'Roboto'),
                //       )),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 15),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         children: [
                //           Expanded(
                //             child: GestureDetector(
                //               onTap: () {
                //                 String shopUrl =
                //                     "https://app.hishabee.business/pay/@" +
                //                         shop.slug.toString();
                //                 Share.share(
                //                     'Check out our website $shopUrl');
                //               },
                //               child: Column(
                //                 children: [
                //                   SvgPicture.asset(
                //                     'images/svg_image/sms.svg',
                //                     height: 50,
                //                   ),
                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                   Text(
                //                     'sms'.tr,
                //                     style: TextStyle(
                //                         fontFamily: 'Roboto',
                //                         fontSize: 16),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //           Expanded(
                //             child: GestureDetector(
                //               onTap: () {
                //                 String shopUrl =
                //                     "https://app.hishabee.business/pay/@" +
                //                         shop.slug.toString();
                //                 Share.share(
                //                     'Check out our website $shopUrl');
                //               },
                //               child: Column(
                //                 children: [
                //                   SvgPicture.asset(
                //                     'images/svg_image/whatsapp.svg',
                //                     height: 50,
                //                   ),
                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                   Text(
                //                     'whatsapp'.tr,
                //                     style: TextStyle(
                //                         fontFamily: 'Roboto',
                //                         fontSize: 16),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //           Expanded(
                //             child: GestureDetector(
                //               onTap: () {
                //                 String shopUrl =
                //                     "https://app.hishabee.business/pay/@" +
                //                         shop.slug.toString();
                //                 Share.share(
                //                     'Check out our website $shopUrl');
                //               },
                //               child: Column(
                //                 children: [
                //                   SvgPicture.asset(
                //                     'images/svg_image/messenger.svg',
                //                     height: 50,
                //                   ),
                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                   Text(
                //                     'messenger'.tr,
                //                     style: TextStyle(
                //                         fontFamily: 'Roboto',
                //                         fontSize: 16),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //       Row(
                //         children: [
                //           Expanded(
                //             child: GestureDetector(
                //               onTap: () {
                //                 String shopUrl =
                //                     "https://app.hishabee.business/pay/@" +
                //                         shop.slug.toString();
                //                 Share.share(
                //                     'Check out our website $shopUrl');
                //               },
                //               child: Column(
                //                 children: [
                //                   SvgPicture.asset(
                //                     'images/svg_image/gmail.svg',
                //                     height: 50,
                //                   ),
                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                   Text(
                //                     'email'.tr,
                //                     style: TextStyle(
                //                         fontFamily: 'Roboto',
                //                         fontSize: 16),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //           Expanded(
                //             child: GestureDetector(
                //               onTap: () {
                //                 String shopUrl =
                //                     "https://app.hishabee.business/pay/@" +
                //                         shop.slug.toString();
                //                 Share.share(
                //                     'Check out our website $shopUrl');
                //               },
                //               child: Column(
                //                 children: [
                //                   SvgPicture.asset(
                //                     'images/svg_image/scanner.svg',
                //                     height: 50,
                //                   ),
                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                   Text(
                //                     'scanner'.tr,
                //                     style: TextStyle(
                //                         fontFamily: 'Roboto',
                //                         fontSize: 16),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //           Expanded(
                //             child: GestureDetector(
                //               onTap: () {
                //                 String shopUrl =
                //                     "https://app.hishabee.business/pay/@" +
                //                         shop.slug.toString();
                //                 Share.share(
                //                     'Check out our website $shopUrl');
                //               },
                //               child: Column(
                //                 children: [
                //                   SvgPicture.asset(
                //                     'images/svg_image/others.svg',
                //                     height: 50,
                //                   ),
                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                   Text(
                //                     'others'.tr,
                //                     style: TextStyle(
                //                         fontFamily: 'Roboto',
                //                         fontSize: 16),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 40.0),
                //         child: Row(
                //           mainAxisAlignment:
                //               MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Expanded(
                //               child: InkWell(
                //                 onTap: () {
                //                   String url =
                //                       "https://app.hishabee.business/pay/@" +
                //                           shop.slug.toString();
                //                   Utility.launchURL(url);
                //                 },
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                       border: Border.all(
                //                           color: Colors.grey
                //                               .withOpacity(.35)),
                //                       borderRadius:
                //                           BorderRadius.circular(10)),
                //                   child: Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                           'images/svg_image/visit.svg'),
                //                       Padding(
                //                         padding: const EdgeInsets.only(
                //                             left: 10.0,
                //                             right: 10,
                //                             top: 20,
                //                             bottom: 20),
                //                         child: Text(
                //                           'visit'.tr,
                //                           style: TextStyle(
                //                               fontSize: 16,
                //                               fontFamily: 'Roboto',
                //                               color: DEFAULT_BLUE),
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //               width: 20,
                //             ),
                //             Expanded(
                //               child: InkWell(
                //                 onTap: () {
                //                   Clipboard.setData(ClipboardData(
                //                       text:
                //                           "https://app.hishabee.business/pay/@" +
                //                               shop.slug.toString()));
                //                   var snackBar = SnackBar(
                //                     content:
                //                         Text('Copied to clipboard '),
                //                     duration:
                //                         Duration(milliseconds: 200),
                //                   );
                //
                //                   ScaffoldMessenger.of(context)
                //                       .showSnackBar(snackBar);
                //                 },
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                       border: Border.all(
                //                           color: Colors.grey
                //                               .withOpacity(.35)),
                //                       borderRadius:
                //                           BorderRadius.circular(10)),
                //                   child: Align(
                //                     alignment: Alignment.center,
                //                     child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.center,
                //                       children: [
                //                         SvgPicture.asset(
                //                           'images/svg_image/copy.svg',
                //                           height: 20,
                //                         ),
                //                         Padding(
                //                           padding:
                //                               const EdgeInsets.only(
                //                                   left: 10.0,
                //                                   right: 10,
                //                                   top: 20,
                //                                   bottom: 20),
                //                           child: Align(
                //                               child: Text(
                //                             'copy_url'.tr,
                //                             style: TextStyle(
                //                                 fontSize: 16,
                //                                 fontFamily: 'Roboto',
                //                                 color: DEFAULT_BLUE),
                //                           )),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ,
                SizedBox(
                  height: 10,
                ),

              ],
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
