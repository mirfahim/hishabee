import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_subcategory_resoonse_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_variance_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/attribute_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/quick_add_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/update_product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';

class ProductRepository implements IProductRepository {
  final IProductProvider productProvider;
  final ILocalProductProvider localProductProvider;
  final INetworkInfo networkInfo;

  ProductRepository(
      this.productProvider, this.localProductProvider, this.networkInfo);

  @override
  Future<AddProductResponseModel> addProduct(
      {int shopId,
      int version,
      int subcategoryId,
      String productName,
      double price,
      List gallary,
      var subUnit,
      String desc,
      String imageUrl,
      int stockQuantity,
      double cost,
      bool vatApplicable,
      String barcode,
      double wholeSalePrice,
      String uniqueID,
      String attribute,
      double vatAmount}) async {
    final response = await productProvider.addProduct(
        shopId: shopId,
        subcategoryId: subcategoryId,
        productName: productName,
        price: price,
        wholeSalePrice: wholeSalePrice,
        desc: desc,
        imageUrl: imageUrl,
        stockQuantity: stockQuantity,
        cost: cost,
        uniqueID: uniqueID,
        vatApplicable: vatApplicable,
        barcode: barcode,
        attribute: attribute,
        vatAmount: vatAmount,
        version: version,
        subUnit: subUnit);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<AddProductResponseModel> addProductWithAttribute(
      {int shopId,
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
      double vatAmount}) async {
    final response = await productProvider.addProductWithAttribute(
        shopId: shopId,
        subcategoryId: subcategoryId,
        productName: productName,
        price: price,
        desc: desc,
        imageUrl: imageUrl,
        stockQuantity: stockQuantity,
        cost: cost,
        vatApplicable: vatApplicable,
        barcode: barcode,
        attribute: attribute,
        vatAmount: vatAmount);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<AddVariationResponseModel> addVariation(
      {int shopProductId,
      String name,
      double sellingPrice,
      String imageSrc,
      int stock,
      double costPrice,
      String barcode,
      String criteria}) async {
    final response = await productProvider.addVariation(
      shopProductId: shopProductId,
      name: name,
      sellingPrice: sellingPrice,
      imageSrc: imageSrc,
      stock: stock,
      costPrice: costPrice,
      barcode: barcode,
      criteria: criteria,
    );

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> deleteProduct(
      int shopId, int productId, int varianceId) async {
    final response = await productProvider.deleteProduct(
      shopId,
      productId,
      varianceId,
    );

    return ResponseDecoder.decode(response);
  }

  @override
  Future<UpdateProductResponseModel> editProduct(
      {int id,
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
      String imageSource}) async {
    final response = await productProvider.editProduct(
        id: id,
        barcode: barcode,
        variationId: variationId,
        category: category,
        name: name,
        varianceName: varianceName,
        sellingPrice: sellingPrice,
        stock: stock,
        cost: cost,
        description: description,
        vatApplicable: vatApplicable,
        vatPercentage: vatPercentage,
        imageSource: imageSource);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<Product>> getAllProduct(int shopId) async {
    if (await networkInfo.isConnected()) {
      final response = await productProvider.getAllProduct(shopId);
      await localProductProvider.saveAllProduct(shopId, response.body);

      return ResponseDecoder.decode(response);
    } else {
      print("data is coming from local database");
      return await localProductProvider.getAllProduct(shopId: shopId);
    }
  }

  @override
  Future<List<Product>> getAllProduct1(int shopId) async {
    if (await networkInfo.isConnected()) {
      final response = await productProvider.getAllProduct(shopId);

      await localProductProvider.saveAllProduct(shopId, response.body);

      return ResponseDecoder.decode(response);
    } else {
      print("data is coming from local database");
      return await localProductProvider.getAllProduct(shopId: shopId);
    }
  }

  @override
  Future<List<Attribute>> getAllProductAttribute(int shopId) async {
    try {
      final result =
          await localProductProvider.getAllProductAttribute(shopId: shopId);
      return result;
    } catch (e) {
      if (await networkInfo.isConnected()) {
        final response = await productProvider.getAllProductAttribute(shopId);

        localProductProvider.saveAllProductAttribute(shopId, response.body);
        return ResponseDecoder.decode(response);
      } else {
        return Future.error('Network Error!');
      }
    }
  }

  @override
  Future<QuickAddResponseModel> getAllQuickAddProduct(
      int categoryId, int page) async {
    final response = await productProvider.getAllQuickAddProduct(
      categoryId,
      page,
    );

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<Category>> getProductCategories() async {
    try {
      final result = await localProductProvider.getProductCategories();
      return result;
    } catch (e) {
      if (await networkInfo.isConnected()) {
        final response = await productProvider.getProductCategories();
        localProductProvider.saveProductCategories(response.body);
        return ResponseDecoder.decode(response);
      } else {
        return Future.error('Network Error!');
      }
    }
  }

  @override
  Future<GenericResponseModel> quickAdd(int shopId, String products) async {
    final response = await productProvider.quickAdd(shopId, products);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> updateStock(
      int shopId, List<Product> products) async {
    final response = await productProvider.updateStock(
      shopId,
      products,
    );

    return ResponseDecoder.decode(response);
  }

  @override
  Future<void> clearDatabase() async {
    return await localProductProvider.clearDatabase();
  }

  @override
  Future<AddSubCategoryResponse> addSubCategory(
      int categoryId, String name) async {
    final response = await productProvider.addSubCategory(categoryId, name);

    return ResponseDecoder.decode(response);
  }
}
