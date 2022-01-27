// import 'package:clipboard/clipboard.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
// // import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
// import 'package:flutter_share/flutter_share.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
// import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_digital_payment_controller.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// class DigitalPaymentPage extends GetView<DueDigitalPaymentController> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: DEFAULT_BODY_BG_COLOR,
//       body: SafeArea(
//         child: ListView(
//           physics: NeverScrollableScrollPhysics(),
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 40.0),
//               child: Center(
//                   child: Text(
//                 "digital_payment".tr,
//                 style: TextStyle(
//                     color: DEFAULT_BLACK,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold),
//               )),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15.0),
//               child: Center(
//                   child: Obx(
//                 () => Text(
//                   "${controller.givenAmount.value} " + "tk".tr,
//                   style: TextStyle(
//                       color: DEFAULT_BLUE,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15.0, right: 20, left: 20),
//               child: Container(
//                 width: size.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: DEFAULT_BLACK),
//                 ),
//                 child: Center(
//                   child: Obx(
//                     () => Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Text(
//                         "${controller.url.value}",
//                         style: TextStyle(
//                             color: DEFAULT_BLUE,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15.0, right: 20, left: 20),
//               child: Center(
//                   child: Text(
//                 "share_this_url_with_your_customer_to_receive_payment".tr,
//                 style: TextStyle(
//                     color: DEFAULT_BLACK,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold),
//               )),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       String url = "${controller.url.value}";
//                       Utility.launchURL(url);
//                     },
//                     child: Container(
//                       height: 60,
//                       width: size.width * 0.4,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: DEFAULT_BLACK)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                               height: 30,
//                               width: 30,
//                               child: SvgPicture.asset(
//                                 "images/svg_image/website.svg",
//                               )),
//                           Container(
//                             width: size.width * 0.2,
//                             child: Text(
//                               "visit_url".tr,
//                               style: TextStyle(
//                                   color: DEFAULT_BLUE,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       FlutterClipboard.copy("${controller.url.value}")
//                           .then((value) => {
//                                 Fluttertoast.showToast(
//                                     msg: "Copied Link to Clipboard"),
//                               });
//                     },
//                     child: Container(
//                       height: 60,
//                       width: size.width * 0.4,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: DEFAULT_BLACK)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                               height: 30,
//                               width: 30,
//                               child: SvgPicture.asset(
//                                   "images/svg_image/copy.svg")),
//                           Container(
//                             width: size.width * 0.2,
//                             child: Text(
//                               "copy_url".tr,
//                               style: TextStyle(
//                                   color: DEFAULT_BLUE,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
//               child: Divider(
//                 color: DEFAULT_BLACK,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
//               child: Container(
//                 width: size.width,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             String url =
//                                 "sms:${controller.due.value.customerMobile}?body=Please pay BDT ${controller.givenAmount.value} to ${controller.shop.value.name} through the link: ${controller.url.value}";
//                             Utility.launchURL(url);
//                           },
//                           child: Container(
//                             width: size.width * 0.25,
//                             child: Center(
//                               child: Column(
//                                 children: [
//                                   Container(
//                                       height: 40,
//                                       width: 40,
//                                       child: SvgPicture.asset(
//                                           "images/svg_image/sms.svg")),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     "SMS",
//                                     style: TextStyle(
//                                         color: DEFAULT_BLACK,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//
//                         ///TODO: whatsapp package comment out
//                         // InkWell(
//                         //   onTap: () async {
//                         //     String platformVersion;
//                         //     try {
//                         //       platformVersion =
//                         //           await FlutterOpenWhatsapp.platformVersion;
//                         //       FlutterOpenWhatsapp.sendSingleMessage(
//                         //           "+88${controller.due.value.customer.mobile}",
//                         //           "Please pay BDT ${controller.givenAmount.value} to ${controller.shop.value} through the link: ${controller.url.value}");
//                         //     } catch (e) {
//                         //       Fluttertoast.showToast(msg: "App no installed");
//                         //     }
//                         //   },
//                         //   child: Container(
//                         //     width: size.width * 0.25,
//                         //     child: Center(
//                         //       child: Column(
//                         //         children: [
//                         //           Container(
//                         //               height: 40,
//                         //               width: 40,
//                         //               child: SvgPicture.asset(
//                         //                   "images/svg_image/whatsapp.svg")),
//                         //           SizedBox(
//                         //             height: 5,
//                         //           ),
//                         //           Text(
//                         //             "Whatsapp",
//                         //             style: TextStyle(
//                         //                 color: DEFAULT_BLACK,
//                         //                 fontSize: 18,
//                         //                 fontWeight: FontWeight.bold),
//                         //           ),
//                         //         ],
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         Spacer(),
//                         InkWell(
//                           onTap: () {
//                             Fluttertoast.showToast(
//                                 msg: "Unable to Open Messenger");
//                           },
//                           child: Container(
//                             width: size.width * 0.25,
//                             child: Center(
//                               child: Column(
//                                 children: [
//                                   Container(
//                                       height: 40,
//                                       width: 40,
//                                       child: SvgPicture.asset(
//                                           "images/svg_image/messenger.svg")),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     "Messenger",
//                                     style: TextStyle(
//                                         color: DEFAULT_BLACK,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             String url =
//                                 "mailto:${controller.due.value.customer.email}?body=Please pay BDT ${controller.givenAmount.value} to ${controller.shop.value.name} through the link: ${controller.url.value}";
//                             Utility.launchURL(url);
//                           },
//                           child: Container(
//                             width: size.width * 0.25,
//                             child: Column(
//                               children: [
//                                 Container(
//                                     height: 40,
//                                     width: 40,
//                                     child: SvgPicture.asset(
//                                         "images/svg_image/gmail.svg")),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "Email",
//                                   style: TextStyle(
//                                       color: DEFAULT_BLACK,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         InkWell(
//                           onTap: () {
//                             showQrCode(context, controller.url.value);
//                           },
//                           child: Container(
//                             width: size.width * 0.25,
//                             child: Column(
//                               children: [
//                                 Container(
//                                     height: 40,
//                                     width: 40,
//                                     child: SvgPicture.asset(
//                                       "images/svg_image/qr_code.svg",
//                                       color: Colors.black,
//                                     )),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "QR Code",
//                                   style: TextStyle(
//                                       color: DEFAULT_BLACK,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         InkWell(
//                           onTap: () async {
//                             await share(
//                                 link: controller.url.value,
//                                 givenAmount: controller.givenAmount.value,
//                                 shopName: controller.shop.value.name);
//                           },
//                           child: Container(
//                             width: size.width * 0.25,
//                             child: Column(
//                               children: [
//                                 Container(
//                                     height: 40,
//                                     width: 40,
//                                     child: SvgPicture.asset(
//                                         "images/svg_image/share.svg")),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "Other",
//                                   style: TextStyle(
//                                       color: DEFAULT_BLACK,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> share({String link, num givenAmount, String shopName}) async {
//     await FlutterShare.share(
//         title: "Hishabee Business Manager",
//         linkUrl: link,
//         chooserTitle: "Hishabee Business Manager",
//         text: "please pay BDT $givenAmount to $shopName through this link: ");
//   }
//
//   showQrCode(BuildContext context, String link) {
//     Size size = MediaQuery.of(context).size;
//     showDialog(
//         context: context,
//         builder: (context) => KeyboardAwareDialog(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       child: Text("Pay through the Code",
//                           style: TextStyle(
//                               color: DEFAULT_BLACK,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: QrImage(
//                         data: link,
//                         version: QrVersions.auto,
//                         size: size.height * 0.5,
//                         gapless: true,
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 10.0),
//                       child: TextButton(
//                         child: Text('close'.tr,
//                             style: TextStyle(color: Colors.red, fontSize: 14)),
//                         onPressed: () {
//                           Get.back();
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//     /*Get.dialog(
//       AlertDialog(
//         title: Text("Pay through the Code"),
//         titleTextStyle: TextStyle(color: DEFAULT_BLUE, fontSize: 16),
//         content: Container(
//             child: Center(
//             child: QrImage(
//               data: link,
//               version: QrVersions.auto,
//               size: 250.0,
//               gapless: false,
//             ),
//           ),
//             ),
//         contentTextStyle: TextStyle(fontSize: 16, color: DEFAULT_BLACK),
//         actions: <Widget>[
//           TextButton(
//             child: Text('close'.tr,
//                 style: TextStyle(color: Colors.red, fontSize: 14)),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ],
//       ),
//     );*/
//   }
// }
