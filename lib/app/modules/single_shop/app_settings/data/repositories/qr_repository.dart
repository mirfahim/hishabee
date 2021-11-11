import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/qr_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_qr_code_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_qr_repository.dart';

class QrRepository implements IQrRepository {
  final IQrProvider qrProvider;

  QrRepository(this.qrProvider);

  @override
  Future<AddQrCodeResponseModel> addQrCode(
      {int shopId, String imageSrc, String type}) async {
    final response = await qrProvider.addQrCode(
        shopId: shopId, imageSrc: imageSrc, type: type);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<Qrcode>> getAllQrCode({int shopId}) async {
    final response = await qrProvider.getAllQrCode(shopId: shopId);
    return ResponseDecoder.decode(response);
  }
}
