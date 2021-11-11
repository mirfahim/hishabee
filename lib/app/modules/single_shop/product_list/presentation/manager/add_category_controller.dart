import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';

class AddCategoryController extends GetxController {
  final category = <Category>[].obs;
  final searchCategory = <Category>[].obs;
  final selectedCategory = Category().obs;
  final subCatName = ''.obs;

  final IProductRepository productRepository;
  AddCategoryController(this.productRepository);

  @override
  void onInit() async {
    await getAllCategory();
    super.onInit();
  }

  getAllCategory() async {
    final response = await productRepository.getProductCategories();
    category.assignAll(response);
    searchCategory.assignAll(response);
  }

  Future<void> searchCategoryName(String searchCatName) async {
    final result = category
        .where((Category category) =>
            category.name.toLowerCase().contains(searchCatName.toLowerCase()))
        .toList();
    searchCategory.assignAll(result);
  }

  saveSubProductCategory() async {
    CustomDialog.showLoadingDialog(message: "Adding category");
    final response = await productRepository.addSubCategory(
        selectedCategory.value.id, subCatName.value);
    CustomDialog.hideDialog();
    if (response.code == 200) {
      Fluttertoast.showToast(msg: "Successfully add Category");
    }
  }
}
