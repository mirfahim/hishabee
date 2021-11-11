import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_qr_code_response_model.dart';

abstract class IQrRepository {
  Future<AddQrCodeResponseModel> addQrCode(
      {int shopId, String imageSrc, String type});

  Future<List<Qrcode>> getAllQrCode({int shopId});
}
