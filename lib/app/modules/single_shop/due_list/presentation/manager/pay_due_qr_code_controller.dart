// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
// import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
// import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_qr_code_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_qr_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_payment_controller.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
// import 'package:image_picker/image_picker.dart';
//
// class PayDueQrCodeController extends GetxController
//     with StateMixin<List<Qrcode>> {
//   final IFileRepository fileRepository;
//   final IQrRepository qrRepository;
//   final IDueRepository dueRepository;
//   final shop = Rxn<Shop>();
//   final picker = ImagePicker();
//   final file = Rxn<File>();
//   final due = Rxn<Due>();
//   final givenDue = 0.obs;
//
//   PayDueQrCodeController(
//       this.fileRepository, this.qrRepository, this.dueRepository);
//
//   @override
//   void onInit() {
//     getArguments();
//     append(() => getAllQrCode);
//     super.onInit();
//   }
//
//   getArguments() {
//     shop.value = Get.arguments["shop"];
//     due.value = Get.arguments["due"];
//     givenDue.value = Get.arguments["givenDue"];
//   }
//
//   Future<List<Qrcode>> getAllQrCode() {
//     return qrRepository.getAllQrCode(shopId: shop.value.id);
//   }
//
//   Future<void> uploadQrCode(int shopId, File file, String type) async {
//     final response = await fileRepository.uploadFile(file: file, type: type);
//     if (response != null) {
//       await qrRepository.addQrCode(
//           shopId: shopId, imageSrc: response, type: type);
//     }
//   }
//
//   Future getImageFromCamera(int option) async {
//     try {
//       final pickedFile = await picker.getImage(source: ImageSource.camera);
//       if (pickedFile != null) {
//         final qrFile = File(pickedFile.path);
//         uploadQrCode(
//           shop.value.id,
//           qrFile,
//           "paymentQR" + option.toString(),
//         );
//       } else {
//         print('No image selected.');
//       }
//       Get.back();
//     } catch (e) {}
//   }
//
//   Future getImageFromGallery(int option) async {
//     try {
//       final pickedFile = await picker.getImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final qrFile = File(pickedFile.path);
//         uploadQrCode(
//           shop.value.id,
//           qrFile,
//           "paymentQR" + option.toString(),
//         );
//         /*imageFileList.value[option] = File(pickedFile.path);
//         Utility.saveImageToPreferences(
//           "paymentQR" + option.toString(),
//           Utility.base64String(imageFileList.value[option].readAsBytesSync()),
//         );
//         key.value = "paymentQR" + option.toString();*/
//       } else {
//         print('No image selected.');
//       }
//       Get.back();
//     } catch (e) {}
//   }
//
//   payDue() {
//     Get.dialog(
//       CupertinoAlertDialog(
//         content: Text("please_confirm".tr),
//         actions: <Widget>[
//           TextButton(
//             child: Text(
//               'close'.tr,
//               style: TextStyle(color: Colors.red, fontSize: 14),
//             ),
//             onPressed: () {
//               navigator.pop();
//             },
//           ),
//           TextButton(
//             child: Text(
//               'confirm'.tr,
//               style: TextStyle(color: Colors.red, fontSize: 14),
//             ),
//             onPressed: () async {
//               CustomDialog.showLoadingDialog(message: "Paying Due...");
//               //need to write code here,
//               final result = await dueRepository.updateDue(
//                   shopId: shop.value.id,
//                   customerId: due.value.customerId,
//                   dueLeft: givenDue.value,
//                   customerMobile: due.value.customerMobile);
//               final dlc = Get.find<DueListController>();
//               await dlc.getAllDue();
//               if (Get.isDialogOpen) {
//                 Get.back();
//               }
//               if (result.code == 200) {
//                 Get.back();
//                 Get.back();
//                 Get.back();
//                 Fluttertoast.showToast(msg: "Due Update Successful");
//                 Get.back();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
