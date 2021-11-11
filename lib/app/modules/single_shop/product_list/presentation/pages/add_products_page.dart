import 'dart:io';

// import 'dart:io' as Io;

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/help_button_box.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/_bindings/product_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/attribute_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/variation_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/add_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/quick_add_product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showcaseview/showcaseview.dart';

import 'add_category_page.dart';

class AddProductShowcase extends StatelessWidget {
  final Shop shop;
  final List<Category> productCategoryList;

  AddProductShowcase({this.shop, this.productCategoryList});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
          builder: (context) => AddProductsPage(
                shop: shop,
                productCategoryList: productCategoryList,
              )),
      autoPlay: true,
      autoPlayDelay: Duration(seconds: 3),
      autoPlayLockEnable: true,
    );
  }
}

class AddProductsPage extends StatefulWidget {
  final Shop shop;
  final List<Category> productCategoryList;

  AddProductsPage({
    this.shop,
    this.productCategoryList,
  });

  @override
  _AddProductsPageState createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  GlobalKey _addProductWalkThrough = GlobalKey();

  final AddProductController controller = Get.find();

  Category selectedProductCategory;
  SubCategory selectedSubCat;
  String productName;
  String savedProductName;
  double price;
  double cost;
  int stockQuantity;
  String desc;
  bool vatApplicable = false;
  bool isAdvanced = false;
  double vatAmount;

  // Map<String, String> attributes;
  List<Attribute> attributeList = [];
  String attributeName = "";
  String attributeValue = "";
  List<String> variationValues = [];
  int numberOfVariation = 3;
  Map<int, String> variationData = Map();
  Map<String, String> variationDataModel = Map();
  String variationName = "";
  final _formKey = GlobalKey<FormState>();
  String mainProductBarCode;
  List<Variation> variationModelData = [];

  var list;
  List<dynamic> imageList;

  final picker = ImagePicker();
  File _image;
  Map<int, File> imageMap = new Map();
  Map<int, String> imageUrl = new Map();
  String mainImageUrl;
  String attributeMap;
  bool adding = false;
  bool attributeAvailable = false;

  // for variations
  String priceI;
  double costI;
  int stockI;
  String barcodeI;
  String imageUrlI;
  var showCaseTap;

  @override
  void initState() {
    getBox();
    setState(() {
      assignCatList();
    });
    super.initState();
  }

  assignCatList() {
    controller.productCategoryList.assignAll(widget.productCategoryList);
    print("CALLIST : ${controller.productCategoryList.length}");
  }

  getBox() {
    HelpButton.getBox(ButtonKey.addProductKey).then((value) => {
          setState(() {
            showCaseTap = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    list = [];

    imageList = [];

    variationData.forEach((key, value) {
      if (variationData[key] != "") {
        list.add(variationData[key]);
        // File _variationImage;
        //print("variation key: ${variationData[key]}");
        imageList.add(null);
      }
    });
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: !adding
            ? Form(
                key: _formKey,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Row(
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
                                      'add_new_product'.tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE_DARK,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        icon: Icon(
                                          Icons.contact_support,
                                          size: 30,
                                          color: DEFAULT_BLUE,
                                        ),
                                        onPressed: () {
                                          final String url =
                                              "https://www.youtube.com/watch?v=TcpUBjeX0N4&list=PLO7C_xRyL47emWQfUcp2-djjzgdlPGcqS&index=5";
                                          final String title =
                                              "product_add_showcase".tr;
                                          HelpButton.setBox(
                                              ButtonKey.addProductKey);
                                          Navigator.of(context).push(
                                              TutorialOverlay(url, title));
                                        })
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 70.0,
                                  left: 15,
                                ),
                                child: Text(
                                  widget.shop.name,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                              ),
                              Obx(() => controller.quickAddEnable.value == true
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: 115, left: 15, right: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(QuickAddProduct());
                                        },
                                        child: Container(
                                          height: 50,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "quickly_add_product_from_our_product_list"
                                                    .tr,
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: DEFAULT_YELLOW_BG,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: DEFAULT_YELLOW_BG,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container())
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Product Name row
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
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
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
                                            fontFamily: 'Rubik',
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // price  row
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
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        cursorColor: DEFAULT_BLACK,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter product price';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          if (value != "") {
                                            price = double.parse(value);
                                          } else {
                                            price = 0;
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: "Product Price",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Cost Optional row
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
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextField(
                                        onChanged: (value) {
                                          if (value != "") {
                                            cost = double.parse(value);
                                          } else {
                                            cost = 0;
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: "Product Cost",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 8),
                            child: Text(
                              "please_provide_cost_of_making_purchasing_the_product_it_will_help_you_to_calculate_your_profit"
                                  .tr,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Rubik-VariableFont_wght",
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLUE_DARK,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15, top: 15),
                                  child: Text(
                                    "optional_not_given".tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Rubik-VariableFont_wght",
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLUE_DARK,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
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
                                                    controller, size);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 10,
                                                    top: 8),
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            selectedProductCategory ==
                                                                    null
                                                                ? "select_category"
                                                                    .tr
                                                                : selectedProductCategory
                                                                    .name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                              letterSpacing: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: Icon(Icons
                                                            .arrow_drop_down),
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
                                                  left: 10.0, right: 15),
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
                                                if (selectedProductCategory ==
                                                    null) {
                                                  _showMaterialDialog(
                                                      "Please select Product Category first");
                                                } else {
                                                  _showSubCategoryDialog(
                                                      selectedProductCategory,
                                                      size);
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 15,
                                                    top: 8),
                                                child: Container(
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            selectedSubCat ==
                                                                    null
                                                                ? "select_sub_category"
                                                                    .tr
                                                                : selectedSubCat
                                                                    .name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Rubik',
                                                              // fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: Icon(Icons
                                                            .arrow_drop_down),
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
                                ),
                              ],
                            ),
                          ),
                          // Total Stock Quantity row
                          Container(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15, top: 15),
                                  child: Text(
                                    "total_stock_quantity".tr,
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
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter stock quantity';
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          if (val != "") {
                                            stockQuantity = int.parse(val);
                                          } else {
                                            stockQuantity = 0;
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: "stock_quantity".tr,
                                          hintStyle: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.blueGrey,
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
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter product description';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          desc = value;
                                        },
                                        // keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: "description".tr,
                                          hintStyle: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.blueGrey,
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
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
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
                                              value: controller.isOnline.value,
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
                                      left: 15.0, right: 15, top: 10),
                                  child: Text(
                                    "add_a_suitable_product_image".tr,
                                    style: TextStyle(
                                      fontSize: 12,
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
                                      showPictureOptionDialogue(context);
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
                                      child: _image == null
                                          ? Icon(Icons.camera_alt)
                                          : Image(
                                              image: FileImage(_image),
                                            ),
                                    ),
                                  ),
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
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "vat_applicable_yes".tr,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily:
                                                  "Rubik-VariableFont_wght",
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE_DARK,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: FlutterSwitch(
                                            height: 25.0,
                                            width: 40.0,
                                            padding: 4.0,
                                            toggleSize: 20.0,
                                            borderRadius: 20.0,
                                            activeColor: Colors.black,
                                            value: vatApplicable,
                                            onToggle: (value) {
                                              setState(() {
                                                vatApplicable = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                vatApplicable
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15, top: 8),
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
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: TextFormField(
                                              cursorColor: DEFAULT_BLACK,
                                              onChanged: (val) {
                                                if (val != "") {
                                                  vatAmount = double.parse(val);
                                                } else {
                                                  vatAmount = 0;
                                                }
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
                                                          FontWeight.bold),
                                                ),
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintText: "VAT Amount",
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 8),
                            child: Text(
                              "please_specify_if_customers_should_pay_for_additional_vat"
                                  .tr,
                              style: TextStyle(
                                fontSize: 12,
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
                              "barcode".tr,
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
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: mainProductBarCode == null
                                  ? RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      onPressed: () {
                                        scanBarcodeNormal(100);
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
                                      color: Color(0xffFAC02E),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20, top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "barcode_added_for_this_product"
                                                    .tr),
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                scanBarcodeNormal(100);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 8),
                            child: Text(
                              "add_the_barcode_associated_with_the_product_by_pressing_scan_button"
                                  .tr,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Rubik-VariableFont_wght",
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLUE_DARK,
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isAdvanced = !isAdvanced;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Advanced Option",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Rubik-VariableFont_wght",
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                                Icon(
                                  isAdvanced
                                      ? Icons.arrow_drop_up_outlined
                                      : Icons.arrow_drop_down,
                                  color: DEFAULT_BLACK,
                                  size: 35,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          isAdvanced
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    left: 15,
                                    right: 15,
                                    bottom: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "product_attribute".tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: DEFAULT_BLACK,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                              icon: Icon(
                                                Icons.contact_support,
                                                size: 35,
                                                color: DEFAULT_BLUE,
                                              ),
                                              onPressed: () {
                                                controller.advancedShowCase();
                                                final String url =
                                                    "https://www.youtube.com/watch?v=nZAuWwnwu0g&list=PLO7C_xRyL47emWQfUcp2-djjzgdlPGcqS&index=7";
                                                final String title =
                                                    "attribute_showcase".tr;
                                                Navigator.of(context).push(
                                                    TutorialOverlay(
                                                        url, title));
                                              })
                                        ],
                                      ),
                                      attributeList.length != 0
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: attributeList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Container(
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        width: 0.5,
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 8.0,
                                                            right: 10,
                                                          ),
                                                          child: Text(
                                                            attributeList[index]
                                                                .name,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 10.0,
                                                          ),
                                                          child:
                                                              VerticalDivider(
                                                            color: Colors.black,
                                                            thickness: 0.7,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            attributeList[index]
                                                                .value),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Container(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          addAttribute(size);
                                        },
                                        child: Text(
                                          "add_more_attribute_value".tr,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLUE,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      /*Row(
                                        children: [
                                          Text(
                                            "product_variation".tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: DEFAULT_BLACK,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                              icon: Icon(
                                                Icons.contact_support,
                                                size: 30,
                                                color: DEFAULT_BLUE,
                                              ),
                                              onPressed: () {
                                                final String url =
                                                    "https://www.youtube.com/watch?v=TcpUBjeX0N4&list=PLO7C_xRyL47emWQfUcp2-djjzgdlPGcqS&index=5";
                                                final String title =
                                                    "product_add_showcase".tr;
                                                Navigator.of(context).push(
                                                    TutorialOverlay(url, title));
                                              })
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(
                                                0,
                                                3,
                                              ), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            addVariation(size, variationData);
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "variation".tr,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(),
                                              Expanded(
                                                child: Text(
                                                    "Tap to add Product Variation"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "add_product_variation_if_any_many_product_has_variation_for_which_price_differ_for_example_a_mobile_phone_has_a_2_gb_version_and_a_3_gb_version_or_a_shampoo_has_500ml_bottle_and_1000ml_bottle_specify_if_the_product_has_such_variation"
                                            .tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: DEFAULT_BLACK,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      list.length != 0
                                          ? ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: list.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Variation:  $variationName ${list[index]}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Text(
                                                        "Add an image of specific product variation",
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 14,
                                                          // fontWeight: FontWeight.bold,
                                                          color: DEFAULT_BLACK,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 10,
                                                              bottom: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showPictureOptionDialogue(
                                                              context);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                              Radius.circular(5),
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey
                                                                    .withOpacity(
                                                                        1),
                                                                spreadRadius: 1,
                                                                blurRadius: 5,
                                                                offset: Offset(
                                                                  0,
                                                                  3,
                                                                ), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          height: 60,
                                                          width: 60,
                                                          child:
                                                              imageMap[index] ==
                                                                      null
                                                                  ? Icon(Icons
                                                                      .camera_alt)
                                                                  : Image(
                                                                      image: FileImage(
                                                                          imageMap[
                                                                              index]),
                                                                    ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // width: size.width / 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: Text(
                                                              "price".tr,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLACK,
                                                                letterSpacing: 0,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.all(8),
                                                            height: 48,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  width: 0.1,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 15.0),
                                                              child:
                                                                  TextFormField(
                                                                onChanged:
                                                                    (value) {
                                                                  variationDataModel[
                                                                          "$index/price"] =
                                                                      value;
                                                                },
                                                                initialValue:
                                                                    price != null
                                                                        ? price
                                                                            .toString()
                                                                        : "",
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly
                                                                ],
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  focusedBorder:
                                                                      InputBorder
                                                                          .none,
                                                                  enabledBorder:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Product Price",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    color: Colors
                                                                        .blueGrey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Cost Optional row
                                                    Container(
                                                      // width: size.width / 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: Text(
                                                              "cost_optional".tr,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLACK,
                                                                letterSpacing: 0,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.all(8),
                                                            height: 48,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  width: 0.1,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 15.0),
                                                              child:
                                                                  TextFormField(
                                                                onChanged:
                                                                    (value) {
                                                                  variationDataModel[
                                                                          "$index/cost"] =
                                                                      value;
                                                                },
                                                                initialValue: cost !=
                                                                        null
                                                                    ? cost
                                                                        .toString()
                                                                    : "",
                                                                // initialValue: ,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  focusedBorder:
                                                                      InputBorder
                                                                          .none,
                                                                  enabledBorder:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Product Cost",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    color: Colors
                                                                        .blueGrey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // width: size.width / 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: Text(
                                                              "Product Stock Quantity",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLACK,
                                                                letterSpacing: 0,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.all(8),
                                                            height: 48,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  width: 0.1,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 15.0),
                                                              child:
                                                                  TextFormField(
                                                                onChanged:
                                                                    (value) {
                                                                  variationDataModel[
                                                                          "$index/stock"] =
                                                                      value;
                                                                },
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  focusedBorder:
                                                                      InputBorder
                                                                          .none,
                                                                  enabledBorder:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "stock_quantity"
                                                                          .tr,
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    color: Colors
                                                                        .blueGrey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                        height: 48,
                                                        child: variationDataModel[
                                                                    "$index/barcode"] ==
                                                                null
                                                            ? RaisedButton(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                onPressed: () {
                                                                  scanBarcodeNormalVariation(
                                                                      index);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image(
                                                                      height: 20,
                                                                      image: AssetImage(
                                                                          'images/icons/scanIcon.png'),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    Text(
                                                                      'Scan',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Rubik',
                                                                        // fontSize: 28,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        // color: default_blue,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                color: Color(
                                                                    0xffFAC02E),
                                                              )
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black12,
                                                                  border: Border
                                                                      .all(),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text("barcode_added_for_this_product"
                                                                          .tr),
                                                                      IconButton(
                                                                        icon: Icon(
                                                                            Icons
                                                                                .edit),
                                                                        onPressed:
                                                                            () {
                                                                          scanBarcodeNormalVariation(
                                                                              index);
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    // Padding(
                                                    //   padding:
                                                    //       const EdgeInsets.all(10.0),
                                                    //   child: Container(
                                                    //     width: MediaQuery.of(context)
                                                    //         .size
                                                    //         .width,
                                                    //     height: 48,
                                                    //     child: RaisedButton(
                                                    //       shape: RoundedRectangleBorder(
                                                    //         borderRadius:
                                                    //             BorderRadius.circular(
                                                    //                 8.0),
                                                    //       ),
                                                    //       onPressed: () {
                                                    //         scanBarcodeNormalVariation(
                                                    //             index);
                                                    //       },
                                                    //       child: Row(
                                                    //         mainAxisAlignment:
                                                    //             MainAxisAlignment
                                                    //                 .center,
                                                    //         children: [
                                                    //           Image(
                                                    //             height: 20,
                                                    //             image: AssetImage(
                                                    //                 'images/icons/scanIcon.png'),
                                                    //           ),
                                                    //           SizedBox(width: 10),
                                                    //           Text(
                                                    //             'Scan',
                                                    //             style: TextStyle(
                                                    //               fontFamily: 'Rubik',
                                                    //               // fontSize: 28,
                                                    //               fontWeight:
                                                    //                   FontWeight.bold,
                                                    //               // color: default_blue,
                                                    //             ),
                                                    //           )
                                                    //         ],
                                                    //       ),
                                                    //       color: Color(0xffFAC02E),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Text(
                                                        "add_the_barcode_associated_with_the_product_by_pressing_scan_button"
                                                            .tr,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: DEFAULT_BLACK,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : Container(),*/
                                    ],
                                  ),
                                )
                              : Container(),

                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 15,
                              right: 15,
                              bottom: 20,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4)),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: () {
                                  saveProduct();
                                },
                                child: Text(
                                  "save".tr,
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
                      showCaseTap == null
                          ? Positioned(
                              right: 60,
                              top: 30,
                              child: Obx(
                                () => OpacityAnimatedWidget.tween(
                                  opacityEnabled: 1, //define start value
                                  opacityDisabled: 0, //and end value
                                  enabled: controller.showCase.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: DEFAULT_BLACK,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "product_add_showcase".tr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 30),
                    Text(
                      "Adding product Information",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  _showMaterialDialog(String data) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        content: new Text(data),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  _showCategoryDialog(AddProductController controller, Size size) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => KeyboardAwareDialog(
        child: Column(
          children: [
            Container(
              height: size.height * 0.8,
              width: size.width / 1.5,
              child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Product Category",
                          style: TextStyle(
                            color: DEFAULT_BLACK,
                            fontSize: 16,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          controller.searchCategory(value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: size.height * 0.75,
                        width: size.width / 1.5,
                        child: Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                controller.searchProductCategoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedProductCategory = controller
                                        .searchProductCategoryList[index];
                                    Navigator.pop(context);
                                    _showSubCategoryDialog(
                                        controller
                                            .searchProductCategoryList[index],
                                        size);
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          controller
                                              .searchProductCategoryList[index]
                                              .icon,
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            width: size.width / 2,
                                            child: Text(
                                              controller
                                                  .searchProductCategoryList[
                                                      index]
                                                  .name,
                                              style: TextStyle(
                                                  color: DEFAULT_BLACK,
                                                  fontWeight: FontWeight.bold,
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _showSubCategoryDialog(Category productCategoryList, Size size) {
    List<SubCategory> subCategoryList = productCategoryList.subCategory;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => KeyboardAwareDialog(
        child: Column(
          children: [
            Container(
              height: size.height * 0.8,
              width: size.width / 1.5,
              child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Product Sub Category",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: size.height * 0.7,
                        width: size.width / 1.5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: subCategoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSubCat = subCategoryList[index];
                                  Navigator.pop(context);
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subCategoryList[index].name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: DEFAULT_BLACK,
                                      fontWeight: FontWeight.bold,
                                    ),
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
            Container(
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: DEFAULT_BLACK,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TextButton(
                          child: Center(
                            child: Text(
                              'new_category'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                            Get.to(() => AddCategoryPage(),
                                binding: ProductListBinding());
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addAttribute(Size size) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size.width - 50,
              decoration: BoxDecoration(
                color: DEFAULT_BLUE,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  height: 50,
                  image: AssetImage("images/hishabeeLogo.png"),
                ),
              ),
            ),
            Container(
              width: size.width - 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Attributes",
                      style: TextStyle(
                        color: DEFAULT_BLUE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (val) {
                            attributeName = val;
                          },
                          decoration: InputDecoration(
                            hintText: "Brand/Weight/Size/Design etc",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Attribute Value",
                      style: TextStyle(
                        color: DEFAULT_BLUE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (val) {
                            attributeValue = val;
                          },
                          decoration: InputDecoration(
                            hintText:
                                "Brand: Samsung/ Weight: 12 gm/ Size: L etc",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.7,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: DEFAULT_BLUE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    "Done",
                    style: TextStyle(
                      color: DEFAULT_BLUE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (attributeName.length != 0 &&
                        attributeValue.length != 0) {
                      Attribute a =
                          Attribute(name: attributeName, value: attributeValue);
                      setState(() {
                        attributeList.add(a);
                      });
                    }
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  addVariation(Size size, Map varyData) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter _setState) {
            var listData = [];
            varyData.forEach((key, value) {
              if (varyData[key] != "") {
                listData.add(varyData[key]);
              }
            });
            return Container(
              height: size.height / 1.1,
              width: size.width / 1.5,
              child: ListView(
                children: [
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: size.width - 50,
                        decoration: BoxDecoration(
                          color: DEFAULT_BLUE,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            height: 50,
                            image: AssetImage("images/hishabeeLogo.png"),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Variation",
                                style: TextStyle(
                                  color: DEFAULT_BLUE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.4,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Variation",
                                        style: TextStyle(
                                          // color: default_blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 0.5,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              initialValue: attributeName,
                                              onChanged: (val) {
                                                setState(() {
                                                  variationName = val;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Size, Color etc",
                                                border: InputBorder.none,
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
                              varyData.length == 0
                                  ? Container(
                                      height: (size.height / 2) - 30,
                                      child: ListView.builder(
                                        itemCount: numberOfVariation,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Container(
                                              height: 55,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.black,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  // initialValue: varyData,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      variationData[index] =
                                                          val;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "color: red/blue or size: S/M/L etc",
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      height: (size.height / 2) - 30,
                                      child: ListView.builder(
                                        itemCount: numberOfVariation,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Container(
                                              height: 55,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.black,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  initialValue:
                                                      varyData[index] != null
                                                          ? varyData[index]
                                                          : "",
                                                  onChanged: (val) {
                                                    setState(() {
                                                      variationData[index] =
                                                          val;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "color: red/blue or size: S/M/L etc",
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              TextButton(
                                child: Text(
                                  "Add More Variation",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  _setState(() {
                                    numberOfVariation++;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 0.7,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: DEFAULT_BLUE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text(
                              "Done",
                              style: TextStyle(
                                color: DEFAULT_BLUE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              variationData.forEach((key, value) {
                                print(variationData[key]);
                              });
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // if this is i is 100 then it is set for the mainProductbarcode
  Future<void> scanBarcodeNormal(
    int i,
  ) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (i == 100) {
        mainProductBarCode = barcodeScanRes;
      } else {}
    });
  }

  Future<void> scanBarcodeNormalVariation(
    int index,
  ) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      variationDataModel["$index/barcode"] = barcodeScanRes;
    });
  }

  saveProduct() async {
    if (selectedProductCategory == null || selectedSubCat == null) {
      _showMaterialDialog("Please Select Category and Sub Category");
    } else {
      String atData = "{";
      for (Attribute a in attributeList) {
        atData = atData + " \"${a.name} \": \"${a.value}\", ";
      }
      atData = atData + "}";
      attributeMap = atData;
      sendProductInfo();
    }
  }

  sendProductInfo() async {
    if (selectedProductCategory == null || selectedSubCat == null) {
      _showMaterialDialog("Please Select Category and Sub Category");
    } else {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          adding = true;
        });
        bool costAvailable = cost == null ? false : true;
        bool barCodeAvailable = mainProductBarCode == null ? false : true;
        bool mainImageAvailable = mainImageUrl == null ? false : true;
        attributeAvailable = attributeMap == null ? false : true;
        vatApplicable = vatAmount == 0 ? false : true;
        mainImageAvailable ? mainImageUrl = mainImageUrl : mainImageUrl = null;
        barCodeAvailable
            ? mainProductBarCode = mainProductBarCode
            : mainProductBarCode = null;
        mainImageAvailable ? mainImageUrl = mainImageUrl : mainImageUrl = null;
        barCodeAvailable
            ? mainProductBarCode = mainProductBarCode
            : mainProductBarCode = null;
        attributeAvailable ? attributeMap = attributeMap : attributeMap = null;
        costAvailable ? cost = cost : cost = null;
        vatApplicable ? vatAmount = vatAmount : vatAmount = 0;

        try {
          final result = await controller.addProduct(
            shopId: widget.shop.id,
            subcategoryId: selectedSubCat.id,
            productName: productName,
            price: price,
            desc: desc,
            imageUrl: mainImageUrl,
            stockQuantity: stockQuantity,
            cost: cost,
            vatApplicable: vatApplicable,
            barcode: mainProductBarCode,
            attribute: attributeMap,
            vatAmount: vatAmount,
          );
          if (!isAdvanced) {
            setState(() {
              adding = false;
            });
          }
          if (result.message != null) {
            setState(() {
              adding = false;
            });
            CustomDialog.showDialogAddProductDialog(result.message);
          }
        } finally {}
        if (isAdvanced) {
          addVariantProducts();
        }
      }
    }
  }

  addVariantProducts() async {
    productName = savedProductName;
    for (int i = 0; i < list.length; i++) {
      productName = "($variationName : ${list[i]} )" + productName;
      if (variationDataModel["$i/price"] == null) {
        // print("Variation price is same as main price");
        priceI = price.toString();
      } else {
        // print("Variation price is ${variationDataModel["$i/price"]}");
        priceI = variationDataModel["$i/price"];
      }
      bool costAvailable = false;
      if (variationDataModel["$i/cost"] == null) {
        if (cost != null) {
          costAvailable = true;
          costI = cost;
        }
        // print("Variation cost is same as main price");
      } else {
        costAvailable = true;
        costI = double.parse(variationDataModel["$i/cost"]);
        // print("Variation cost is ${variationDataModel["$i/cost"]}");
      }

      if (variationDataModel["$i/stock"] == null) {
        stockI = stockQuantity;
        // print("Variation stock is same as main price");
      } else {
        stockI = int.parse(variationDataModel["$i/cost"]);
        // print("Variation stock is ${variationDataModel["$i/cost"]}");
      }
      bool barCodeAvailable = false;

      if (variationDataModel["$i/barcode"] == null) {
        if (mainProductBarCode != null) {
          barCodeAvailable = true;
          barcodeI = mainProductBarCode.toString();
        }
      } else {
        barCodeAvailable = true;
        barcodeI = variationDataModel["$i/barcode"];
        // print("Variation stock is ${variationDataModel["$i/barcode"]}");
      }

      if (imageUrl[i] == null) {
        if (mainImageUrl != null) {
          imageUrlI = mainImageUrl;
        }
      } else {
        imageUrlI = imageUrl[i];
      }

      try {
        imageUrlI != null ? imageUrlI = imageUrlI : imageUrlI = null;
        costAvailable ? costI = costI : costI = 0;
        barCodeAvailable ? barcodeI = barcodeI : barcodeI = null;
        attributeAvailable ? attributeMap = attributeMap : attributeMap = null;
        vatApplicable ? vatAmount = vatAmount : vatAmount = 0;
        final message = await controller.addProductWithAttribute(
          shopId: widget.shop.id,
          subcategoryId: selectedSubCat.id,
          productName: productName,
          price: price,
          desc: desc,
          // imageUrl: mainImageUrl,
          stockQuantity: stockI,
          cost: costI,
          vatApplicable: vatApplicable,
          barcode: barcodeI,
          attribute: attributeMap,
          vatAmount: vatAmount,
        );

        if (message != null) {
          CustomDialog.showStringDialog(message.message);
        }
        setState(() {
          adding = false;
        });
      } finally {
        //client.close();
      }
    }
  }

  showPictureOptionDialogue(BuildContext context) {
    final AddProductController controller = Get.find();
    Get.dialog(
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                ImageHelper.getImageFromCamera().then((value) {
                  controller.image.value = value;
                  navigator.pop();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
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
                  navigator.pop();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
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
      ),
    );
    /*showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
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
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
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
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        navigator.pop();
                      },
                    )
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
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
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
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
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        navigator.pop();
                      },
                    )
                  ],
                ));
      }*/
  }
}
