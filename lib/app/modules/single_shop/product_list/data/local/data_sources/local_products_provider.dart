import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/attribute_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalProductProvider {
  Future<List<Product>> getAllProduct({int shopId});

  Future<void> saveAllProduct(int shopId, List<Product> products);

  Future<void> removeAllProduct(int shopId);

  Future<List<Attribute>> getAllProductAttribute({int shopId});

  Future<void> saveAllProductAttribute(int shopId, List<Attribute> attributes);

  Future<void> removeAllProductAttribute(int shopId);

  //GLOBAL PREFETCH
  Future<List<Category>> getProductCategories();

  Future<void> saveProductCategories(List<Category> categories);

  Future<void> removeProductCategories();

  Future<void> clearDatabase();
}

class LocalProductProvider implements ILocalProductProvider {
  final String boxKey = 'productBox';
  final String productKey = 'product';
  final String attributeKey = 'attribute';
  final String categoryKey = 'category';

  @override
  Future<List<Product>> getAllProduct({int shopId}) async {
    final productBox = await Hive.openBox(boxKey);

    final products = productBox.get(productKey + shopId.toString());

    if (products != null) {
      return productResponseModelFromJson(products);
    } else {
      return Future.error("Catch error!");
    }
  }

  @override
  Future<List<Attribute>> getAllProductAttribute({int shopId}) async {
    final productBox = await Hive.openBox(boxKey);

    final attributes = productBox.get(attributeKey + shopId.toString());

    if (attributes != null) {
      return attributeResponseModelFromJson(attributes);
    } else {
      return Future.error("Catch error!");
    }
  }

  @override
  Future<List<Category>> getProductCategories() async {
    final productBox = await Hive.openBox(boxKey);

    final categories = productBox.get(categoryKey);

    if (categories != null) {
      return categoryResponseModelFromJson(categories);
    } else {
      return Future.error("Catch error!");
    }
  }

  @override
  Future<void> removeAllProduct(int shopId) async {
    final productBox = await Hive.openBox(boxKey);

    return await productBox.delete(productKey + shopId.toString());
  }

  @override
  Future<void> removeAllProductAttribute(int shopId) async {
    final productBox = await Hive.openBox(boxKey);

    return await productBox.delete(attributeKey + shopId.toString());
  }

  @override
  Future<void> removeProductCategories() async {
    final productBox = await Hive.openBox(boxKey);

    return await productBox.delete(categoryKey);
  }

  @override
  Future<void> saveAllProduct(int shopId, List<Product> products) async {
    final productBox = await Hive.openBox(boxKey);

    return await productBox.put(
        productKey + shopId.toString(), productResponseModelToJson(products));
  }

  @override
  Future<void> saveAllProductAttribute(
      int shopId, List<Attribute> attributes) async {
    final productBox = await Hive.openBox(boxKey);

    return await productBox.put(productKey + shopId.toString(),
        attributeResponseModelToJson(attributes));
  }

  @override
  Future<void> saveProductCategories(List<Category> categories) async {
    final productBox = await Hive.openBox(boxKey);

    return await productBox.put(
        categoryKey, categoryResponseModelToJson(categories));
  }

  @override
  Future<void> clearDatabase() async {
    final productBox = await Hive.openBox(boxKey);

    return productBox.clear();
  }
}
