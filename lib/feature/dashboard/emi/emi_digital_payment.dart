import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/digital_payment/dp_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/digital_payments_details.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/new_link.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/create_sms.dart';
import 'package:hishabee_business_manager_fl/models/digital_payment/digital_payment.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'emi.dart';

class SinglePaymentDetailsAndProceed extends StatefulWidget {

  var digitalPaymentAmount;


  SinglePaymentDetailsAndProceed({ this.digitalPaymentAmount});
  @override
  State<SinglePaymentDetailsAndProceed> createState() => _SinglePaymentDetailsAndProceed();
}

class _SinglePaymentDetailsAndProceed extends State<SinglePaymentDetailsAndProceed> {
  Shop shop = Get.arguments[0];
  String url = Get.arguments[1];
  List<DigitalPaymentModel> _list = [];
  bool isLoading = true;
  DpController controller = Get.find();
  EmiController _emiController = Get.find();
  SmsController _smsController = SmsController();
  // Shop shop = Get.arguments;
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
      // /sadasd
      child: Scaffold(
        // bottomSheet: Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Expanded(
        //         child: Container(
        //           decoration: BoxDecoration(
        //               color: Color(0xFFF1F1F1),
        //               borderRadius: BorderRadius.circular(6)
        //           ),
        //           child: Padding(
        //             padding: const EdgeInsets.all(4.0),
        //             child: TextButton(
        //               onPressed: () async{
        //
        //
        //               },
        //               style: TextButton.styleFrom(primary: Colors.blue),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children:  [
        //                   Icon(Icons.edit),
        //                   Text('edit'.tr)
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: 10,),
        //       Expanded(
        //         child: Container(
        //           decoration: BoxDecoration(
        //               color: Color(0xFFF1F1F1),
        //               borderRadius: BorderRadius.circular(6)
        //           ),
        //           child: Padding(
        //             padding: const EdgeInsets.all(4.0),
        //             child: TextButton(
        //               onPressed: () async {
        //
        //               },
        //               style: TextButton.styleFrom(primary: Colors.red),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children:  [
        //                   Icon(Icons.delete),
        //                   Text('delete'.tr)
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_back_rounded,
        //       color: Colors.black,
        //     ),
        //     onPressed: () => Get.back(),
        //   ),
        //   backgroundColor: Colors.amber,
        //   titleSpacing: 0,
        //   title: Text(
        //     'digital_payment'.tr,
        //     style: TextStyle(fontSize: 18,color: Colors.black),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,top: 30.0, right: 10),
            child: Column(
              children: [

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
                      "$url",
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // String url =
                            //     "https://app.hishabee.business/pay/@" +
                            //         shop.slug.toString();
                            // Utility.launchURL(url);
                            // Share.share(
                            //   "${url}"
                            // );
                            Utility.launchURL(url);
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
                                Icon(Icons.open_in_browser, color: DEFAULT_BLUE,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10,
                                      top: 20,
                                      bottom: 20),
                                  child: Text(
                                    'visit_link'.tr,
                                    style: TextStyle(
                                        fontSize: 12,
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
                                "${url}"));
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
                                              fontSize: 12,
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
                // InkWell(
                //   // onTap: (){
                //   //   _smsController.selectedMobileNumber.value.add(widget.mobileNumber);
                //   //   _smsController.textInTheMessageField.value = "https://app.hishabee.business/pay/@" +
                //   //       shop.slug.toString();
                //   //   Get.to(
                //   //         () => SmsCreatePage(),
                //   //     arguments: {
                //   //       "shop": shop,
                //   //     },
                //   //   );
                //   //   print(_smsController.selectedMobileNumber.value);
                //   //   print(_smsController.textInTheMessageField.value);
                //   // },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Color(0xFFF1F1F1),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //     child: Row(
                //       children: [
                //
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: SvgPicture.asset('images/svg_image/sms.svg'),
                //         ),
                //         SizedBox(width: 5,),
                //         Text('sms_payment_link_share'.tr, style: TextStyle(
                //             fontSize: 12, fontFamily: 'Roboto'
                //         ),)
                //       ],
                //     ),
                //   ),
                // )
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
                SizedBox(
                  height: 10,
                ),
                Divider(thickness: 1, color: Colors.grey,),
                Center(
                  child: Text('Share Link',textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 20, fontFamily: 'Roboto', fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap:(){
                          launch('sms:?body=Please pay BDT ${widget.digitalPaymentAmount} to ${shop.name} through this: link $url');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/sms.svg', height: 40,),
                            SizedBox(height: 10,),
                            Text('S M S', style: TextStyle(
                              fontSize: 18
                            ),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          var whatsappUrl ="whatsapp://send?phone=";
                          launch(url);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/whatsapp.svg', height: 40),
                            SizedBox(height: 10,),
                            Text('WhatsApp', style: TextStyle(
                                fontSize: 18
                            ),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SvgPicture.asset('images/svg_image/messenger.svg', height: 40),
                          SizedBox(height: 10,),
                          Text('Messenger', style: TextStyle(
                              fontSize: 18
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          // Utility.launchURL(url);
                          print(shop.name);
                          launch('mailto:?subject=Payment to ${shop.name}&body=Please pay BDT ${widget.digitalPaymentAmount} to ${shop.name} through this: link $url');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/gmail.svg', height: 40,),
                            SizedBox(height: 5,),
                            Text('Email', style: TextStyle(
                                fontFamily: 'Roboto', fontSize: 18
                            ),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SvgPicture.asset('images/svg_image/scanner.svg', height: 40,),
                          SizedBox(height: 5,),
                          Text('QR Code', style: TextStyle(
                              fontFamily: 'Roboto', fontSize: 18
                          ),)
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Share.share(
                              "$url"
                          );
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/share.svg', height: 40,),
                            SizedBox(height: 5,),
                            Text('Others', style: TextStyle(
                                fontFamily: 'Roboto', fontSize: 18
                            ),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.to(EMI(), arguments: shop);
                    _emiController.nameController.text = '';
                    _emiController.mobileController.text = '';
                    _emiController.addressController.text = '';
                    _emiController.bankName.value = '';
                    _emiController.emiMoney.text = '';
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('go_back'.tr, textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getData() {
    controller.fetchDp(shopId: shop.id).then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          _list = digitalPaymentModelFromJson(value);
        });
      }
    });
  }
}
