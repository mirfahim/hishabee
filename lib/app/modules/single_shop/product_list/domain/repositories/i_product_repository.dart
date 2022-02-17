import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_subcategory_resoonse_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_variance_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/attribute_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/quick_add_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/update_product_response_model.dart';

abstract class IProductRepository {
  Future<QuickAddResponseModel> getAllQuickAddProduct(int categoryId, int page);

  Future<GenericResponseModel> quickAdd(int shopId, String products);

  Future<List<Product>> getAllProduct(int shopId);

  Future<List<Attribute>> getAllProductAttribute(int shopId);

  Future<AddProductResponseModel> addProduct({
    int shopId,
    int subcategoryId,
    String productName,
    var subUnit,
    double price,
    String desc,
    String imageUrl,
    List gallary,
    int stockQuantity,
    double cost,
    bool vatApplicable,
    String barcode,
    String attribute,
    double vatAmount,
    double wholeSalePrice,
    String uniqueID,
  });

  Future<AddVariationResponseModel> addVariation({
    int shopProductId,
    String name,
    double sellingPrice,
    String imageSrc,
    int stock,
    double costPrice,
    String barcode,
    String criteria,
  });

  Future<AddProductResponseModel> addProductWithAttribute({
    int shopId,
    int subcategoryId,
    String productName,
    double price,
    String desc,
    String imageUrl,
    int stockQuantity,
    double cost,
    bool vatApplicable,
    String barcode,
    String attribute,
    double vatAmount,
  });

  Future<UpdateProductResponseModel> editProduct({
    int id,
    String barcode,
    int variationId,
    int category,
    String name,
    String varianceName,
    double sellingPrice,
    int stock,
    double cost,
    String description,
    bool vatApplicable,
    double vatPercentage,
    String imageSource,
  });

  Future<GenericResponseModel> deleteProduct(
    int shopId,
    int productId,
    int varianceId,
  );

  Future<GenericResponseModel> updateStock(
    int shopId,
    List<Product> products,
  );

  //GLOBAL PREFETCH
  Future<List<Category>> getProductCategories();
  Future<AddSubCategoryResponse> addSubCategory(int categoryId, String name);

  Future<void> clearDatabase();
}
