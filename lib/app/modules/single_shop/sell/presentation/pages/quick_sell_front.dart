import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/calculator/views/pages/calculator_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/confirm_payment_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/sell_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_navigation/sell_page_route.dart';

// import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_navigation/sell_page_routs.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/tabs_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_cart_page.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_app_bar.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_left_menue.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';

import 'confirm_payment_page.dart';

class QuickSell extends GetView<SellController> {
  const QuickSell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _currentValue = 0;
    var _quickSellItem = [
      'Days', 'Month', 'Year'
    ];
    String _selectedDropDownWarrenty = 'Days';
    Size size = MediaQuery.of(context).size;
    final shopFeatureController = Get.find<ShopFeaturesController>();
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  'images/svg_image/help.svg',
                  height: 32,
                )),
          )
        ],
        title: Text(
          'quick_sell'.tr,
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
        // backgroundColor: DEFAULT_YELLOW_BG,
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: size.height + 30,
          // width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    InkWell(
                      onTap: () {
                        controller.sellType.value = 0;
                      },
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                              color: controller.sellType.value == 0
                                  ? DEFAULT_BLUE
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset('images/assets/quick_sell.png'),
                                Text(
                                  'quick_sell'.tr,
                                  style: TextStyle(
                                      color: controller.sellType.value == 1
                                          ? DEFAULT_BLUE
                                          : Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        controller.sellType.value = 1;
                      },
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                              color: controller.sellType.value == 1
                                  ? DEFAULT_BLUE
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 14, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset(
                                  'images/svg_image/product_details.svg',
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'product_list'.tr,
                                  style: TextStyle(
                                      color: controller.sellType.value == 0
                                          ? DEFAULT_BLUE
                                          : Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Obx(() => controller.sellType.value == 0
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: DEFAULT_BLACK,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SvgPicture.asset(
                                                      'images/svg_image/calender.svg'),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      DateFormat('dd MMMM')
                                                          .format(controller
                                                              .selectedStartDate
                                                              .value),
                                                      style: TextStyle(
                                                        color: DEFAULT_BLACK,
                                                        fontFamily: 'Roboto',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: InkWell(
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: DEFAULT_BLACK,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(9.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SvgPicture.asset(
                                                      'images/svg_image/receipt.svg'),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'picture'.tr,
                                                    style: TextStyle(
                                                      color: DEFAULT_BLACK,
                                                      fontFamily: 'Roboto',
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Card(

                                              // shape:  RoundedRectangleBorder(
                                              //   borderRadius: BorderRadius.circular(20.0),
                                              // ),
                                              // elevation: 5,
                                              // child: Container(
                                              //   decoration: BoxDecoration(
                                              //       color: Colors.white,
                                              //       // border: Border.all(
                                              //       //     color: DEFAULT_BLACK, width: 1),
                                              //       borderRadius: BorderRadius.circular(20)),
                                              //   child: Padding(
                                              //     padding: const EdgeInsets.all(8.0),
                                              //     child: Icon(Icons.add,color: Colors.black,)
                                              //   ),
                                              // ),

                                            child: DropdownButton<String>(

                                              value: _selectedDropDownWarrenty,
                                              items: _quickSellItem.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem(

                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Checkbox(value: false, onChanged: (checked){}),
                                                        SizedBox(width: 20),

                                                        Text(
                                                            value,
                                                            style: TextStyle(color: Colors.black,
                                                                fontFamily: 'Roboto',
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  value: value,

                                                );
                                              }).toList(),
                                              onChanged: (String value) {
                                                // setState(() {
                                                //   _selectedDropDownWarrenty = value;
                                                // });
                                                print('value changed item : ${value}');
                                              },

                                            ),
                                          )
                                          // Card(
                                          //   shape:  RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(20.0),
                                          //   ),
                                          //   elevation: 5,
                                          //   child: Container(
                                          //     decoration: BoxDecoration(
                                          //         color: Colors.white,
                                          //         // border: Border.all(
                                          //         //     color: DEFAULT_BLACK, width: 1),
                                          //         borderRadius: BorderRadius.circular(20)),
                                          //     child: Padding(
                                          //       padding: const EdgeInsets.all(8.0),
                                          //       child: Icon(Icons.add,color: Colors.black,)
                                          //     ),
                                          //   ),
                                          // ),
                                          // DropdownButton(
                                          //     items: [
                                          //       DropdownMenuItem(
                                          //         child: Row(
                                          //           children: [
                                          //             Checkbox(value: true, onChanged: (value){
                                          //
                                          //             }),
                                          //             Text('Free SMS')
                                          //           ],
                                          //         ),
                                          //       )], onChanged: (value){})
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                // controller: controller.amount.value,
                                onTap: () {
                                  CalcButton();
                                  // showModalBottomSheet(
                                  //     isScrollControlled: true,
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       return SizedBox(
                                  //           height: 300,
                                  //           child: CalcButton());
                                  //     });
                                },

                                showCursor: true,
                                readOnly: true,
                                onSaved: (value) {
                                  controller.amount.value = int.parse(value);
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Cash',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: DEFAULT_BLACK, width: 1),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                            ),
                            Obx(
                              () => controller.customerField.value
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          controller.customerPhone.value =
                                              value;
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        decoration: InputDecoration(
                                          labelText: 'Customer Mobile Number',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: DEFAULT_BLACK,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                            Obx(
                              () => controller.profitField.value
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          controller.profit.value =
                                              value.isEmpty
                                                  ? 0
                                                  : int.parse(value);
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        decoration: InputDecoration(
                                          labelText: 'Profit',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: DEFAULT_BLACK,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                onSaved: (value) {
                                  controller.productDetails.value = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Details About Product',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: DEFAULT_BLACK, width: 1),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.quickSell();
                              },
                              child: Center(
                                child: Text(
                                  'received'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: DEFAULT_BLUE,
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: DEFAULT_BLUE,
                                          size: 28,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Container(
                                              child: TextField(
                                                onChanged: (value) {
                                                  controller
                                                      .searchProduct(value);
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: VerticalDivider(
                                            thickness: 0.8,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: VerticalDivider(
                                            thickness: 0.8,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          // flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              _showCategoryDialog(
                                                  controller.categoryList,
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
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'Filter',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Rubik-VariableFont_wght',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLUE,
                                                    ),
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
                                Container(
                                  height: size.height - 260,
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.searchList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Product product =
                                              controller.searchList[
                                                  controller.searchList.length -
                                                      1 -
                                                      index];
                                          return InkWell(
                                            onTap: () {
                                              controller.animateButton();
                                              controller.addToCart(product);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                  left: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.grey),
                                                  right: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.grey),
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.grey),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Container(
                                                        child: product
                                                                    .imageUrl !=
                                                                null
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  height: 50,
                                                                  width: 50,
                                                                  imageUrl: product
                                                                      .imageUrl,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      CircularProgressIndicator(),
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(
                                                                    Icons.error,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            : Center(
                                                                child: Image.asset(
                                                                    'images/hishabeeLogo.png',
                                                                    height: 50,
                                                                    width: 50),
                                                              ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Container(
                                                                width:
                                                                    size.width *
                                                                        0.3,
                                                                child: Text(
                                                                  product.name,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    // fontSize: 28,
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
                                                                      left:
                                                                          8.0),
                                                              child: Container(
                                                                child: Text(
                                                                  product.stock >
                                                                          0
                                                                      ? ""
                                                                      : 'Out of Stock',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    // fontSize: 28,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8),
                                                      child: Container(
                                                        child: Text(
                                                          '৳ ${product.sellingPrice}',
                                                          style: TextStyle(
                                                            fontFamily: 'Rubik',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: DEFAULT_BLUE,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: DEFAULT_BLUE,
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .shopping_cart_rounded,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Get.to(SellCartPage(),
                                      binding: SellBinding());
                                },
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: DEFAULT_YELLOW_BG,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      )),
                                  child: Container(
                                    width: size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "tk".tr,
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Obx(
                                            () => Text(
                                              "${controller.totalCartProductPrice.value}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLUE,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Obx(
                                            () => ShakeAnimatedWidget(
                                              enabled: controller.animate.value,
                                              duration:
                                                  Duration(milliseconds: 100),
                                              shakeAngle: Rotation.deg(z: 15),
                                              curve: Curves.linear,
                                              child: Container(
                                                height: 40,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.white),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Get.toNamed(SellPageRoutes.SELL_CART_PAGE);
                                                    Get.to(SellCartPage(),
                                                        binding: SellBinding());
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Obx(
                                                        () => Text(
                                                          "${controller.cart.length}",
                                                          style: TextStyle(
                                                            fontFamily: 'Rubik',
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: DEFAULT_BLUE,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_sharp,
                                                        color: DEFAULT_BLUE,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "select date",
      context: context,
      initialDate: controller.selectedStartDate.value,
      // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: DEFAULT_BLACK,
              onPrimary: DEFAULT_BODY_BG_COLOR,
              surface: Colors.green,
              onSurface: DEFAULT_BLACK,
            ),
            dialogBackgroundColor: DEFAULT_BODY_BG_COLOR,
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != controller.selectedStartDate.value) {
      controller.selectedStartDate.value = picked;
    }
  }

  _addInput() async {
    return DropdownButton(items: [
      DropdownMenuItem(
        child: Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            Text('Free SMS')
          ],
        ),
      )
    ], onChanged: (value) {});
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
