import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/get_all_training_video.dart';

abstract class ITrainingVideoProvider {
  Future<Response<List<TrainingVideoResponseModel>>> getAllTrainingVideo(
      int shopId);
}

//{{domain}}/training/video?shop_id={{shop_id}}

class TrainingVideoProvider extends GetConnect
    implements ITrainingVideoProvider {
  final IAuthRepository authRepository;

  TrainingVideoProvider(this.authRepository);

  @override
  Future<Response<List<TrainingVideoResponseModel>>> getAllTrainingVideo(
      int shopId) async {
    String url = '$BASE_URL/training/video?shop_id=$shopId';
    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: trainingVideoResponseModelFromRawJson,
    );
  }
}
