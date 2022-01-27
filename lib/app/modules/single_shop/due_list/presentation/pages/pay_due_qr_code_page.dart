// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/set_qr_code_controller.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/pay_due_qr_code_controller.dart';
//
// class PayDueQRCodePage extends GetResponsiveView<PayDueQrCodeController> {
//   @override
//   Widget builder() {
//     Size size = MediaQuery.of(screen.context).size;
//     return Scaffold(
//       backgroundColor: DEFAULT_BODY_BG_COLOR,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               height: size.height * 0.2,
//               width: size.width,
//               child: Image.asset(
//                 "images/topBg.png",
//                 fit: BoxFit.fill,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_back,
//                       size: 25,
//                       color: DEFAULT_BLACK,
//                     ),
//                     onPressed: () {
//                       Get.back();
//                     },
//                   ),
//                   Text(
//                     'set_qr_code'.tr,
//                     style: TextStyle(
//                       fontFamily: 'Rubik',
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: DEFAULT_BLACK,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 70.0,
//                 left: 15,
//                 right: 15,
//               ),
//               child: Obx(
//                 () => Text(
//                   controller.shop.value.name,
//                   style: TextStyle(
//                     fontFamily: 'Rubik',
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: DEFAULT_BLACK,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 100.0, left: 5, right: 5),
//               child: DefaultTabController(
//                 length: 4,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(4),
//                             border: Border.all(color: Colors.grey, width: 1)),
//                         child: TabBar(
//                           indicatorColor: DEFAULT_BLACK,
//                           tabs: [
//                             Tab(
//                               icon: Text(
//                                 "bkash".tr,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Tab(
//                               icon: Text(
//                                 "nagad".tr,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Tab(
//                               icon: Text(
//                                 "rocket".tr,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Tab(
//                               icon: Text(
//                                 "other".tr,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: TabBarView(
//                         children: [
//                           getQRCodeScreenBody(0, size),
//                           getQRCodeScreenBody(1, size),
//                           getQRCodeScreenBody(2, size),
//                           getQRCodeScreenBody(3, size),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(left: 15.0, right: 15, bottom: 20),
//                 child: Container(
//                   height: 45,
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     color: DEFAULT_BLACK,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: TextButton(
//                     onPressed: () async {
//                       controller.payDue();
//                     },
//                     child: Text(
//                       "done".tr,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   getQRCodeScreenBody(int index, Size size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//               height: size.height * 0.4,
//               width: size.width * 0.7,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.4),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(
//                       0,
//                       3,
//                     ), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: controller.obx(
//                   (state) => state.isEmpty
//                       ? Text(
//                           "QR Code\nNot Found",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         )
//                       : state.length <= index
//                           ? Text(
//                               "QR Code\nNot Found",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             )
//                           : CachedNetworkImage(
//                               imageUrl: state[index].imageSrc,
//                               fit: BoxFit.fill,
//                               placeholder: (context, url) =>
//                                   CircularProgressIndicator(),
//                               errorWidget: (context, url, error) => Icon(
//                                 Icons.error,
//                                 color: Colors.red,
//                               ),
//                             ), /*Image.network(state[index].imageSrc),*/
//                 ),
//               )),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 50.0, top: 0),
//             child: TextButton(
//               onPressed: () {
//                 showPictureOptionDialogue(index);
//               },
//               child: Text(
//                 "change_qr_code".tr,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: DEFAULT_BLACK,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   showPictureOptionDialogue(int option) {
//     showDialog(
//       context: screen.context,
//       builder: (_) => AlertDialog(
//         title: Text("Picture option"),
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 controller.getImageFromCamera(option);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image(
//                         height: 70,
//                         image: AssetImage('images/icons/camera.png'),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         "Camera",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 controller.getImageFromGallery(option);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image(
//                         height: 70,
//                         image: AssetImage('images/icons/gallery.png'),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         "Gallery",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text(
//               'Close',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onPressed: () {
//               Get.back();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
