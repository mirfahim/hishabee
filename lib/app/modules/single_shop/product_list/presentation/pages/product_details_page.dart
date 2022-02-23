import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/_bindings/product_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/add_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/edit_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_controller_with_verion.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_details_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/duplicate_products_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/share_product.dart';

import 'backUp/previous_edit_product.dart';
import 'edit_products_page.dart';

class ProductDetails extends GetView<ProductDetailsController> {
  IProductProvider iProductProvider;
  ProductControllerWithVersion productControllerWithVersion;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        backgroundColor: DEFAULT_YELLOW_BG,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Color(0xFF232323),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          'product_details'.tr,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF232323),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 10, right: 10, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'details_of_product'.tr,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xFF185ADB),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => EditProductShowcase(
                            shop: controller.shop.value,
                            productCategoryList: controller.productCategoryList,
                          ),
                          binding: ProductListBinding(),
                        );
                      },
                      child: SvgPicture.asset('images/svg_image/edit.svg'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        print("working");
                        sendProductInfo();
                      },
                      child: SvgPicture.asset('images/svg_image/delete.svg'),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Container(
                          height: size.height * 0.11,
                          width: size.width * 0.25,
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
                                      height: size.height * 0.09,
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
                                        height: size.height * 0.10,
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
                      width: 80,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.product.value.name,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF232323),
                            ),
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              '৳ ${controller.product.value.sellingPrice}',
                              // '(${controller.productSubCategory.value})',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF232323),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1.5,
                  color: Color(0xFFC4C4C4).withOpacity(.35),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          // height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Obx(
                                  () => Text(
                                    '${controller.product.value.stock}',
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF185ADB),
                                    ),
                                  ),
                                ),
                                Text(
                                  "current_stock".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Color(0xFF232323),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Container(
                          // height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Obx(
                                  () => Text(
                                    '৳ ${controller.product.value.sellingPrice}',
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF185ADB),
                                    ),
                                  ),
                                ),
                                Text(
                                  "price".tr,
                                  style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                      color: Color(0xFF232323)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          // height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Obx(
                                  () => Text(
                                    '৳ ${controller.product.value.costPrice}',
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF185ADB),
                                    ),
                                  ),
                                ),
                                Text(
                                  "cost".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Color(0xFF232323),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          // height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Obx(
                                  () => Text(
                                    '${controller.productSubCategory.value}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                      color: Color(0xFF185ADB),
                                    ),
                                  ),
                                ),
                                Text(
                                  "sub_category".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Color(0xFF232323),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          // height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Color(0xFF185ADB),
                                  ),
                                ),
                                Text(
                                  "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Color(0xFF232323),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'other_details_of_product'.tr,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF185ADB),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          // height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Obx(
                                  () => Text(
                                    '${controller.product.value.vatPercent}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                      color: Color(0xFF185ADB),
                                    ),
                                  ),
                                ),
                                Text(
                                  "vat".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Color(0xFF232323),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8.0),
                        child: Container(
                          // height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Obx(
                                  () => Text(
                                    '${controller.product.value.vatPercent}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Rubik-VariableFont_wght',
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                      color: Color(0xFF185ADB),
                                    ),
                                  ),
                                ),
                                Text(
                                  "vat".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Rubik-VariableFont_wght',
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Color(0xFF232323),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Row(
                //   children: [
                //     Text(
                //       "description".tr,
                //       style: TextStyle(
                //         fontFamily: 'Rubik-VariableFont_wght',
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //         color: DEFAULT_BLUE_DARK,
                //       ),
                //     ),
                //     Expanded(child: Container())
                //   ],
                // ),
                Container(
                  // height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(.35)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                    child: Obx(
                      () => Text(
                        controller.product.value.description != null
                            ? controller.product.value.description
                            : 'not_given'.tr,
                        style: TextStyle(
                          fontFamily: 'Rubik-VariableFont_wght',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF232323),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    showUpdateStockDialog(context, controller.product.value,
                        controller.shop.value, controller.productCategoryList);
                  },
                  child: Container(
                      height: 45,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: DEFAULT_BLUE),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'update_stock_n'.tr,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
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
                            height: 50,
                            // width: size.width * 0.4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF232323)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.file_copy_outlined,
                                  color: DEFAULT_BLUE,
                                ),
                                Text(
                                  'duplicate'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(ShareProduct(
                            slag: controller.product.value.slug,
                            shopName: controller.shop.value.name,
                          ));
                        },
                        child: Container(
                            height: 50,
                            // width: size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF232323)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.share_sharp,
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "share_product_link_button".tr,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                                Spacer(),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
    showModalBottomSheet<void>(
        context: context,
        builder: (context) => Container(
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: size.height * 0.15,
                  //   width: size.width,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child:
                  //       product.imageUrl == null || product.imageUrl == "null"
                  //           ? Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Center(
                  //                 child: Image.asset(
                  //                   'images/hishabeeLogo.png',
                  //                   fit: BoxFit.fill,
                  //                 ),
                  //               ),
                  //             )
                  //           : Center(
                  //               child: CachedNetworkImage(
                  //                 imageUrl: product.imageUrl,
                  //                 placeholder: (context, url) =>
                  //                     CircularProgressIndicator(),
                  //                 errorWidget: (context, url, error) => Icon(
                  //                   Icons.error,
                  //                   color: Colors.red,
                  //                 ),
                  //                 fit: BoxFit.fill,
                  //               ),
                  //             ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 28,
                                  color: Color(0xFF232323),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                catagory == null ? "No Category" : '$catagory',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  // fontSize: 28,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "current_stock".tr,
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                            ),
                            Text(
                              ': ${controller.product.value.stock}',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       '${catagory}',
                  //       style: TextStyle(
                  //         fontFamily: 'Rubik',
                  //         // fontSize: 28,
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 15,
                  //       child: VerticalDivider(
                  //         thickness: 1,
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  //     // Text(
                  //     //   'TK ${product.sellingPrice}',
                  //     //   style: TextStyle(
                  //     //     fontFamily: 'Rubik',
                  //     //     // fontSize: 28,
                  //     //     color: Colors.red,
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.decrementStock();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  " - ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                  color: DEFAULT_BLUE,
                                ),
                                child: Center(
                                  child: Text(
                                    " + ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
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
            ));
  }

  final AddProductController _controller = Get.find();
  final EditProductController _productController = Get.find();
  sendProductInfo() async {
    // if (selectedProductCategory == null || selectedSubCat == null) {
    //   _showMaterialDialog("Please Select Category and Sub Category");
    // }
    // else {

    final result = await _controller.addProduct(
      shopId: controller.product.value.shopId,
      subcategoryId: null == null ? null : null,
      productName: controller.product.value.productName,
      price: controller.product.value.sellingPrice.toDouble(),
      wholeSalePrice: controller.product.value.wholeSalePrice.toDouble(),
      desc: controller.product.value.description,
      imageUrl: controller.product.value.imageUrl,
      stockQuantity: controller.product.value.stock,
      cost: controller.product.value.costPrice.toDouble(),
      vatApplicable: controller.product.value.vatApplicable,
      barcode: controller.product.value.barcode,
      attribute: null,
      vatAmount: null,
      uniqueID: controller.product.value.uniqueID,
      gallary: null,
      subUnit: controller.product.value.subUnit,
      version: -1,
    );

    CustomDialog.showDialogAddProductDialog(result.message);
  }
}
