import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';

class CategoriesController extends GetxController {
  final IProductRepository productRepository;
  var productCategoryList = [].obs;

  CategoriesController(this.productRepository);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllCategory();
  }

  Future<List<Category>> getAllCategory() async {
    var list = await productRepository.getProductCategories();
    if (list != null) {
      productCategoryList.assignAll(list);
    }
    return list;
  }
}
