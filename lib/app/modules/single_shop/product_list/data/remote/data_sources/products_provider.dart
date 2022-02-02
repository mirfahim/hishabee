import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:get/get.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_subcategory_resoonse_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_variance_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/attribute_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/quick_add_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/update_product_response_model.dart';

abstract class IProductProvider {
  Future<Response<QuickAddResponseModel>> getAllQuickAddProduct(
      int categoryId, int page);

  Future<Response<GenericResponseModel>> quickAdd(int shopId, String products);

  Future<Response<List<Product>>> getAllProduct(int shopId);

  Future<Response<List<Attribute>>> getAllProductAttribute(int shopId);

  Future<Response<AddProductResponseModel>> addProduct({
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
    String productType,
  });

  Future<Response<AddVariationResponseModel>> addVariation({
    int shopProductId,
    String name,
    double sellingPrice,
    String imageSrc,
    int stock,
    double costPrice,
    String barcode,
    String criteria,
  });

  Future<Response<AddProductResponseModel>> addProductWithAttribute({
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
    String productType,
  });

  Future<Response<UpdateProductResponseModel>> editProduct({
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

  Future<Response<GenericResponseModel>> deleteProduct(
    int shopId,
    int productId,
    int varianceId,
  );

  Future<Response<GenericResponseModel>> updateStock(
    int shopId,
    List<Product> products,
  );

  //GLOBAL PREFETCH
  Future<Response<List<Category>>> getProductCategories();
  Future<Response<AddSubCategoryResponse>> addSubCategory(
      int categoryId, String name);
}

class ProductProvider extends GetConnect implements IProductProvider {
  final IAuthRepository _authRepository;

  ProductProvider(this._authRepository);

  @override
  Future<Response<QuickAddResponseModel>> getAllQuickAddProduct(
      int categoryId, int page) async {
    String url =
        "$BASE_URL/product/quick_add/all?category_id=$categoryId&page=$page";

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: quickAddResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<GenericResponseModel>> quickAdd(
      int shopId, String products) async {
    // String url = '$BASE_URL/product/quick_add/add?products=[$products]&shop_id=$shopId';
    String url = '$BASE_URL/product/quick_add/add';

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final body = {
      'shop_id': shopId,
      'products': products,
    };

    return post(
      url,
      body,
      headers: headers,
      decoder: genericResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<List<Product>>> getAllProduct(int shopId) async {
    String url = "$BASE_URL/product/all?shop_id=$shopId";

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};


      return get(
        url,
        headers: headers,
        decoder: productResponseModelFromRawJson,
      );


  }

  @override
  Future<Response<List<Attribute>>> getAllProductAttribute(int shopId) async {
    String url = '$BASE_URL/product/attribute?shop_id=$shopId';
    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: attributeResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<AddProductResponseModel>> addProduct({
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
    String productType = "SIMPLE",
  }) async {
    String url = "$BASE_URL/product/add";

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final body = {
      "shop_id": shopId,
      "category": subcategoryId,
      "name": productName,
      "selling_price": price,
      "description": desc,
      "image_src": imageUrl,
      "stock": stockQuantity,
      "cost_price": cost,
      "vat_applicable": vatApplicable,
      "vat_percent": vatAmount,
      "barcode": barcode,
      "attribute": attribute,
      "product_type": productType,
    };

    return post(
      url,
      body,
      headers: headers,
      decoder: addProductResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<AddProductResponseModel>> addProductWithAttribute(
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
      double vatAmount,
      String productType = "SIMPLE"}) async {
    String url = "$BASE_URL/product/add";

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final body = {
      "shop_id": shopId,
      "category": subcategoryId,
      "name": productName,
      "selling_price": price,
      "description": desc,
      "image_src": imageUrl,
      "stock": stockQuantity,
      "cost_price": cost,
      "vat_applicable": vatApplicable,
      "vat_percent": vatAmount,
      "barcode": barcode,
      "attribute": attribute,
      "product_type": productType,
    };

    return post(
      url,
      body,
      headers: headers,
      decoder: addProductResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<List<Category>>> getProductCategories() async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    String url = "$BASE_URL/product/categories?user_id=${creds.user.id}";

    return get(
      url,
      headers: headers,
      decoder: categoryResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<AddVariationResponseModel>> addVariation({
    int shopProductId,
    String name,
    double sellingPrice,
    String imageSrc,
    int stock,
    double costPrice,
    String barcode,
    String criteria,
  }) async {
    String url = '$BASE_URL/variation/add';

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final body = {
      "shop_product_id": shopProductId,
      "name": name,
      "selling_price": sellingPrice,
      "image_src": imageSrc,
      "stock": stock,
      "cost_price": costPrice,
      "barcode": barcode,
      "criteria": criteria,
    };

    return post(
      url,
      body,
      headers: headers,
      decoder: addVariationResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<UpdateProductResponseModel>> editProduct({
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
  }) async {
    String url = '$BASE_URL/product/edit';

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final body = {
      "barcode": barcode,
      "id": id,
      "variation_id": variationId,
      "category": category,
      "name": name,
      "variance_name": varianceName,
      "selling_price": sellingPrice,
      "stock": stock,
      "cost": cost,
      "description": description,
      "vat_applicable": vatApplicable,
      "vat_percent": vatPercentage,
      "image_src": imageSource,
    };

    return put(url, body,
        headers: headers, decoder: updateProductResponseModelFromJson);
  }

  @override
  Future<Response<GenericResponseModel>> deleteProduct(
    int shopId,
    int productId,
    int varianceId,
  ) async {
    String url = '$BASE_URL/product/delete?id=$productId';

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return delete(
      url,
      headers: headers,
      decoder: genericResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<GenericResponseModel>> updateStock(
      int shopId, List<Product> products) async {
    /* String url =
        '$BASE_URL/product/stock?shop_id=$shopId&products=${productsToJson(products)}';*/
    String url = '$BASE_URL/product/stock';

    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final body = {
      "shop_id": shopId,
      'products': productResponseModelToJson(products)
    };

    return post(
      url,
      body,
      headers: headers,
      decoder: genericResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<AddSubCategoryResponse>> addSubCategory(
      int categoryId, String name) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    String url = "$BASE_URL/product/categories/add?user_id=${creds.user.id}";

    final body = {
      "category_id": categoryId,
      "name": name,
    };

    return post(
      url,
      body,
      headers: headers,
      decoder: addSubCategoryResponseFromRawJson,
    );
  }
}
