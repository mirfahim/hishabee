import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/_bindings/product_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_list_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/product_details_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/update_stock_page.dart';

import 'add_products_page.dart';
import 'duplicate_products_page.dart';
import 'edit_products_page.dart';

//product list
class ProductListPage extends GetView<ProductListController> {
  var totalProductCost = 0.obs;
  INetworkInfo networkInfo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // totalProductCost.value =
    //     controller.productList[controller.productList.length - 1].sellingPrice +
    //             totalProductCost.value ??
    //         0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        title: Text(
          'product_list'.tr,
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {},
                child: SvgPicture.asset('images/svg_image/help.svg')),
          )
        ],
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListView(
                      physics: ScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.25,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xFF185ADB),
                                            width: 1.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.0))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0),
                                            child: TextFormField(
                                              onChanged: (value) {
                                                controller.searchProduct(value);
                                              },
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                hintText: "Search For Product",
                                                icon: SvgPicture.asset(
                                                    'images/svg_image/search.svg'),
                                                hintStyle: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: 'Roboto'),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Container(
                                                child: IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      height: 30,
                                                      child: VerticalDivider(
                                                          thickness: 2,
                                                          color:
                                                              Color(0xFF185ADB),
                                                          indent: 0,
                                                          endIndent: 0)),
                                                  InkWell(
                                                    onTap: () {
                                                      _showCategoryDialog(
                                                          controller
                                                              .productCategoryList,
                                                          size,
                                                          context);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5.0,
                                                              left: 5),
                                                      child: SvgPicture.asset(
                                                          'images/svg_image/filter.svg'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'filter'.tr,
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto'),
                                                  )
                                                ],
                                              ),
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: IconButton(
                                          icon: SvgPicture.asset(
                                              'images/svg_image/scanner.svg'),
                                          onPressed: () async {
                                            await controller.scanProduct();
                                          },
                                          color: Color(0xFF185ADB)))
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 10.0, left: 15, right: 15),
                            //   child: Container(
                            //     height: 40,
                            //     width: size.width,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(4),
                            //     ),
                            //     child: ElevatedButton(
                            //       style: ElevatedButton.styleFrom(
                            //           primary: Colors.black),
                            //       onPressed: () {
                            //         Get.to(
                            //               () => AddProductShowcase(
                            //             shop: controller.shop.value,
                            //             productCategoryList:
                            //             controller.productCategoryList,
                            //           ),
                            //           binding: ProductListBinding(),
                            //         );
                            //       },
                            //       child: Center(
                            //           child: Text(
                            //             'plus_add_new_product'.tr,
                            //             style: TextStyle(
                            //               fontFamily: 'Rubik',
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.normal,
                            //               color: Colors.white,
                            //             ),
                            //           )),
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 10.0, left: 15, right: 15),
                            //   child: Container(
                            //     height: 40,
                            //     width: size.width,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //     ),
                            //     child: ElevatedButton(
                            //       style: ElevatedButton.styleFrom(
                            //           primary: Colors.black),
                            //       onPressed: () {
                            //         Get.to(UpdateStock(),
                            //             arguments: {
                            //               "shop": controller.shop.value,
                            //               "catList":
                            //               controller.productCategoryList,
                            //               "productList":
                            //               controller.productList,
                            //             },
                            //             binding: ProductListBinding());
                            //       },
                            //       child: Center(
                            //           child: Text(
                            //             'update_stock'.tr,
                            //             style: TextStyle(
                            //               fontFamily: 'Rubik',
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.normal,
                            //               color: Colors.white,
                            //             ),
                            //           )),
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(15.0),
                            //   child: Container(
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(4),
                            //       border: Border.all(
                            //           width: 1, color: Colors.grey),
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.spaceEvenly,
                            //       children: [
                            //         Expanded(
                            //           flex: 1,
                            //           child: Padding(
                            //             padding:
                            //             const EdgeInsets.only(left: 10.0),
                            //             child: Icon(
                            //               Icons.search,
                            //               color: DEFAULT_BLUE,
                            //               size: 28,
                            //             ),
                            //           ),
                            //         ),
                            //         Expanded(
                            //           flex: 4,
                            //           child: Padding(
                            //             padding:
                            //             const EdgeInsets.only(left: 5.0),
                            //             child: Container(
                            //               width: size.width / 5,
                            //               child: TextField(
                            //                 onChanged: (value) {
                            //                   controller.searchProduct(value);
                            //                 },
                            //                 decoration: InputDecoration(
                            //                   border: InputBorder.none,
                            //                   focusedBorder: InputBorder.none,
                            //                   enabledBorder: InputBorder.none,
                            //                   hintText: "search_product".tr,
                            //                   hintStyle: TextStyle(
                            //                     color: Colors.grey,
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               vertical: 12.0),
                            //           child: VerticalDivider(
                            //             thickness: 0.8,
                            //             color: Colors.black,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           flex: 2,
                            //           child: InkWell(
                            //             onTap: () async {
                            //               await controller.scanProduct();
                            //             },
                            //             child: Container(
                            //               width: size.width / 5,
                            //               child: Row(
                            //                 children: [
                            //                   Image(
                            //                     height: 15,
                            //                     image: AssetImage(
                            //                         'images/icons/barcodeIcon.png'),
                            //                   ),
                            //                   SizedBox(width: 10),
                            //                   Text(
                            //                     'Scan',
                            //                     style: TextStyle(
                            //                       fontFamily:
                            //                       'Rubik-VariableFont_wght',
                            //                       fontWeight: FontWeight.bold,
                            //                       color: DEFAULT_BLUE,
                            //                     ),
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               vertical: 12.0),
                            //           child: VerticalDivider(
                            //             thickness: 0.8,
                            //             color: Colors.black,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           flex: 2,
                            //           child: InkWell(
                            //             onTap: () {
                            //               _showCategoryDialog(
                            //                   controller.productCategoryList,
                            //                   size,
                            //                   context);
                            //             },
                            //             child: Container(
                            //               width: size.width / 5,
                            //               child: Row(
                            //                 children: [
                            //                   Image(
                            //                     height: 15,
                            //                     image: AssetImage(
                            //                         'images/icons/filterIcon.png'),
                            //                   ),
                            //                   SizedBox(width: 5),
                            //                   Text(
                            //                     'Filter',
                            //                     style: TextStyle(
                            //                       fontFamily:
                            //                       'Rubik-VariableFont_wght',
                            //                       fontWeight: FontWeight.bold,
                            //                       color: DEFAULT_BLUE,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Expanded(
                                      child: Text(
                                        'total_product'.tr +
                                            ":" +
                                            '${controller.searchList.length}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto'),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (controller.flag.value == 0) {
                                        controller.flag.value = 1;
                                      } else {
                                        controller.flag.value = 0;
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Obx(() => controller
                                                      .flag.value ==
                                                  0
                                              ? SvgPicture.asset(
                                                  'images/svg_image/grid.svg')
                                              : SvgPicture.asset(
                                                  'images/svg_image/list.svg')),
                                        ),
                                        Obx(() => controller.flag.value == 0
                                            ? Text(
                                                'gridView'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto'),
                                              )
                                            : Text(
                                                'listView'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto'),
                                              )) //sdsd
                                      ],
                                    ),
                                  )
                                  // )
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 15, left: 15, bottom: 5),
                              child: Obx(
                                () => controller.flag.value == 0
                                    ? Container(
                                        // height: size.height - 200,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                controller.searchList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Product product = controller
                                                      .searchList[
                                                  controller.searchList.length -
                                                      1 -
                                                      index];
                                              return InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                      () => ProductDetails(),
                                                      arguments: {
                                                        'product': product,
                                                        'shop': controller
                                                            .shop.value,
                                                        'catList': controller
                                                            .productCategoryList
                                                      },
                                                      binding:
                                                          ProductListBinding(),
                                                    );
                                                  },
                                                  child:
                                                      //
                                                      Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      ListTile(
                                                        leading: product
                                                                    .imageUrl !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl: product
                                                                    .imageUrl,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    new CircularProgressIndicator(),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    new Icon(Icons
                                                                        .error),
                                                              )
                                                            : Container(
                                                                height: 50,
                                                                width: 50,
                                                                child: Center(
                                                                  child: Image.asset(
                                                                      'images/hishabeeLogo.png',
                                                                      height:
                                                                          35,
                                                                      width:
                                                                          35),
                                                                ),
                                                              ),
                                                        title: Text(
                                                          product.name,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto'),
                                                          maxLines: 3,
                                                        ),
                                                        trailing: Text(
                                                          '৳ ${product.sellingPrice}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto'),
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 2,
                                                        color: Color(0xFFC4C4C4)
                                                            .withOpacity(.35),
                                                      ),
                                                    ],
                                                  ));
                                            }),
                                      )
                                    : Container(
                                        height: size.height - 300,
                                        child: GridView.count(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                            children: List.generate(
                                              controller.searchList.length,
                                              (index) {
                                                Product product = controller
                                                    .searchList[controller
                                                        .searchList.length -
                                                    1 -
                                                    index];
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                      () => ProductDetails(),
                                                      arguments: {
                                                        'product': product,
                                                        'shop': controller
                                                            .shop.value,
                                                        'catList': controller
                                                            .productCategoryList
                                                      },
                                                      binding:
                                                          ProductListBinding(),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF1F1F1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        product.imageUrl != null
                                                            ? Container(
                                                                height: 50,
                                                                width: 50,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: product
                                                                      .imageUrl,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      new CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      new Icon(Icons
                                                                          .error),
                                                                ),
                                                              )
                                                            : Container(
                                                                height: 50,
                                                                width: 50,
                                                                child: Center(
                                                                  child: Image.asset(
                                                                      'images/hishabeeLogo.png',
                                                                      height:
                                                                          35,
                                                                      width:
                                                                          35),
                                                                ),
                                                              ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          product.name,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto'),
                                                          maxLines: 3,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '৳ ${product.sellingPrice}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 40.0,
                  //   decoration: BoxDecoration(
                  //     color: DEFAULT_BLUE,
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(10),
                  //       topRight: Radius.circular(10),
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 8.0, right: 8),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Total Cost',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //         Obx(() {
                  //           // totalProductCost.value = controller
                  //           //         .productList[
                  //           //             controller.productList.length - 1]
                  //           //         .sellingPrice +
                  //           //     totalProductCost.value;
                  //           return Text(
                  //             '${totalProductCost.value}',
                  //             style: TextStyle(color: Colors.white),
                  //           );
                  //         })
                  //       ],
                  //     ),
                  //   ),
                  // )
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF185ADB),
                        ),
                        onPressed: () {
                          Get.to(
                            () => AddProductShowcase(
                              shop: controller.shop.value,
                              productCategoryList:
                                  controller.productCategoryList,
                            ),
                            binding: ProductListBinding(),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'add_new_product'.tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  showUpdateStockDialog(BuildContext context, Product product, Shop shop,
      List<Category> productCategoryList) {
    String catagory;
    productCategoryList
        .forEach((Category c) => c.subCategory.forEach((SubCategory sc) {
              if (sc.id == product.subCategory) {
                catagory = sc.name;
              }
            }));
    Size size = MediaQuery.of(context).size;
    TextEditingController controller =
        TextEditingController(text: product.stock.toString());
    int stock = product.stock;
    showDialog(
        barrierDismissible: true,
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
                                    height: size.height * 0.15,
                                    width: size.width * 0.8,
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
                          '$catagory',
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
                              int temp = stock--;
                              controller.text = (temp - 1).toString();
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
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 5, right: 5, bottom: 10),
                                ),
                              )),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              int temp = stock++;
                              controller.text = (temp + 1).toString();
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
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: DEFAULT_BLUE),
                          onPressed: () {
                            Get.find<ProductListController>()
                                .updateStock(shop.id, product, stock);
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
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  _showCategoryDialog(
      List<Category> productCategoryList, Size size, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => KeyboardAwareDialog(
        child: Container(
          height: size.height * 0.9,
          width: size.width / 1.5,
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: size.height * 0.8,
                    width: size.width / 1.5,
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.filterCategory.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(
                            () => CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: DEFAULT_BLACK,
                              title: Text(
                                controller.filterCategory[index].name,
                                style: TextStyle(
                                  color: DEFAULT_BLACK,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              value: controller.isChecked[index],
                              onChanged: (value) {
                                controller.checkFilterCategory(index, value);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Row(
                  children: [
                    Spacer(),
                    TextButton(
                      child: Text(
                        'Close',
                        style: TextStyle(
                            color: DEFAULT_BLACK,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      onPressed: () {
                        controller.getAllProduct();
                        Get.back();
                      },
                    ),
                    Obx(
                      () => TextButton(
                        child: Text(
                          'Done',
                          style: TextStyle(
                              color: controller.isChecked.contains(true)
                                  ? DEFAULT_BLACK
                                  : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (controller.isChecked.contains(true)) {
                            controller.filterProductsByCategory();
                            Get.back();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
