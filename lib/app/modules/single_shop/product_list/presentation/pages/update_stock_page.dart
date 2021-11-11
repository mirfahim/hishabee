import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/update_stock_controller.dart';

class UpdateStock extends GetView<UpdateStockController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
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
                              'update_stock'.tr,
                              style: TextStyle(
                                fontFamily: 'Rubik-VariableFont_wght',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Obx(
                      () => Text(
                        controller.shop.value.name,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLUE,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Icon(
                              Icons.search,
                              color: DEFAULT_BLUE,
                              size: 28,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              width: size.width / 5,
                              child: TextFormField(
                                onChanged: (value) {
                                  controller.searchProduct(value);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "search_product".tr,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: VerticalDivider(
                            thickness: 0.8,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              controller.scanProduct();
                            },
                            child: Container(
                              width: size.width / 5,
                              child: Row(
                                children: [
                                  Image(
                                    height: 15,
                                    image: AssetImage(
                                        'images/icons/barcodeIcon.png'),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Scan',
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      // fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLACK,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: VerticalDivider(
                            thickness: 0.8,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              _showCategoryDialog(
                                  controller.productCategoryList,
                                  size,
                                  context);
                            },
                            child: Container(
                              width: size.width / 5,
                              child: Row(
                                children: [
                                  Image(
                                    height: 15,
                                    image: AssetImage(
                                        'images/icons/filterIcon.png'),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      // fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLACK,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                    child: Container(
                      height: size.height > 550 && size.height < 650
                          ? size.height * 0.48
                          : size.height > 650 && size.height < 700
                              ? size.height * 0.55
                              : size.height > 700
                                  ? size.height * 0.6
                                  : size.height * 0.65,
                      width: size.width,
                      child: Obx(
                        () => MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              itemCount: controller.searchList.length,
                              itemBuilder: (BuildContext context, int index) {
                                Product product = controller.searchList[
                                    controller.searchList.length - 1 - index];
                                TextEditingController stockController =
                                    TextEditingController(
                                        text: product.stock.toString());
                                int stock = product.stock;
                                List<String> subCatName = [];
                                controller.productCategoryList.forEach(
                                    (Category c) =>
                                        c.subCategory.forEach((SubCategory sc) {
                                          if (sc.id == product.subCategory) {
                                            subCatName.add(sc.name);
                                          }
                                        }));
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      left: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                      right: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 8, bottom: 8),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 5, bottom: 5),
                                          child: Container(
                                            child: product.imageUrl != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          product.imageUrl,
                                                      height: 50,
                                                      width: 50,
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
                                                  )
                                                : Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Center(
                                                      child: Image.asset(
                                                          'images/hishabeeLogo.png',
                                                          height: 35,
                                                          width: 35),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width * 0.32,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  product.name,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Rubik-VariableFont_wght',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: DEFAULT_BLUE_DARK,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                width: size.width * 0.32,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    '${subCatName[0]} | Stock: ${product.stock}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Rubik-Italic-VariableFont_wght',
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    controller.decrementStock(
                                                        product);
                                                  },
                                                  icon: Image.asset(
                                                    "images/icons/red_minus.png",
                                                    height: 30,
                                                  )),
                                              SizedBox(width: 2),
                                              Container(
                                                  width: size.width * 0.15,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: TextFormField(
                                                    controller: stockController,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Rubik-VariableFont_wght',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLUE_DARK,
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 5,
                                                              right: 5,
                                                              bottom: 15),
                                                    ),
                                                  )),
                                              SizedBox(width: 2),
                                              IconButton(
                                                  onPressed: () {
                                                    controller.incrementStock(
                                                        product);
                                                  },
                                                  icon: Image.asset(
                                                    "images/icons/green_plus.png",
                                                    height: 30,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: () {
                    controller.updateStock();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 15, left: 15, bottom: 5, top: 5),
                    child: Container(
                      height: 40,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: DEFAULT_BLACK,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'done'.tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            color: Colors.white,
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
      ),
    );
  }

  _showCategoryDialog(
      List<Category> productCategoryList, Size size, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => KeyboardAwareDialog(
        child: Container(
          height: size.height * 0.8,
          width: size.width / 1.5,
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: size.height * 0.7,
                    width: size.width / 1.5,
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.filterCategory.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              controller.filterProduct(
                                  controller.filterCategory[index].id);
                              Get.back();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: size.width / 2,
                                    child: Text(
                                      controller.filterCategory[index].name,
                                      style: TextStyle(
                                        color: DEFAULT_BLUE,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                SizedBox(height: 10),
                                Divider(
                                  color: DEFAULT_BLACK,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                child: Text(
                  'Close',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
