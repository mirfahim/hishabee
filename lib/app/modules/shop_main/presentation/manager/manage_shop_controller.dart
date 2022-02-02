import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
// import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/user_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';

class ManageShopController extends GetxController {
  final user = Rxn<User>();
  final shops = <Shop>[].obs;

  final IShopRepository _shopRepository;

  ManageShopController(this._shopRepository);

  @override
  void onInit() async {
    getArguments();
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  getArguments() {
    user.value = Get.arguments["user"];
  }

  initData() async {
    await getAllShop();
  }

  Future<void> getAllShop() async {
    final response = await _shopRepository.getAllShop();
    shops.assignAll(response);
  }
}
