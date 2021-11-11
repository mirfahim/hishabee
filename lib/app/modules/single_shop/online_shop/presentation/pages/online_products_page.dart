import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/online_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/_bindings/product_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/add_products_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/product_details_page.dart';

class OnlineProductPage extends GetView<OnlineProductController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
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
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: DEFAULT_BLACK,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Online Product",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: DEFAULT_BLACK,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 70.0, left: 15, right: 15),
                  child: Container(
                    height: 40,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        Get.to(
                          () => AddProductShowcase(
                            shop: controller.shop.value,
                            productCategoryList: controller.categoryList,
                          ),
                          binding: ProductListBinding(),
                        );
                      },
                      child: Center(
                          child: Text(
                        'plus_add_new_product'.tr,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 15, left: 15),
                  child: Container(
                    height: size.height - 130,
                    child: Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            var product = controller.products[
                                controller.products.length - 1 - index];
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => ProductDetails(),
                                  arguments: {
                                    'product': product,
                                    'shop': controller.shop.value,
                                    'catList': controller.categoryList
                                  },
                                  binding: ProductListBinding(),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  top: 0,
                                                  bottom: 0),
                                              child: Container(
                                                child: product.imageUrl != null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: 50,
                                                          width: 50,
                                                          imageUrl:
                                                              product.imageUrl,
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
                                                    : Image.asset(
                                                        'images/hishabeeLogo.png',
                                                        height: 50,
                                                        width: 50),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: size.width * 0.3,
                                                    child: Text(
                                                      "${product.name}",
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    width: size.width * 0.3,
                                                    child: Text(
                                                      "${controller.getCatName(product)}",
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * 0.39,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    product.published
                                                        ? "PUBLISHED"
                                                        : "UNPUBLISHED",
                                                    style: TextStyle(
                                                      color: product.published
                                                          ? Colors
                                                              .lightGreenAccent
                                                          : Colors.red,
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  FlutterSwitch(
                                                    height: 20.0,
                                                    width: 40.0,
                                                    padding: 0.0,
                                                    toggleSize: 20.0,
                                                    borderRadius: 20.0,
                                                    activeColor: Colors.black,
                                                    value: product.published,
                                                    onToggle: (value) async {
                                                      controller.published
                                                          .value = value;
                                                      await controller
                                                          .publishToggle(
                                                              product, value);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: size.width * 0.27,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Price",
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    child: TextFormField(
                                                      onChanged: (val) {},
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        hintText:
                                                            "${product.sellingPrice}",
                                                        hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Rubik',
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 0.27,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Delivery Charge",
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    child: TextFormField(
                                                      onChanged: (val) {},
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        hintText:
                                                            "${product.shippingCost}",
                                                        hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Rubik',
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 0.27,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Stock Count",
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    child: TextFormField(
                                                      onChanged: (val) {},
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        hintText:
                                                            "${product.stock}",
                                                        hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Rubik',
                                                          color:
                                                              Colors.blueGrey,
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
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                      /* Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              "Details",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLACK,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 25,
                                            )
                                          ],
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
