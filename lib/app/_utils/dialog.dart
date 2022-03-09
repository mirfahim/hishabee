import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/nid_verification/_bindings/nid_verification_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/nid_verification/presentation/pages/nid_verification_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';

import 'default_values.dart';

class CustomDialog {
  static void showStringDialog(String message) {
    Get.dialog(
      AlertDialog(
        // title: Text(message),
        content: Text(message),
        contentTextStyle: TextStyle(fontSize: 16, color: DEFAULT_BLACK),
        actions: <Widget>[
          TextButton(
            child: Text('close'.tr,
                style: TextStyle(color: Colors.red, fontSize: 14)),
            onPressed: () {
              navigator.pop();
            },
          ),
        ],
      ),
    );
  }

  static void showDialogAddProductDialog(String message) {
    Get.dialog(
      AlertDialog(
        // title: Text(message),
        content: Text(message.capitalizeFirst),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Get.back();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  static void showLoadingDialog({String message}) {
    Get.defaultDialog(
      radius: 4.0,
      title: "",
      barrierDismissible: false,
      content: Container(
        height: 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "images/icons/bee.png",
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                  SpinKitFadingCircle(
                    color: DEFAULT_BLUE,
                    //size: 0.0,
                  ),
                ],
              ),
            ),
            message == null
                ? Container()
                : Text(
                    message.capitalizeFirst,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: DEFAULT_BLUE,
                        fontFamily: 'Roboto',
                        fontSize: 18),
                  ),
          ],
        ),
      ),
    );
  }

  static void deleteAlertDialog() {
    try {
      Get.dialog(
        AlertDialog(
          title: Text(
            "Please Contact Support",
            style: TextStyle(fontWeight: FontWeight.bold, color: DEFAULT_BLACK),
          ),
          // title: Text(message),
          content: Text(
              "For security reason deleting shop from device is disabled. Please contact support pr call: +8809613829088",
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: DEFAULT_BLACK)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: DEFAULT_BLUE,
                  )),
              onPressed: () {
                navigator.pop();
              },
            ),
            TextButton(
              child: Text('Call Support'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: DEFAULT_BLUE)),
              onPressed: () {
                Utility.launchURL("tel:+8809613829088");
              },
            ),
          ],
        ),
      );
    } catch (e) {}
  }

  static void showUpdateStockDialog(BuildContext context, Product product,
      Shop shop, List<Category> productCategoryList) {
    Size size = MediaQuery.of(context).size;
    Get.defaultDialog(
      title: "update_stock".tr,
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        // fontSize: 28,
        color: DEFAULT_BLUE,
      ),
      content: Container(
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
              child: product.imageUrl == null || product.imageUrl == "null"
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
                  '${product.subCategory}',
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
                    fontFamily: 'Roboto',
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
                  Container(
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
                                fontWeight: FontWeight.bold, color: Colors.red),
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
                        keyboardType: TextInputType.number,
                        initialValue: "${product.stock}",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 5, right: 5, bottom: 10),
                        ),
                      )),
                  SizedBox(width: 5),
                  Padding(
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
                  onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }

  static void hideDialog() {
    if (Get.isDialogOpen) {
      Get.back();
    }
  }

  static void showNidVerigyDialog() {
    Get.dialog(
      AlertDialog(
        content: Text("Please Verify your NID"),
        contentTextStyle: TextStyle(fontSize: 16, color: DEFAULT_BLACK),
        actions: <Widget>[
          TextButton(
            child: Text('close'.tr,
                style: TextStyle(color: Colors.red, fontSize: 14)),
            onPressed: () {
              navigator.pop();
            },
          ),
          Container(
            height: 30,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: DEFAULT_BLACK,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: DEFAULT_BLACK),
              onPressed: () {
                Get.back();
                Get.to(() => NidVerificationPage(),
                    binding: NidVerificationBinding());
              },
              child: Center(
                child: Text(
                  "Verify NID",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
