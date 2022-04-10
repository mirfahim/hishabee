import 'dart:convert';
import 'dart:io';

// import 'dart:io' as Io;

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
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
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/edit_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_details_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_list_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/quick_add_product.dart';
import 'package:hishabee_business_manager_fl/controllers/unit_list/unit_list_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../shop_main/domain/repositories/i_file_repository.dart';
import '../../data/remote/models/add_unit_model.dart';
import '../../data/remote/models/unit_list_model.dart';
import 'add_category_page.dart';

class EditProductShowcase extends StatelessWidget {
  final Shop shop;
  final List<Category> productCategoryList;

  EditProductShowcase({this.shop, this.productCategoryList});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
          builder: (context) => EditProductsPage(
                shop: shop,
                productCategoryList: productCategoryList,
              )),
      autoPlay: true,
      autoPlayDelay: Duration(seconds: 3),
      autoPlayLockEnable: true,
    );
  }
}

class EditProductsPage extends StatefulWidget {
  final Shop shop;
  final List<Category> productCategoryList;

  EditProductsPage({
    this.shop,
    this.productCategoryList,
  });

  @override
  _AddProductsPageState createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<EditProductsPage> {
  GlobalKey _addProductWalkThrough = GlobalKey();

  final AddProductController controller = Get.find();
  final ProductListController _productListController = Get.find();
  Category selectedProductCategory;
  SubCategory selectedSubCat;
  String _selectedUnit;
  String productName;
  String savedProductName;
  double price;
  double cost;
  double wholeSalePrice;
  int stockQuantity;
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
  UnitListController _unitListController = UnitListController();
  var list;
  List<dynamic> imageList;
  var unitList;
  // List<UnitList> _getAllUnit;
  final picker = ImagePicker();
  File _image;
  List<File> listFileImage = [];
  Map<int, File> imageMap = new Map();
  Map<int, String> imageUrl = new Map();
  String imageAPIURL;
  String imageAPI;

  String mainImageUrl;
  String attributeMap;
  bool adding = false;
  bool attributeAvailable = false;
  String _selectedUnitPopUp;
  // for variations
  String priceI;
  double costI;
  int stockI;
  String barcodeI;
  String imageUrlI;
  var showCaseTap;

  List<UnitList> _getAllUnit;
  @override
  void initState() {
    print("working 11111111");
    _unitListController.fetchAllUnit(userID: '1097').then((value) {
      _getAllUnit = getUnitFromModel(value);
      print(" my al unit length is ${_getAllUnit.length}");
    });

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

  String _selectedDropDownWarrenty = 'Days';
  String _selectedDropDownDiscount = '৳';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController _warrentyTextEditingController =
        new TextEditingController();
    var items = ['Days', 'Month', 'Year'];
    var itemDiscount = ['৳', '%'];
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
        child: !adding
            ? Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      // Container(
                      //   height: size.height * 0.2,
                      //   width: size.width,
                      //   child: Image.asset(
                      //     "images/topBg.png",
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //     top: 70.0,
                            //   ),
                            //   child: Text(
                            //     widget.shop.name,
                            //     style: TextStyle(
                            //       fontFamily: 'Rubik',
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.w600,
                            //       color: DEFAULT_BLUE,
                            //     ),
                            //   ),
                            // ),
                            // Obx(() => controller.quickAddEnable.value == true
                            //     ? Padding(
                            //         padding: EdgeInsets.only(
                            //             top: 115, left: 15, right: 15),
                            //         child: GestureDetector(
                            //           onTap: () {
                            //             Get.to(QuickAddProduct());
                            //           },
                            //           child: Container(
                            //             height: 50,
                            //             width: size.width,
                            //             decoration: BoxDecoration(
                            //               color: Colors.blueGrey,
                            //               borderRadius:
                            //                   BorderRadius.circular(8),
                            //             ),
                            //             child: Row(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.center,
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               children: [
                            //                 Text(
                            //                   "quickly_add_product_from_our_product_list"
                            //                       .tr,
                            //                   style: TextStyle(
                            //                     fontFamily: 'Rubik',
                            //                     fontSize: 12,
                            //                     fontWeight: FontWeight.w600,
                            //                     color: DEFAULT_YELLOW_BG,
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   width: 10,
                            //                 ),
                            //                 Icon(
                            //                   Icons.arrow_forward_ios,
                            //                   color: DEFAULT_YELLOW_BG,
                            //                   size: 12,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : Container()),
                            SizedBox(
                              height: 20,
                            ),
                            // Product Name row
                            Container(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF1F1F1),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'edit_product'.tr,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE_DARK,
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward_ios,
                                              size: 16)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'or_add_as_usual_product'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Roboto', fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF1F1F1),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    width: 1,
                                                    color: Colors.grey),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
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
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLUE_DARK,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Container(
                                                      height: 48,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Colors.grey),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0),
                                                        child: TextFormField(
                                                          cursorColor:
                                                              DEFAULT_BLACK,
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return 'Please enter product price';
                                                            }
                                                            return null;
                                                          },
                                                          onChanged: (value) {
                                                            if (value != "") {
                                                              price =
                                                                  double.parse(
                                                                      value);
                                                            } else {
                                                              price = 0;
                                                            }
                                                          },
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            hintText:
                                                                "Product Price",
                                                            hintStyle: TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: Colors
                                                                    .blueGrey,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLUE_DARK,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Container(
                                                      height: 48,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Colors.grey),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0),
                                                        child: TextFormField(
                                                          // validator: (value) {
                                                          //   if (value.isEmpty) {
                                                          //     return 'Please enter stock quantity';
                                                          //   }
                                                          //   return null;
                                                          // },
                                                          onChanged: (val) {
                                                            if (val != "") {
                                                              stockQuantity =
                                                                  int.parse(
                                                                      val);
                                                            } else {
                                                              stockQuantity = 0;
                                                            }
                                                          },
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
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
                                                            hintStyle: TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: Colors
                                                                    .blueGrey,
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
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                      'পন্যের স্টক সংখ্যা না দিলে ব্যবসার হিসাব সঠিক ভাবে দেখা যাবে না',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF185ADB),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          )
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
                                ],
                              ),
                            ),
                            // price  row

                            // SizedBox(height: 8),
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
                            // Total Stock Quantity row

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
                                        fontFamily: "Roboto",
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
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            hintText: "description".tr,
                                            hintStyle: TextStyle(
                                              fontFamily: 'Roboto',
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
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 15.0, right: 15, top: 8),
                                  //   child: Text(
                                  //     "want_to_sell_online".tr,
                                  //     style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontFamily: "Rubik-VariableFont_wght",
                                  //       fontWeight: FontWeight.bold,
                                  //       color: DEFAULT_BLUE_DARK,
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5, top: 8),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (isOnline == false) {
                                            controller.isOnline.value = true;
                                            isOnline = true;
                                          } else {
                                            controller.isOnline.value = false;
                                            isOnline = false;
                                          }
                                        });
                                      },
                                      child: Container(
                                        // height: 48,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF1F1F1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text(
                                                      // controller.isOnline.value
                                                      //     ? "ONLINE"
                                                      //     : "OFFLINE",
                                                      'want_to_sell_online'.tr,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            DEFAULT_BLUE_DARK,
                                                      ),
                                                    ),
                                                    // Obx(
                                                    //   () =>
                                                    // ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Obx(
                                                      () => FlutterSwitch(
                                                        height: 25.0,
                                                        width: 40.0,
                                                        padding: 4.0,
                                                        toggleSize: 20.0,
                                                        borderRadius: 20.0,
                                                        inactiveColor:
                                                            Colors.black,
                                                        activeColor:
                                                            Color(0xFF185ADB),
                                                        value: controller
                                                            .isOnline.value,
                                                        onToggle: (value) {
                                                          controller.isOnline
                                                              .value = value;
                                                          setState(() {
                                                            isOnline = value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              isOnline
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0),
                                                      child: Container(
                                                        child: Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10.0),
                                                                child: Text(
                                                                  'delivery_charge'
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          'Roboto'),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                  height: 48,
                                                                  child:
                                                                      TextFormField(
                                                                    // onChanged: (val) {
                                                                    //   if (val != "") {
                                                                    //     stockQuantity = int.parse(val);
                                                                    //   } else {
                                                                    //     stockQuantity = 0;
                                                                    //   }
                                                                    // },
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly
                                                                    ],
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      border: new OutlineInputBorder(
                                                                          borderSide:
                                                                              new BorderSide(color: Color(0xFFC4C4C4))),
                                                                      focusedBorder: new OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          borderSide:
                                                                              new BorderSide(color: Color(0xFFC4C4C4))),
                                                                      enabledBorder: new OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          borderSide:
                                                                              new BorderSide(color: Color(0xFFC4C4C4))),
                                                                      hintText:
                                                                          "delivery_charge"
                                                                              .tr,
                                                                      hintStyle: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color: Colors
                                                                              .blueGrey,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isAdvanced = !isAdvanced;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "advance_options".tr,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF185ADB),
                                          ),
                                        ),
                                        Icon(
                                          isAdvanced
                                              ? Icons.keyboard_arrow_up_outlined
                                              : Icons
                                                  .keyboard_arrow_down_outlined,
                                          color: Color(0xFF185ADB),
                                          size: 35,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            isAdvanced
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      top: 0.0,
                                      left: 5,
                                      right: 5,
                                      bottom: 20,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF1F1F1),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
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
                                                                    left: 5.0,
                                                                    right: 5),
                                                            child: Text(
                                                              "category".tr,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLUE_DARK,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              _showCategoryDialog(
                                                                  controller,
                                                                  size);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5.0,
                                                                      right: 5,
                                                                      top: 8),
                                                              child: Container(
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 15.0),
                                                                        child:
                                                                            Text(
                                                                          selectedProductCategory == null
                                                                              ? "select_category".tr
                                                                              : selectedProductCategory.name,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            letterSpacing:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              8.0),
                                                                      child: Icon(
                                                                          Icons
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
                                                  ),
                                                  Expanded(
                                                    child: Container(
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
                                                                    left: 5.0,
                                                                    right: 5),
                                                            child: Text(
                                                              "sub_category".tr,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLUE_DARK,
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
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5.0,
                                                                      right: 5,
                                                                      top: 8),
                                                              child: Container(
                                                                height: 48,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 15.0),
                                                                        child:
                                                                            Text(
                                                                          selectedSubCat == null
                                                                              ? "select_sub_category".tr
                                                                              : selectedSubCat.name,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            // fontSize: 18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              8.0),
                                                                      child: Icon(
                                                                          Icons
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFC4C4C4),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'product_unit'.tr,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              DEFAULT_BLUE_DARK,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Container(
                                                            height: 48,
                                                            child:
                                                                TextFormField(
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
                                                              ],
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                suffixIcon:
                                                                    PopupMenuButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Color(
                                                                        0xFF707070),
                                                                  ),
                                                                  itemBuilder: (context) =>
                                                                      _getAllUnit
                                                                          .map((e) =>
                                                                              PopupMenuItem(
                                                                                child: Text(e.name),
                                                                                value: e.name,
                                                                              ))
                                                                          .toList(),
                                                                  onSelected:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _selectedUnit =
                                                                          value;
                                                                      print(
                                                                          "my selected unit is $_selectedUnit");
                                                                    });
                                                                  },
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                border: new OutlineInputBorder(
                                                                    borderSide:
                                                                        new BorderSide(
                                                                            color:
                                                                                Color(0xFFC4C4C4))),
                                                                focusedBorder: new OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        new BorderSide(
                                                                            color:
                                                                                Color(0xFFC4C4C4))),
                                                                enabledBorder: new OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        new BorderSide(
                                                                            color:
                                                                                Color(0xFFC4C4C4))),
                                                                hintText: _selectedUnit ==
                                                                        null
                                                                    ? "product_unit"
                                                                        .tr
                                                                    : _selectedUnit,
                                                                hintStyle: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (isRetail ==
                                                                false) {
                                                              controller
                                                                  .isRetail
                                                                  .value = true;
                                                              isRetail = true;
                                                            } else {
                                                              controller
                                                                      .isRetail
                                                                      .value =
                                                                  false;
                                                              isRetail = false;
                                                            }
                                                          });
                                                        },
                                                        //asdasd
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xFFC4C4C4),
                                                                  width: 1)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'want_to_sell_retail'
                                                                    .tr,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      DEFAULT_BLUE_DARK,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10.0),
                                                                child: Obx(
                                                                  () =>
                                                                      FlutterSwitch(
                                                                    height:
                                                                        25.0,
                                                                    width: 40.0,
                                                                    padding:
                                                                        4.0,
                                                                    toggleSize:
                                                                        20.0,
                                                                    borderRadius:
                                                                        20.0,
                                                                    inactiveColor:
                                                                        Colors
                                                                            .black,
                                                                    activeColor:
                                                                        Color(
                                                                            0xFF185ADB),
                                                                    value: controller
                                                                        .isRetail
                                                                        .value,
                                                                    onToggle:
                                                                        (valueStock) {
                                                                      // controller
                                                                      //     .isRetail
                                                                      //     .value =
                                                                      //     valueStock;
                                                                      // setState(
                                                                      //         () {
                                                                      //           isRetail =
                                                                      //           valueStock;
                                                                      //     });
                                                                      showModalBottomSheet<
                                                                          void>(
                                                                        // context and builder are
                                                                        // required properties in this widget
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          // we set up a container inside which
                                                                          // we create center column and display text
                                                                          return StatefulBuilder(builder:
                                                                              (context, setState) {
                                                                            return Container(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                                                                                child: Expanded(
                                                                                  child: Column(
                                                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        height: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFF185ADB),
                                                                                          borderRadius: BorderRadius.circular(6),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                'how_to_add_retail_type'.tr,
                                                                                                style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Roboto'),
                                                                                              ),
                                                                                              InkWell(onTap: () {}, child: Image.asset('images/assets/youtube.png'))
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Container(
                                                                                        decoration: BoxDecoration(color: Color(0xFFC4C4C4).withOpacity(.35), borderRadius: BorderRadius.circular(6)),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                'select_retail_unit'.tr,
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                  fontFamily: 'Roboto',
                                                                                                ),
                                                                                              ),
                                                                                              InkWell(
                                                                                                onTap: () {},
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                                  child: Container(
                                                                                                    height: 48,
                                                                                                    child: TextFormField(
                                                                                                      onChanged: (value) {
                                                                                                        setState(() {
                                                                                                          _selectedUnitPopUp = value;
                                                                                                        });
                                                                                                      },
                                                                                                      inputFormatters: [
                                                                                                        FilteringTextInputFormatter.digitsOnly
                                                                                                      ],
                                                                                                      //controller: ,
                                                                                                      keyboardType: TextInputType.number,
                                                                                                      decoration: InputDecoration(
                                                                                                        suffixIcon: PopupMenuButton(
                                                                                                          icon: Icon(
                                                                                                            Icons.arrow_drop_down,
                                                                                                            color: Color(0xFF707070),
                                                                                                          ),
                                                                                                          itemBuilder: (context) => _getAllUnit
                                                                                                              .map((e) => PopupMenuItem(
                                                                                                                    child: Text(e.name),
                                                                                                                    value: e.name,
                                                                                                                  ))
                                                                                                              .toList(),
                                                                                                          onSelected: (value) {
                                                                                                            setState(() {
                                                                                                              _selectedUnitPopUp = value;
                                                                                                            });
                                                                                                          },
                                                                                                        ),
                                                                                                        filled: true,
                                                                                                        fillColor: Colors.white,
                                                                                                        border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                        focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                        enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                        hintText: _selectedUnitPopUp == null ? "product_unit".tr : _selectedUnitPopUp,
                                                                                                        hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              Text(
                                                                                                'select_retails_price_amount'.tr,
                                                                                                style: TextStyle(fontSize: 12, fontFamily: 'Roboto', fontWeight: FontWeight.w500),
                                                                                              ),
                                                                                              Text(
                                                                                                'example_of_retail'.tr,
                                                                                                style: TextStyle(fontSize: 12, fontFamily: 'Roboto', color: Color(0xFF707070)),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Container(
                                                                                                      height: 48,
                                                                                                      child: TextFormField(
                                                                                                        // onChanged: (val) {
                                                                                                        //   if (val != "") {
                                                                                                        //     stockQuantity = int.parse(val);
                                                                                                        //   } else {
                                                                                                        //     stockQuantity = 0;
                                                                                                        //   }
                                                                                                        // },
                                                                                                        inputFormatters: [
                                                                                                          FilteringTextInputFormatter.digitsOnly
                                                                                                        ],
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        decoration: InputDecoration(
                                                                                                          filled: true,
                                                                                                          fillColor: Colors.white,
                                                                                                          border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          hintText: "1 feet".tr,
                                                                                                          hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Text(
                                                                                                      '=',
                                                                                                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Container(
                                                                                                      height: 48,
                                                                                                      child: TextFormField(
                                                                                                        // onChanged: (val) {
                                                                                                        //   if (val != "") {
                                                                                                        //     stockQuantity = int.parse(val);
                                                                                                        //   } else {
                                                                                                        //     stockQuantity = 0;
                                                                                                        //   }
                                                                                                        // },
                                                                                                        onChanged: (val) {
                                                                                                          unitPrice = val;
                                                                                                        },
                                                                                                        inputFormatters: [
                                                                                                          FilteringTextInputFormatter.digitsOnly
                                                                                                        ],
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        decoration: InputDecoration(
                                                                                                          filled: true,
                                                                                                          fillColor: Colors.white,
                                                                                                          border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          hintText: "amount_porimap".tr,
                                                                                                          hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                                    child: Text(
                                                                                                      'meter'.tr,
                                                                                                      style: TextStyle(color: Color(0xFF979797), fontWeight: FontWeight.w400, fontSize: 12),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              Text(
                                                                                                'select_retails_price_price'.tr,
                                                                                                style: TextStyle(fontSize: 12, fontFamily: 'Roboto', fontWeight: FontWeight.w500),
                                                                                              ),
                                                                                              Text(
                                                                                                'example_of_retail'.tr,
                                                                                                style: TextStyle(fontSize: 12, fontFamily: 'Roboto', color: Color(0xFF707070)),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Container(
                                                                                                      height: 48,
                                                                                                      child: TextFormField(
                                                                                                        // onChanged: (val) {
                                                                                                        //   if (val != "") {
                                                                                                        //     stockQuantity = int.parse(val);
                                                                                                        //   } else {
                                                                                                        //     stockQuantity = 0;
                                                                                                        //   }
                                                                                                        // },
                                                                                                        inputFormatters: [
                                                                                                          FilteringTextInputFormatter.digitsOnly
                                                                                                        ],
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        decoration: InputDecoration(
                                                                                                          filled: true,
                                                                                                          fillColor: Colors.white,
                                                                                                          border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          hintText: "1 feet".tr,
                                                                                                          hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Text(
                                                                                                      '=',
                                                                                                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Container(
                                                                                                      height: 48,
                                                                                                      child: TextFormField(
                                                                                                        // onChanged: (val) {
                                                                                                        //   if (val != "") {
                                                                                                        //     stockQuantity = int.parse(val);
                                                                                                        //   } else {
                                                                                                        //     stockQuantity = 0;
                                                                                                        //   }
                                                                                                        // },
                                                                                                        onChanged: (val) {
                                                                                                          wholeSalePrice = double.parse(val);
                                                                                                        },
                                                                                                        inputFormatters: [
                                                                                                          FilteringTextInputFormatter.digitsOnly
                                                                                                        ],
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        decoration: InputDecoration(
                                                                                                          filled: true,
                                                                                                          fillColor: Colors.white,
                                                                                                          border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                                          hintText: "write_amount".tr,
                                                                                                          hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                                    child: Text(
                                                                                                      '৳',
                                                                                                      style: TextStyle(color: Color(0xFF979797), fontWeight: FontWeight.w400, fontSize: 12),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(height: 10)
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(height: 10),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          ElevatedButton(
                                                                                            onPressed: () {},
                                                                                            child: Text(
                                                                                              'delete'.tr,
                                                                                              style: TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.w500),
                                                                                            ),
                                                                                            style: ElevatedButton.styleFrom(primary: Color(0xFFFF0000)),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 15,
                                                                                          ),
                                                                                          ElevatedButton(
                                                                                            onPressed: () {},
                                                                                            child: Text(
                                                                                              'save'.tr,
                                                                                              style: TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.w500),
                                                                                            ),
                                                                                            style: ElevatedButton.styleFrom(primary: Color(0xFF669E4F)),
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          });
                                                                        },
                                                                      );
                                                                      // if(valueStock){
                                                                      //
                                                                      //
                                                                      // }else{
                                                                      //   isStockAlert = false;
                                                                      // }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      isRetail
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 10.0),
                                                                            child:
                                                                                Text(
                                                                              'whole_sale_rate'.tr,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              height: 48,
                                                                              child: TextFormField(
                                                                                // onChanged: (val) {
                                                                                //   if (val != "") {
                                                                                //     stockQuantity = int.parse(val);
                                                                                //   } else {
                                                                                //     stockQuantity = 0;
                                                                                //   }
                                                                                // },
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.digitsOnly
                                                                                ],
                                                                                keyboardType: TextInputType.number,
                                                                                decoration: InputDecoration(
                                                                                  filled: true,
                                                                                  fillColor: Colors.white,
                                                                                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  hintText: "whole_sale_rate".tr,
                                                                                  hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 10.0),
                                                                            child:
                                                                                Text(
                                                                              'whole_sale_count'.tr,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              height: 48,
                                                                              child: TextFormField(
                                                                                // onChanged: (val) {
                                                                                //   if (val != "") {
                                                                                //     stockQuantity = int.parse(val);
                                                                                //   } else {
                                                                                //     stockQuantity = 0;
                                                                                //   }
                                                                                // },
                                                                                onChanged: (val) {
                                                                                  wholeSalePrice = double.parse(val);
                                                                                },
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.digitsOnly
                                                                                ],
                                                                                keyboardType: TextInputType.number,
                                                                                decoration: InputDecoration(
                                                                                  filled: true,
                                                                                  fillColor: Colors.white,
                                                                                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  hintText: "whole_sale_count".tr,
                                                                                  hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFC4C4C4),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (isWholeSale ==
                                                                false) {
                                                              controller
                                                                  .isWholeSale
                                                                  .value = true;
                                                              isWholeSale =
                                                                  true;
                                                            } else {
                                                              controller
                                                                  .isWholeSale
                                                                  .value = false;
                                                              isWholeSale =
                                                                  false;
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'want_to_sell_whole_sale'
                                                                  .tr,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLUE_DARK,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Obx(
                                                                () =>
                                                                    FlutterSwitch(
                                                                  height: 25.0,
                                                                  width: 40.0,
                                                                  padding: 4.0,
                                                                  toggleSize:
                                                                      20.0,
                                                                  borderRadius:
                                                                      20.0,
                                                                  inactiveColor:
                                                                      Colors
                                                                          .black,
                                                                  activeColor:
                                                                      Color(
                                                                          0xFF185ADB),
                                                                  value: controller
                                                                      .isWholeSale
                                                                      .value,
                                                                  onToggle:
                                                                      (valueStock) {
                                                                    controller
                                                                            .isWholeSale
                                                                            .value =
                                                                        valueStock;
                                                                    setState(
                                                                        () {
                                                                      isWholeSale =
                                                                          valueStock;
                                                                    });

                                                                    // if(valueStock){
                                                                    //
                                                                    //
                                                                    // }else{
                                                                    //   isStockAlert = false;
                                                                    // }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      isWholeSale
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 10.0),
                                                                            child:
                                                                                Text(
                                                                              'whole_sale_rate'.tr,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              height: 48,
                                                                              child: TextFormField(
                                                                                // onChanged: (val) {
                                                                                //   if (val != "") {
                                                                                //     stockQuantity = int.parse(val);
                                                                                //   } else {
                                                                                //     stockQuantity = 0;
                                                                                //   }
                                                                                // },
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.digitsOnly
                                                                                ],
                                                                                keyboardType: TextInputType.number,
                                                                                decoration: InputDecoration(
                                                                                  filled: true,
                                                                                  fillColor: Colors.white,
                                                                                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  hintText: "whole_sale_rate".tr,
                                                                                  hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 10.0),
                                                                            child:
                                                                                Text(
                                                                              'whole_sale_count'.tr,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              height: 48,
                                                                              child: TextFormField(
                                                                                // onChanged: (val) {
                                                                                //   if (val != "") {
                                                                                //     stockQuantity = int.parse(val);
                                                                                //   } else {
                                                                                //     stockQuantity = 0;
                                                                                //   }
                                                                                // },
                                                                                onChanged: (val) {
                                                                                  wholeSalePrice = double.parse(val);
                                                                                },
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.digitsOnly
                                                                                ],
                                                                                keyboardType: TextInputType.number,
                                                                                decoration: InputDecoration(
                                                                                  filled: true,
                                                                                  fillColor: Colors.white,
                                                                                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                  hintText: "whole_sale_count".tr,
                                                                                  hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFC4C4C4),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (isStockAlert ==
                                                                false) {
                                                              controller
                                                                  .isStockAlert
                                                                  .value = true;
                                                              isStockAlert =
                                                                  true;
                                                            } else {
                                                              controller
                                                                  .isStockAlert
                                                                  .value = false;
                                                              isStockAlert =
                                                                  false;
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'want_to_have_alert_of_stock_empty'
                                                                  .tr,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLUE_DARK,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Obx(
                                                                () =>
                                                                    FlutterSwitch(
                                                                  height: 25.0,
                                                                  width: 40.0,
                                                                  padding: 4.0,
                                                                  toggleSize:
                                                                      20.0,
                                                                  borderRadius:
                                                                      20.0,
                                                                  inactiveColor:
                                                                      Colors
                                                                          .black,
                                                                  activeColor:
                                                                      Color(
                                                                          0xFF185ADB),
                                                                  value: controller
                                                                      .isStockAlert
                                                                      .value,
                                                                  onToggle:
                                                                      (valueStock) {
                                                                    controller
                                                                            .isStockAlert
                                                                            .value =
                                                                        valueStock;
                                                                    setState(
                                                                        () {
                                                                      isStockAlert =
                                                                          valueStock;
                                                                    });

                                                                    // if(valueStock){
                                                                    //
                                                                    //
                                                                    // }else{
                                                                    //   isStockAlert = false;
                                                                    // }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      isStockAlert
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                              child: Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'সর্বনিম্ন স্টকের পরিমাণ',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          48,
                                                                      child:
                                                                          TextFormField(
                                                                        // onChanged: (val) {
                                                                        //   if (val != "") {
                                                                        //     stockQuantity = int.parse(val);
                                                                        //   } else {
                                                                        //     stockQuantity = 0;
                                                                        //   }
                                                                        // },
                                                                        inputFormatters: [
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly
                                                                        ],
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white,
                                                                          border:
                                                                              new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                          focusedBorder: new OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                          enabledBorder: new OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                          hintText:
                                                                              "stock_quantity".tr,
                                                                          hintStyle: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.blueGrey,
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFC4C4C4),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (isVat ==
                                                                false) {
                                                              controller.isVat
                                                                  .value = true;
                                                              isVat = true;
                                                            } else {
                                                              controller.isVat
                                                                      .value =
                                                                  false;
                                                              isVat = false;
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'vat'.tr,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLUE_DARK,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Obx(
                                                                () =>
                                                                    FlutterSwitch(
                                                                  height: 25.0,
                                                                  width: 40.0,
                                                                  padding: 4.0,
                                                                  toggleSize:
                                                                      20.0,
                                                                  borderRadius:
                                                                      20.0,
                                                                  inactiveColor:
                                                                      Colors
                                                                          .black,
                                                                  activeColor:
                                                                      Color(
                                                                          0xFF185ADB),
                                                                  value:
                                                                      controller
                                                                          .isVat
                                                                          .value,
                                                                  onToggle:
                                                                      (valueStock) {
                                                                    controller
                                                                            .isVat
                                                                            .value =
                                                                        valueStock;
                                                                    setState(
                                                                        () {
                                                                      isVat =
                                                                          valueStock;
                                                                    });

                                                                    // if(valueStock){
                                                                    //
                                                                    //
                                                                    // }else{
                                                                    //   isStockAlert = false;
                                                                    // }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      isVat
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 0.0),
                                                                            child:
                                                                                Text(
                                                                              'vat_amount'.tr,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                48,
                                                                            child:
                                                                                TextFormField(
                                                                              // onChanged: (val) {
                                                                              //   if (val != "") {
                                                                              //     stockQuantity = int.parse(val);
                                                                              //   } else {
                                                                              //     stockQuantity = 0;
                                                                              //   }
                                                                              // },
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.digitsOnly
                                                                              ],
                                                                              keyboardType: TextInputType.number,
                                                                              decoration: InputDecoration(
                                                                                filled: true,
                                                                                fillColor: Colors.white,
                                                                                border: new OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                hintText: "vat_amount".tr,
                                                                                hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.blueGrey, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFC4C4C4),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (isWarrenty ==
                                                                false) {
                                                              controller
                                                                  .isWarrenty
                                                                  .value = true;
                                                              isWarrenty = true;
                                                            } else {
                                                              controller
                                                                  .isWarrenty
                                                                  .value = false;
                                                              isWarrenty =
                                                                  false;
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'warranty'.tr,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLUE_DARK,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Obx(
                                                                () =>
                                                                    FlutterSwitch(
                                                                  height: 25.0,
                                                                  width: 40.0,
                                                                  padding: 4.0,
                                                                  toggleSize:
                                                                      20.0,
                                                                  borderRadius:
                                                                      20.0,
                                                                  inactiveColor:
                                                                      Colors
                                                                          .black,
                                                                  activeColor:
                                                                      Color(
                                                                          0xFF185ADB),
                                                                  value: controller
                                                                      .isWarrenty
                                                                      .value,
                                                                  onToggle:
                                                                      (valueStock) {
                                                                    controller
                                                                            .isWarrenty
                                                                            .value =
                                                                        valueStock;
                                                                    setState(
                                                                        () {
                                                                      isWarrenty =
                                                                          valueStock;
                                                                    });

                                                                    // if(valueStock){
                                                                    //
                                                                    //
                                                                    // }else{
                                                                    //   isStockAlert = false;
                                                                    // }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      isWarrenty
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                              child: Container(
                                                                child:
                                                                    new Column(
                                                                  children: [
                                                                    new Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              6.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 10.0),
                                                                            child:
                                                                                Text(
                                                                              'start_from_sell'.tr,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                          Spacer(),
                                                                          Container(
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                TextFormField(
                                                                              maxLines: 1,
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.digitsOnly
                                                                              ],
                                                                              keyboardType: TextInputType.number,
                                                                              decoration: InputDecoration(
                                                                                contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                                                                filled: true,
                                                                                fillColor: Colors.white,
                                                                                // border: new OutlineInputBorder(
                                                                                //
                                                                                //     borderSide: new BorderSide(color: Colors.black)
                                                                                // ),
                                                                                focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6), topRight: Radius.circular(0), bottomRight: Radius.circular(0)), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6), topRight: Radius.circular(0), bottomRight: Radius.circular(0)), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF185ADB),
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(0), bottomLeft: Radius.circular(0), topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                                                                            ),
                                                                            child:
                                                                                DropdownButton<String>(
                                                                              underline: SizedBox(),
                                                                              value: _selectedDropDownWarrenty,
                                                                              items: items.map<DropdownMenuItem<String>>((String value) {
                                                                                return DropdownMenuItem(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Text(value, style: TextStyle(color: Colors.black, fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.w500)),
                                                                                  ),
                                                                                  value: value,
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (String value) {
                                                                                setState(() {
                                                                                  _selectedDropDownWarrenty = value;
                                                                                });
                                                                                print('value changed item : ${value}');
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFC4C4C4),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (isDiscount ==
                                                                false) {
                                                              controller
                                                                  .isDiscount
                                                                  .value = true;
                                                              isDiscount = true;
                                                            } else {
                                                              controller
                                                                  .isDiscount
                                                                  .value = false;
                                                              isDiscount =
                                                                  false;
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'discount'.tr,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLUE_DARK,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Obx(
                                                                () =>
                                                                    FlutterSwitch(
                                                                  height: 25.0,
                                                                  width: 40.0,
                                                                  padding: 4.0,
                                                                  toggleSize:
                                                                      20.0,
                                                                  borderRadius:
                                                                      20.0,
                                                                  inactiveColor:
                                                                      Colors
                                                                          .black,
                                                                  activeColor:
                                                                      Color(
                                                                          0xFF185ADB),
                                                                  value: controller
                                                                      .isDiscount
                                                                      .value,
                                                                  onToggle:
                                                                      (valueStock) {
                                                                    controller
                                                                            .isDiscount
                                                                            .value =
                                                                        valueStock;
                                                                    setState(
                                                                        () {
                                                                      isDiscount =
                                                                          valueStock;
                                                                    });

                                                                    // if(valueStock){
                                                                    //
                                                                    //
                                                                    // }else{
                                                                    //   isStockAlert = false;
                                                                    // }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      isDiscount
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                              child: Container(
                                                                child:
                                                                    new Column(
                                                                  children: [
                                                                    new Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              6.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 10.0),
                                                                            child:
                                                                                Text(
                                                                              'amount_discount'.tr,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                          Spacer(),
                                                                          Container(
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                TextFormField(
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.digitsOnly
                                                                              ],
                                                                              keyboardType: TextInputType.number,
                                                                              decoration: InputDecoration(
                                                                                contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),

                                                                                filled: true,
                                                                                fillColor: Colors.white,
                                                                                // border: new OutlineInputBorder(
                                                                                //
                                                                                //     borderSide: new BorderSide(color: Colors.black)
                                                                                // ),
                                                                                focusedBorder: new OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6), topRight: Radius.circular(0), bottomRight: Radius.circular(0)), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                                enabledBorder: new OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6), topRight: Radius.circular(0), bottomRight: Radius.circular(0)), borderSide: new BorderSide(color: Color(0xFFC4C4C4))),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF185ADB),
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(0), bottomLeft: Radius.circular(0), topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                                                                            ),
                                                                            child:
                                                                                DropdownButton<String>(
                                                                              underline: SizedBox(),
                                                                              elevation: 0,
                                                                              value: _selectedDropDownDiscount,
                                                                              items: itemDiscount.map<DropdownMenuItem<String>>((String value) {
                                                                                return DropdownMenuItem(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Text(value, style: TextStyle(color: Colors.black, fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.w500)),
                                                                                  ),
                                                                                  value: value,
                                                                                  enabled: true,
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (String value) {
                                                                                setState(() {
                                                                                  _selectedDropDownDiscount = value;
                                                                                });
                                                                                print('value changed item : ${value}');
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'add_product_picture_max_5'.tr,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              showPictureOptionDialogue(
                                                                  context);
                                                            },
                                                            child: SvgPicture.asset(
                                                                'images/svg_image/empty-image.svg')),
                                                        SizedBox(width: 5),
                                                        Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF185ADB),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                onPressed: () {
                                                                  showPictureOptionDialogue(
                                                                      context);
                                                                },
                                                                icon: Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 30)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  mainProductBarCode == null
                                                      ? ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: Color(
                                                                      0xFF185ADB)),
                                                          onPressed: () {
                                                            scanBarcodeNormal(
                                                                100);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'images/svg_image/scanner_white.svg'),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(
                                                                  'scan_barcode'
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: Color(
                                                                      0xFF185ADB)),
                                                          onPressed: () {
                                                            scanBarcodeNormal(
                                                                100);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'images/svg_image/scanner_white.svg'),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(
                                                                  'Scan completed'
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                ]),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, left: 10.0),
                                              child: Center(
                                                child: Container(
                                                  height: 70,
                                                  width: 400,
                                                  child: ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: listFileImage
                                                              .length ??
                                                          0,
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Center(
                                                          child: Stack(
                                                              children: [
                                                                Container(
                                                                  height: 60,
                                                                  width: 60,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      color: Colors
                                                                          .grey,
                                                                      image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              FileImage(listFileImage[index]))),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          2,
                                                                          -1),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      print(
                                                                          "working 1");

                                                                      setState(
                                                                          () {
                                                                        listFileImage = List.from(
                                                                            listFileImage)
                                                                          ..removeAt(
                                                                              index);
                                                                      });

                                                                      print(listFileImage
                                                                          .length);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          20.0,
                                                                      height:
                                                                          20.0,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                color: Colors.black,
                                                                                offset: Offset(0, 1),
                                                                                blurRadius: 2),
                                                                          ],
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color:
                                                                              Colors.transparent),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                      primary: Color(0xFF185ADB)),
                                  onPressed: () {
                                    saveProduct();
                                  },
                                  child: Text(
                                    "save".tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
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
                            fontFamily: "Roboto",
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
                                                  fontFamily: "Roboto"),
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
                      // _productListController.getAllProduct();
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
                      _productListController.getAllProduct();
                      _productListController.getAllProduct();
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

    // If the widgets was removed from the tree while the asynchronous platform
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

  IFileRepository fileRepository;
  var image = Rxn<File>();
  String imageSrc;
  void addImageToList(File file) async {
    if (listFileImage.length == 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You can only add five images'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      setState(() {
        listFileImage.insert(0, file);
      });
    }
  }

  List<String> gallary = [];
  imagesFromApi(File file) async {
    print("image file path is ${file.path}");
    imageAPI =
        await fileRepository.uploadFile(file: image.value, type: 'product');
    imageSrc = imageAPI
        .replaceAll("\\", "")
        .replaceAll('"', "")
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAllMapped('url:', (match) => "");

    gallary.insert(0, imageSrc);
    print("my image url list is $gallary");
  }

  int versionIncrement = 1;
  // int version = 1;
  final ProductDetailsController _productController = Get.find();
  increment() {
    setState(() {
      versionIncrement = _productController.product.value.version++;
      //_productController.product.value.version = versionIncrement++;
      print(
          "my updated product increment is ${_productController.product.value.version}");
    });
  }

  saveProduct() async {
    // if (selectedProductCategory == null || selectedSubCat == null) {
    //   _showMaterialDialog("Please Select Category and Sub Category");
    // } else {
    // createUniqueID();
    increment();
    String atData = "{";
    for (Attribute a in attributeList) {
      atData = atData + " \"${a.name} \": \"${a.value}\", ";
    }
    _productListController.getAllProduct();
    atData = atData + "}";
    attributeMap = atData;
    sendProductInfo();
    _productListController.getAllProduct();
    // }
  }

  String uniqueID;
  createUniqueID() {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    uniqueID = widget.shop.id.toString() +
        widget.shop.userId.toString() +
        time.toString();
    print(" my unique ID is $uniqueID");
  }

  sendProductInfo() async {
    // if (selectedProductCategory == null || selectedSubCat == null) {
    //   _showMaterialDialog("Please Select Category and Sub Category");
    // }
    // else {

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
      unitList = <Map<String, String>>[
        {"sub_unit": _selectedUnit, "price": unitPrice}
      ];
      try {
        final result = await controller.addProduct(
          shopId: widget.shop.id,
          subcategoryId: selectedSubCat == null ? null : selectedSubCat.id,
          productName: productName,
          price: price,
          wholeSalePrice: wholeSalePrice,
          desc: desc,
          imageUrl: mainImageUrl,
          stockQuantity: stockQuantity,
          cost: cost,
          vatApplicable: vatApplicable,
          barcode: mainProductBarCode,
          attribute: attributeMap,
          vatAmount: vatAmount,
          uniqueID: _productController.product.value.uniqueId,
          gallary: imageList,
          subUnit: unitList,
          version: _productController.product.value.version,
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
    // }
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
          //imageUrl: mainImageUrl,
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
      Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  ImageHelper.getImageFromCamera().then((value) {
                    controller.image.value = value;
                    print(
                        "image path is +++++++++++++ ${controller.image.value.path}");
                    addImageToList(controller.image.value);
                    imagesFromApi(controller.image.value);
                    navigator.pop();
                  });
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image(
                            height: 80,
                            image: AssetImage('images/icons/camera.png'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Camera",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
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
                    addImageToList(controller.image.value);
                    imagesFromApi(controller.image.value);
                    navigator.pop();
                  });
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image(
                            height: 80,
                            image: AssetImage('images/icons/gallery.png'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Gallery",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
      ),
    );
  }
}
