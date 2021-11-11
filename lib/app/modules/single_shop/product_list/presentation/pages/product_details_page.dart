import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/_bindings/product_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_details_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/duplicate_products_page.dart';

import 'edit_products_page.dart';

class ProductDetails extends GetView<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width,
                child: Image.asset(
                  "images/topBg.png",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 10, right: 10, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: DEFAULT_BLUE_DARK,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'product_details'.tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLUE_DARK,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: DEFAULT_BLUE),
                            child: IconButton(
                              onPressed: () {
                                Get.to(EditProductPage(),
                                    arguments: {
                                      "shop": controller.shop.value,
                                      "product": controller.product.value,
                                      "catList": controller.productCategoryList,
                                    },
                                    binding: ProductListBinding());
                              },
                              icon: Center(
                                  child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Obx(
                      () => Container(
                          height: size.height * 0.13,
                          width: size.width * 0.24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              boxShadow: [BoxShadow()]),
                          child: controller.product.value.imageUrl == null ||
                                  controller.product.value.imageUrl == "null"
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Image.asset(
                                      'images/hishabeeLogo.png',
                                      height: size.height * 0.13,
                                      width: size.width * 0.24,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Obx(
                                    () => ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            controller.product.value.imageUrl,
                                        height: size.height * 0.13,
                                        width: size.width * 0.24,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Text(
                        controller.product.value.name,
                        style: TextStyle(
                          fontFamily: 'Rubik-VariableFont_wght',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLUE_DARK,
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '(${controller.productSubCategory.value})',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                      child: Row(
                        children: [
                          Text(
                            "current_stock".tr,
                            style: TextStyle(
                              fontFamily: 'Rubik-VariableFont_wght',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: DEFAULT_BLUE_DARK,
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 8),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              '${controller.product.value.stock}',
                              style: TextStyle(
                                fontFamily: 'Rubik-VariableFont_wght',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.25,
                                child: Text(
                                  "price".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLUE_DARK,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width * 0.25,
                                child: Obx(
                                  () => Text(
                                    '${controller.product.value.sellingPrice}',
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.25,
                                child: Text(
                                  "cost".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLUE_DARK,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width * 0.25,
                                child: Obx(
                                  () => Text(
                                    '${controller.product.value.costPrice}',
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.25,
                                child: Text(
                                  "profit".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLUE_DARK,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width * 0.25,
                                child: Obx(
                                  () => Text(
                                    '${controller.product.value.sellingPrice - controller.product.value.costPrice}',
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                      child: Row(
                        children: [
                          Text(
                            "description".tr,
                            style: TextStyle(
                              fontFamily: 'Rubik-VariableFont_wght',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: DEFAULT_BLUE_DARK,
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12.0, top: 8, right: 12),
                      child: Container(
                        width: size.width,
                        child: Obx(
                          () => Text(
                            controller.product.value.description != null
                                ? controller.product.value.description
                                : 'not_given'.tr,
                            style: TextStyle(
                              fontFamily: 'Rubik-VariableFont_wght',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => DuplicateProductPage(),
                                  arguments: {
                                    "product": controller.product.value,
                                    "shop": controller.shop.value,
                                    "catList": controller.productCategoryList,
                                  },
                                  binding: ProductListBinding());
                            },
                            child: Container(
                                height: 45,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: DEFAULT_BLACK),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.file_copy_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'duplicate'.tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik-VariableFont_wght',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              showUpdateStockDialog(
                                  context,
                                  controller.product.value,
                                  controller.shop.value,
                                  controller.productCategoryList);
                            },
                            child: Container(
                                height: 45,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: DEFAULT_BLACK),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'update_stock_n'.tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik-VariableFont_wght',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: InkWell(
                        onTap: () {
                          showUpdateStockDialog(
                              context,
                              controller.product.value,
                              controller.shop.value,
                              controller.productCategoryList);
                        },
                        child: Container(
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: DEFAULT_BLACK),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.share_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "share_product_link".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showUpdateStockDialog(BuildContext context, Product product, Shop shop,
      List<Category> productCategoryList) {
    Size size = MediaQuery.of(context).size;
    String catagory;
    productCategoryList
        .forEach((Category c) => c.subCategory.forEach((SubCategory sc) {
              if (sc.id == product.subCategory) {
                catagory = sc.name;
              }
            }));
    showDialog(
        context: context,
        builder: (context) => KeyboardAwareDialog(
              child: Container(
                height: size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.15,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          product.imageUrl == null || product.imageUrl == "null"
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Image.asset(
                                      'images/hishabeeLogo.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: CachedNetworkImage(
                                    imageUrl: product.imageUrl,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // fontSize: 28,
                          color: DEFAULT_BLACK,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${catagory}',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            // fontSize: 28,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                          child: VerticalDivider(
                            thickness: 1,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'TK ${product.sellingPrice}',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            // fontSize: 28,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.decrementStock();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      " - ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                              width: size.width / 3,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)),
                              child: Obx(
                                () => TextFormField(
                                  textAlign: TextAlign.center,
                                  controller:
                                      controller.textEditingController.value,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 5, right: 5, bottom: 10),
                                  ),
                                ),
                              )),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              controller.incrementStock();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.teal,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        " + ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          onPressed: () async {
                            await controller.updateStock();
                          },
                          child: Text(
                            "update".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          color: DEFAULT_BLUE,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
