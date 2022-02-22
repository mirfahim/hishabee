import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/help_button_box.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/edit_product_controller.dart';

class PreviousEditProductPage extends GetView<EditProductController> {
  int stockQuantity;
  Category selectedProductCategory;
  SubCategory selectedSubCat;
  String _selectedUnit;
  String productName;
  String savedProductName;
  double price;
  double cost;
  double wholeSalePrice;

  String desc;
  bool vatApplicable = false;
  bool isAdvanced = false;
  bool isStockAlert = false;
  bool isOnline = false;
  bool isWholeSale = false;
  bool isRetail = false;
  bool isVat = false;
  bool isWarrenty = false;
  int selectedUnitIndex;
  bool isDiscount = false;
  double vatAmount;
  String unitPrice;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'edit_product'.tr,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: DEFAULT_BLUE_DARK,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: DEFAULT_BLUE_DARK,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.contact_support,
                size: 30,
                color: DEFAULT_BLUE,
              ),
              onPressed: () {
                final String url =
                    "https://www.youtube.com/watch?v=TcpUBjeX0N4&list=PLO7C_xRyL47emWQfUcp2-djjzgdlPGcqS&index=5";
                final String title = "product_add_showcase".tr;
                HelpButton.setBox(ButtonKey.addProductKey);
                Navigator.of(context).push(TutorialOverlay(url, title));
              })
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: Container(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //     top: 20,
                            //     right: 15,
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       IconButton(
                            //         icon: Icon(
                            //           Icons.arrow_back,
                            //           size: 25,
                            //           color: DEFAULT_BLUE_DARK,
                            //         ),
                            //         onPressed: () {
                            //           Navigator.pop(context);
                            //         },
                            //       ),
                            //       Text(
                            //         'edit_product'.tr,
                            //         style: TextStyle(
                            //           fontFamily: 'Rubik',
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.bold,
                            //           color: DEFAULT_BLUE_DARK,
                            //         ),
                            //       ),
                            //       Spacer(),
                            //       Container(
                            //         height: 35,
                            //         width: 35,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(4),
                            //             color: Colors.red),
                            //         child: IconButton(
                            //           onPressed: () async {
                            //             //need implement
                            //             await controller.deleteProducts(
                            //                 controller.product.value.id);
                            //           },
                            //           icon: Center(
                            //               child: Icon(
                            //             Icons.delete_forever,
                            //             color: Colors.white,
                            //             size: 15,
                            //           )),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 10),
                              child: Obx(
                                () => Text(
                                  "${controller.shop.value.name}",
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF1F1F1),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'product_description'.tr,
                                      style: TextStyle(
                                          color: Color(0xFF185ADB),
                                          fontSize: 18,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5, top: 8),
                                      child: Text(
                                        "product_name".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLUE_DARK,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5, top: 8),
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: TextFormField(
                                            initialValue:
                                                controller.product.value.name,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter product name';
                                              }
                                              return null;
                                            },
                                            onChanged: (val) {
                                              productName = val;
                                              savedProductName = val;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              hintText: "product_name".tr,
                                              hintStyle: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: Colors.blueGrey,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5),
                                      child: Container(
                                        width: size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "price".tr,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLUE_DARK,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: TextFormField(
                                                    initialValue: controller
                                                        .product
                                                        .value
                                                        .sellingPrice
                                                        .toString(),
                                                    cursorColor: DEFAULT_BLACK,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter product price';
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (value) {
                                                      if (value != "") {
                                                        price =
                                                            double.parse(value);
                                                      } else {
                                                        price = 0;
                                                      }
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      hintText: "Product Price",
                                                      hintStyle: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5),
                                      child: Container(
                                        width: size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "total_stock_quantity".tr,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLUE_DARK,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: TextFormField(
                                                    initialValue: controller
                                                        .product.value.stock
                                                        .toString(),
                                                    // validator: (value) {
                                                    //   if (value.isEmpty) {
                                                    //     return 'Please enter stock quantity';
                                                    //   }
                                                    //   return null;
                                                    // },
                                                    onChanged: (val) {
                                                      if (val != "") {
                                                        stockQuantity =
                                                            int.parse(val);
                                                      } else {
                                                        stockQuantity = 0;
                                                      }
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          "stock_quantity".tr,
                                                      hintStyle: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                          top: 8,
                                          bottom: 10),
                                      child: DottedBorder(
                                        radius: Radius.circular(6),
                                        borderType: BorderType.RRect,
                                        dashPattern: [8, 4],
                                        strokeWidth: 2,
                                        color: Color(0xFF185ADB),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                                'পন্যের স্টক সংখ্যা না দিলে ব্যবসার হিসাব সঠিক ভাবে দেখা যাবে না',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF185ADB),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 5.0, right: 5),
                                    //   child: Container(
                                    //     width: size.width,
                                    //     child: Column(
                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                    //       children: [
                                    //         Text(
                                    //           "cost_optional".tr,
                                    //           style: TextStyle(
                                    //             fontSize: 16,
                                    //             fontFamily: "Rubik-VariableFont_wght",
                                    //             fontWeight: FontWeight.bold,
                                    //             color: DEFAULT_BLUE_DARK,
                                    //           ),
                                    //         ),
                                    //         Container(
                                    //           height: 48,
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.white,
                                    //             borderRadius: BorderRadius.circular(5),
                                    //             border: Border.all(
                                    //                 width: 1, color: Colors.grey),
                                    //           ),
                                    //           child: Padding(
                                    //             padding:
                                    //             const EdgeInsets.only(left: 15.0),
                                    //             child: TextField(
                                    //               onChanged: (value) {
                                    //                 if (value != "") {
                                    //                   cost = double.parse(value);
                                    //                 } else {
                                    //                   cost = 0;
                                    //                 }
                                    //               },
                                    //               inputFormatters: [
                                    //                 FilteringTextInputFormatter.digitsOnly
                                    //               ],
                                    //               keyboardType: TextInputType.number,
                                    //               decoration: InputDecoration(
                                    //                 border: InputBorder.none,
                                    //                 focusedBorder: InputBorder.none,
                                    //                 enabledBorder: InputBorder.none,
                                    //                 hintText: "Product Cost",
                                    //                 hintStyle: TextStyle(
                                    //                   fontFamily: 'Rubik',
                                    //                   color: Colors.blueGrey,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15),
                                    child: Container(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "cost".tr,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE_DARK,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: TextFormField(
                                                  initialValue: controller
                                                      .product.value.costPrice
                                                      .toString(),
                                                  cursorColor: DEFAULT_BLACK,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter product price';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) {
                                                    if (value != "") {
                                                      price =
                                                          double.parse(value);
                                                    } else {
                                                      price = 0;
                                                    }
                                                  },
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    hintText: "Product Price",
                                                    hintStyle: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.blueGrey,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0,
                                                          right: 15,
                                                          top: 8),
                                                  child: Text(
                                                    "description".tr,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLUE_DARK,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0,
                                                          right: 15,
                                                          top: 8),
                                                  child: Container(
                                                    height: 95,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: TextFormField(
                                                        // validator: (value) {
                                                        //   if (value.isEmpty) {
                                                        //     return 'Please enter product description';
                                                        //   }
                                                        //   return null;
                                                        // },
                                                        onChanged: (value) {
                                                          desc = value;
                                                        },
                                                        // keyboardType: TextInputType.number,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          hintText:
                                                              "description".tr,
                                                          hintStyle: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            color:
                                                                Colors.blueGrey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15,
                                        top: 8,
                                        bottom: 10),
                                    child: DottedBorder(
                                      radius: Radius.circular(6),
                                      borderType: BorderType.RRect,
                                      dashPattern: [8, 4],
                                      strokeWidth: 2,
                                      color: Color(0xFF185ADB),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                              'পন্যের স্টক সংখ্যা না দিলে ব্যবসার হিসাব সঠিক ভাবে দেখা যাবে না',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF185ADB),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 10),
                                        child: Text(
                                          "category".tr,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily:
                                                "Rubik-VariableFont_wght",
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLUE_DARK,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _showCategoryDialog(
                                            controller.productCategoryList,
                                            size,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 10, top: 8),
                                          child: Container(
                                            height: 48,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  width: 1, color: Colors.grey),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 20,
                                                            top: 8),
                                                    child: Obx(
                                                      () => Text(
                                                        controller.selectedProductCategory
                                                                    .value ==
                                                                null
                                                            ? "${controller.catName.value}"
                                                            : controller
                                                                .selectedProductCategory
                                                                .value
                                                                .name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          // fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DEFAULT_BLACK,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Icon(
                                                      Icons.arrow_drop_down),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10),
                                        child: Text(
                                          "sub_category".tr,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily:
                                                "Rubik-VariableFont_wght",
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLUE_DARK,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (controller.selectedProductCategory
                                                  .value ==
                                              null) {
                                            _showGeneralDialog(
                                              "Please select Product Category first",
                                            );
                                          } else {
                                            _showSubCategoryDialog(
                                              controller.selectedProductCategory
                                                  .value.subCategory,
                                              size,
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 15, top: 8),
                                          child: Container(
                                            height: 48,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  width: 1, color: Colors.grey),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Obx(
                                                      () => Text(
                                                        controller.selectedSubCat
                                                                    .value ==
                                                                null
                                                            ? "${controller.subCatName.value}"
                                                            : controller
                                                                .selectedSubCat
                                                                .value
                                                                .name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          // fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DEFAULT_BLACK,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Icon(
                                                      Icons.arrow_drop_down),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "product_name".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Container(
                                      height: size.height * 0.08,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(
                                          () => TextFormField(
                                            initialValue:
                                                controller.product.value.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            onSaved: (value) {
                                              controller.productName.value =
                                                  value;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              //hintText: productName,
                                              hintStyle: TextStyle(
                                                  // textine: Textine.alphabetic,
                                                  fontFamily: 'Rubik',
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "vat_applicable".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Text(
                                              "vat_applicable_yes".tr,
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                // fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLACK,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Obx(
                                              () => Checkbox(
                                                value: controller
                                                    .vatApplicable.value,
                                                onChanged: (value) {
                                                  controller
                                                          .vatApplicable.value =
                                                      (!controller
                                                          .vatApplicable.value);
                                                  controller.product.value
                                                      .vatApplicable = value;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => controller.vatApplicable.value
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15, top: 8),
                                            child: Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Colors.black),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Obx(
                                                  () => TextFormField(
                                                    initialValue: controller
                                                        .product
                                                        .value
                                                        .vatPercent
                                                        .toString(),
                                                    onSaved: (value) {
                                                      controller
                                                              .vatAmount.value =
                                                          double.parse(value);
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      suffix: Text(
                                                        " % ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      //hintText: "VAT Amount",
                                                      hintStyle: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "product_image_optional".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "add_a_suitable_product_image".tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _showPictureOptionDialogue(100);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(1),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        height: 60,
                                        width: 60,
                                        child: controller.image.value == null
                                            ?
                                            // controller.productImageUrl.value
                                            //             .isNotEmpty
                                            //         ? Obx(
                                            //             () => Stack(
                                            //               children: [
                                            //                 ClipRRect(
                                            //                   borderRadius:
                                            //                       BorderRadius
                                            //                           .circular(4),
                                            //                   child:
                                            //                       CachedNetworkImage(
                                            //                     imageUrl: controller
                                            //                         .productImageUrl
                                            //                         .value,
                                            //                     height: 60,
                                            //                     width: 60,
                                            //                     placeholder: (context,
                                            //                             url) =>
                                            //                         CircularProgressIndicator(),
                                            //                     errorWidget:
                                            //                         (context, url,
                                            //                                 error) =>
                                            //                             Icon(
                                            //                       Icons.error,
                                            //                       color: Colors.red,
                                            //                     ),
                                            //                     fit: BoxFit.fill,
                                            //                   ),
                                            //                 ),
                                            //                 Positioned(
                                            //                   right: 0,
                                            //                   top: 0,
                                            //                   child: InkWell(
                                            //                     onTap: () {
                                            //                       controller
                                            //                           .removeProductImage();
                                            //                     },
                                            //                     child: Container(
                                            //                       height: 25,
                                            //                       width: 25,
                                            //                       decoration:
                                            //                           BoxDecoration(
                                            //                         color: Colors
                                            //                             .black,
                                            //                         borderRadius:
                                            //                             BorderRadius
                                            //                                 .circular(
                                            //                                     15),
                                            //                       ),
                                            //                       child: Center(
                                            //                         child: Icon(
                                            //                           Icons.cancel,
                                            //                           color: Colors
                                            //                               .white,
                                            //                         ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               ],
                                            //             ),
                                            //           )
                                            //         : Icon(
                                            //             Icons.camera_alt,
                                            //             size: 30,
                                            //             color: DEFAULT_BLACK,
                                            //           )
                                            Container()
                                            : Image(
                                                image: FileImage(
                                                    controller.image.value),
                                                height: 60,
                                                width: 60,
                                              ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "price".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(
                                          () => TextFormField(
                                            initialValue: controller
                                                .product.value.sellingPrice
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            onSaved: (value) {
                                              controller.price.value =
                                                  double.parse(value);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              // hintText: "Product Price",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Rubik',
                                                color: Colors.blueGrey,
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
                            Container(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "cost_optional".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(
                                          () => TextFormField(
                                            initialValue: controller
                                                .product.value.costPrice
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            onSaved: (value) {
                                              controller.cost.value =
                                                  double.parse(value);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              // hintText: "Product Price",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Rubik',
                                                color: Colors.blueGrey,
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
                            Container(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "stock_quantity".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(
                                          () => TextFormField(
                                            initialValue: controller
                                                .product.value.stock
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            onSaved: (value) {
                                              controller.stockQuantity.value =
                                                  int.parse(value);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              // hintText: "Product Price",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Rubik',
                                                color: Colors.blueGrey,
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
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "description".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Container(
                                      height: 95,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(
                                          () => TextFormField(
                                            initialValue: controller
                                                .product.value.description,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            onSaved: (value) {
                                              controller.desc.value = value;
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              hintText: "Description",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Rubik',
                                                color: Colors.blueGrey,
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
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Text(
                                      "want_to_sell_online".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Rubik-VariableFont_wght",
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 8),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Obx(
                                              () => Text(
                                                controller.isOnline.value
                                                    ? "ONLINE"
                                                    : "OFFLINE",
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  // fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: DEFAULT_BLACK,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Obx(
                                              () => FlutterSwitch(
                                                height: 25.0,
                                                width: 40.0,
                                                padding: 4.0,
                                                toggleSize: 20.0,
                                                borderRadius: 20.0,
                                                activeColor: Colors.black,
                                                value:
                                                    controller.isOnline.value,
                                                onToggle: (value) {
                                                  controller.isOnline.value =
                                                      value;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 8),
                              child: Text(
                                'barcode'.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Rubik-VariableFont_wght",
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLUE_DARK,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 8),
                              child: Container(
                                  width: size.width,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: DEFAULT_YELLOW_BG),
                                    onPressed: () {
                                      scanProduct();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          height: 20,
                                          image: AssetImage(
                                              'images/icons/scanIcon.png'),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'scan'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            // fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            // color: default_blue,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 8),
                              child: Text(
                                "add_the_barcode_associated_with_the_product_by_pressing_scan_button"
                                    .tr,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: DEFAULT_BLUE_DARK,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 15, bottom: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: DEFAULT_BLACK),
                                  onPressed: () async {
                                    if (controller.formKey.currentState
                                        .validate()) {
                                      controller.formKey.currentState.save();
                                      CustomDialog.showLoadingDialog(
                                          message: "Updating Product");
                                      await controller.editProduct();
                                      if (Get.isDialogOpen) {
                                        Get.back();
                                      }
                                      Get.back();
                                    }
                                  },
                                  child: Text(
                                    "save".tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> scanProduct() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (barcodeScanRes != null) {
      controller.barcode.value = barcodeScanRes;
      print("EDBC ${controller.barcode.value}");
    }
  }

  _showGeneralDialog(String content) {
    Get.defaultDialog(
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }

  _showCategoryDialog(List<Category> productCategoryList, Size size) {
    Get.defaultDialog(
      radius: 4,
      title: "Product Category",
      titleStyle: TextStyle(color: DEFAULT_BLUE, fontWeight: FontWeight.bold),
      barrierDismissible: false,
      content: Container(
        height: size.height / 2,
        width: size.width / 1.5,
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: size.height / 2,
                  width: size.width / 1.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: productCategoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedProductCategory.value =
                              productCategoryList[index];
                          Navigator.pop(context);
                          _showSubCategoryDialog(
                            productCategoryList[index].subCategory,
                            size,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  productCategoryList[index].icon,
                                  height: 25,
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    width: size.width / 2,
                                    child: Text(
                                      productCategoryList[index].name,
                                      style: TextStyle(
                                        color: DEFAULT_BLUE,
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }

  _showSubCategoryDialog(List<SubCategory> subCategoryList, Size size) {
    Get.defaultDialog(
      radius: 4,
      title: "Product Sub Category",
      titleStyle: TextStyle(color: DEFAULT_BLUE, fontWeight: FontWeight.bold),
      barrierDismissible: false,
      content: Container(
        height: size.height / 2,
        width: size.width / 1.5,
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: size.height / 2,
                  width: size.width / 1.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedSubCat.value =
                              subCategoryList[index];
                          Navigator.pop(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  controller.productCategoryList[index].icon,
                                  height: 25,
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    width: size.width / 2,
                                    child: Text(
                                      subCategoryList[index].name,
                                      style: TextStyle(
                                          color: DEFAULT_BLUE,
                                          fontFamily: "Rubik"),
                                    )),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }

  _showPictureOptionDialogue(int option) {
    Get.defaultDialog(
      radius: 4,
      title: "Picture option",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              ImageHelper.getImageFromCamera().then((value) {
                controller.image.value = value;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      height: 80,
                      image: AssetImage('images/icons/camera.png'),
                    ),
                    Text("Camera")
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //getImageFromGallery(option);
              ImageHelper.getImageFromGallery().then((value) {
                controller.image.value = value;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      height: 80,
                      image: AssetImage('images/icons/gallery.png'),
                    ),
                    Text("Gallery")
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>(
        'vatApplicable', controller.vatApplicable.value));
  }
}
