import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/get_all_training_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_training_video_repository.dart';

class TrainingVideoController extends GetxController
    with StateMixin<List<TrainingVideoResponseModel>> {
  final ITrainingVideoRepository trainingVideoRepository;

  TrainingVideoController(this.trainingVideoRepository);

  final shopId = 0.obs;

  onInit() async {
    shopId.value = DataHolder.shopId;
    append(() => getAllTrainingVideo);

    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllTrainingVideo();
  }

  Future<List<TrainingVideoResponseModel>> getAllTrainingVideo() async {
    return trainingVideoRepository.getAllTrainingVideo(shopId.value);
  }
}
