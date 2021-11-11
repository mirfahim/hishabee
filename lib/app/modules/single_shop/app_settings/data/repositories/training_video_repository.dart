import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/training_video_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/get_all_training_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_training_video_repository.dart';

class TrainingVideoRepository implements ITrainingVideoRepository {
  final ITrainingVideoProvider trainingVideoProvider;

  TrainingVideoRepository(this.trainingVideoProvider);
  @override
  Future<List<TrainingVideoResponseModel>> getAllTrainingVideo(
      int shopId) async {
    final response = await trainingVideoProvider.getAllTrainingVideo(shopId);

    return ResponseDecoder.decode(response);
  }
}
