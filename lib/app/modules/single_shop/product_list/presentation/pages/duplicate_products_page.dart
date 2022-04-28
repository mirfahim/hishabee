import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/duplicate_product_controller.dart';

class DuplicateProductPage extends GetView<DuplicateProductController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'duplicate_product'.tr,
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
      ),
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Obx(
          () => Form(
            key: formKey,
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
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
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
                                            fontFamily: 'Rubik',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                            letterSpacing: 0,
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
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
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
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
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
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
                                        letterSpacing: 0,
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
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
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
                                            ? controller.product.value
                                                        .imageUrl !=
                                                    null
                                                ? Obx(
                                                    () => ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .product
                                                            .value
                                                            .imageUrl,
                                                        height: 60,
                                                        width: 60,
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(
                                                          Icons.error,
                                                          color: Colors.red,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.camera_alt,
                                                    size: 30,
                                                    color: DEFAULT_BLACK,
                                                  )
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
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
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
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
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
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
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
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
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
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
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
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
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
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      await controller.duplicateProduct();
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
