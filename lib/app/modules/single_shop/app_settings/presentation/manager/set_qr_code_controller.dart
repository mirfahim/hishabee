import 'dart:io';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_qr_code_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_qr_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
import 'package:image_picker/image_picker.dart';

class SetQrCodeController extends GetxController with StateMixin<List<Qrcode>> {
  final IFileRepository fileRepository;
  final IQrRepository qrRepository;
  // final dpc = Get.find<DuePaymentController>();
  final sc = Get.find<ConfirmPaymentController>();
  final shop = Rxn<Shop>();
  final picker = ImagePicker();
  final file = Rxn<File>();

  SetQrCodeController(this.fileRepository, this.qrRepository);

  @override
  void onInit() {
    getArguments();
    append(() => getAllQrCode);
    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  Future<List<Qrcode>> getAllQrCode() {
    return qrRepository.getAllQrCode(shopId: shop.value.id);
  }

  Future<void> uploadQrCode(int shopId, File file, String type) async {
    CustomDialog.showLoadingDialog(message: "Uploading QR Code");
    final response = await fileRepository.uploadFile(file: file, type: type);
    if (response != null) {
      String image = response
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
      final result = await qrRepository.addQrCode(
          shopId: shopId, imageSrc: image, type: type);
      CustomDialog.hideDialog();
      if (result.code == 200) {
        CustomDialog.showStringDialog("${result.message}");
      } else {
        CustomDialog.showStringDialog("${result.message}");
      }
      getAllQrCode();
    }
  }

  getImageFromCamera(int option) async {
    var qrType;
    switch (option) {
      case 0:
        qrType = 'bkash';
        break;
      case 1:
        qrType = 'nagad';
        break;
      case 2:
        qrType = 'rocket';
        break;
      case 3:
        qrType = 'others';
        break;
    }
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final qrFile = File(pickedFile.path);
        uploadQrCode(
          shop.value.id,
          qrFile,
          qrType,
        );
      } else {
        print('No image selected.');
      }
      Get.back();
    } catch (e) {}
  }

  getImageFromGallery(int option) async {
    var qrType;
    switch (option) {
      case 0:
        qrType = 'bkash';
        break;
      case 1:
        qrType = 'nagad';
        break;
      case 2:
        qrType = 'rocket';
        break;
      case 3:
        qrType = 'others';
        break;
    }
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final qrFile = File(pickedFile.path);
        uploadQrCode(
          shop.value.id,
          qrFile,
          qrType,
        );
      } else {
        print('No image selected.');
      }
      Get.back();
    } catch (e) {}
  }
}
