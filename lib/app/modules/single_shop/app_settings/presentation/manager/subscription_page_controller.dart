import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_item_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_subscription_repository.dart';

class SubscriptionPageController extends GetxController {
  final ISubscriptionRepository subscriptionRepository;

  SubscriptionPageController(this.subscriptionRepository);

  final subscriptionItemList = <SubscriptionItem>[].obs;

  @override
  void onInit() async {
    await getAllSubscriptionItem();
    super.onInit();
  }

  getAllSubscriptionItem() async {
    final result =
        await subscriptionRepository.getAllSubscriptionItem(DataHolder.shopId);
    subscriptionItemList.assignAll(result);
  }
}
