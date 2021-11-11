import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/get_all_training_video.dart';

abstract class ITrainingVideoRepository {
  Future<List<TrainingVideoResponseModel>> getAllTrainingVideo(int shopId);
}
