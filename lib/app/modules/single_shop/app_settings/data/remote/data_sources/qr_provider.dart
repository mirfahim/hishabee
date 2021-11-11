import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_qr_code_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/get_all_qr_code_response_model.dart';

abstract class IQrProvider {
  Future<Response<AddQrCodeResponseModel>> addQrCode(
      {int shopId, String imageSrc, String type});

  Future<Response<List<Qrcode>>> getAllQrCode({int shopId});
}

class QrProvider extends GetConnect implements IQrProvider {
  final IAuthRepository authRepository;

  QrProvider(this.authRepository);

  @override
  Future<Response<AddQrCodeResponseModel>> addQrCode(
      {int shopId, String imageSrc, String type}) async {
    String url =
        '$BASE_URL/qr/add?type=$type&shop_id=$shopId&image_src=$imageSrc';

    final creds = await authRepository.getCredentials();

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: addQrCodeResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<List<Qrcode>>> getAllQrCode({int shopId}) async {
    String url = '$BASE_URL/qr/all?shop_id=$shopId';

    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: getAllQrCodeResponseModelFromJson,
    );
  }
}
