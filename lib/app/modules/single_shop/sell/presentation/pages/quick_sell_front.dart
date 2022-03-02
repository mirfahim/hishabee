import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/calculator/views/pages/calculator_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/add_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/confirm_payment_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/sell_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_navigation/sell_page_route.dart';

// import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_navigation/sell_page_routs.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/tabs_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_cart_page.dart';
import 'package:input_calculator/input_calculator.dart';
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
    RxBool smsCheckBox = false.obs;
    RxBool mobileNumberCheckbox = false.obs;
    RxBool profitCheckBox = false.obs;
    Size size = MediaQuery.of(context).size;

    final shopFeatureController = Get.find<ShopFeaturesController>();
    return Scaffold(
      // bottomSheet: controller.sellType.value != 0 ? InkWell(
      //   onTap: () {
      //     Get.to(SellCartPage(),
      //         binding: SellBinding());
      //   },
      //   child: Container(
      //     width: size.width,
      //     decoration: BoxDecoration(
      //         color: DEFAULT_YELLOW_BG,
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(15),
      //           topRight: Radius.circular(15),
      //         )),
      //     child: Container(
      //       width: size.width,
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(
      //             horizontal: 15.0),
      //         child: Row(
      //           children: [
      //             Text(
      //               "tk".tr,
      //               style: TextStyle(
      //                 fontFamily: 'Rubik',
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.bold,
      //                 color: DEFAULT_BLUE,
      //               ),
      //             ),
      //             SizedBox(
      //               width: 15,
      //             ),
      //             Obx(
      //                   () => Text(
      //                 "${controller.totalCartProductPrice.value}",
      //                 style: TextStyle(
      //                   fontFamily: 'Rubik',
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.bold,
      //                   color: DEFAULT_BLUE,
      //                 ),
      //               ),
      //             ),
      //             Spacer(),
      //             Obx(
      //                   () => ShakeAnimatedWidget(
      //                 enabled: controller.animate.value,
      //                 duration:
      //                 Duration(milliseconds: 100),
      //                 shakeAngle: Rotation.deg(z: 15),
      //                 curve: Curves.linear,
      //                 child: Container(
      //                   height: 40,
      //                   width: 70,
      //                   decoration: BoxDecoration(
      //                       borderRadius:
      //                       BorderRadius.circular(
      //                           8),
      //                       color: Colors.white),
      //                   child: InkWell(
      //                     onTap: () {
      //                       // Get.toNamed(SellPageRoutes.SELL_CART_PAGE);
      //                       Get.to(SellCartPage(),
      //                           binding: SellBinding());
      //                     },
      //                     child: Row(
      //                       mainAxisAlignment:
      //                       MainAxisAlignment
      //                           .spaceAround,
      //                       children: [
      //                         Obx(
      //                               () => Text(
      //                             "${controller.cart.length}",
      //                             style: TextStyle(
      //                               fontFamily: 'Rubik',
      //                               fontSize: 18,
      //                               fontWeight:
      //                               FontWeight.bold,
      //                               color: DEFAULT_BLUE,
      //                             ),
      //                           ),
      //                         ),
      //                         Icon(
      //                           Icons
      //                               .arrow_forward_ios_sharp,
      //                           color: DEFAULT_BLUE,
      //                           size: 20,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ): Container() ,
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
      body: Container(
        // height: size.height + 30,
        // width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
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
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: Offset(
                            //         0, 3), // changes position of shadow
                            //   ),
                            // ],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color(0xFFC4C4C4).withOpacity(.35))),
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
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: Offset(
                            //         0, 3), // changes position of shadow
                            //   ),
                            // ],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color(0xFFC4C4C4).withOpacity(.35))),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
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
                                          print("working");
                                          showPictureOptionDialogue(context);
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
                                            padding: const EdgeInsets.all(9.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
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
                                  child: PopupMenuButton(
                                    icon: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        onTap: () {
                                          if (smsCheckBox.value == false)
                                            smsCheckBox.value = true;
                                          else
                                            smsCheckBox.value = false;
                                        },
                                        child: Row(
                                          children: [
                                            Obx(
                                              () => Checkbox(
                                                  value: smsCheckBox.value,
                                                  onChanged: (checked) {
                                                    smsCheckBox.value = checked;
                                                  }),
                                            ),
                                            Text("sms_free_20".tr,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto',
                                                )),
                                          ],
                                        ),
                                        value: 1,
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          if (mobileNumberCheckbox.value ==
                                              false)
                                            mobileNumberCheckbox.value = true;
                                          else
                                            mobileNumberCheckbox.value = false;
                                        },
                                        child: Row(
                                          children: [
                                            Obx(
                                              () => Checkbox(
                                                  value: mobileNumberCheckbox
                                                      .value,
                                                  onChanged: (checked) {
                                                    mobileNumberCheckbox.value =
                                                        checked;
                                                  }),
                                            ),
                                            Text("customer_mobile_number".tr,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto',
                                                )),
                                          ],
                                        ),
                                        value: 2,
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          if (profitCheckBox.value == false)
                                            profitCheckBox.value = true;
                                          else
                                            profitCheckBox.value = false;
                                        },
                                        child: Row(
                                          children: [
                                            Obx(
                                              () => Checkbox(
                                                  value: profitCheckBox.value,
                                                  onChanged: (checked) {
                                                    profitCheckBox.value =
                                                        checked;
                                                  }),
                                            ),
                                            Text("profit".tr,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto',
                                                )),
                                          ],
                                        ),
                                        value: 2,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            // CalculatorTextField(
                            //   initialValue: _value,
                            //   onSubmitted: (value) {
                            //     _value = value;
                            //     print('value: $_value');
                            //   },
                            // )
                            child: TextFormField(
                              // controller: controller.amount.value,
                              onTap: () {
                                // CalcButton();
                                print("working 123");
                                showCalculatorOptionDialogue(context);
                              },

                              showCursor: true,
                              readOnly: true,
                              onSaved: (value) {
                                controller.amount.value = double.parse(value);
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
                          mobileNumberCheckbox.value == true
                              ? Obx(
                                  () => controller.customerField.value
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
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
                                              labelText:
                                                  'Customer Mobile Number',
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
                                )
                              : Container(),
                          profitCheckBox.value == true
                              ? Obx(
                                  () => controller.profitField.value
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
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
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                          // sada
                          SizedBox(
                            height: 10,
                          ),
                          smsCheckBox.value == true
                              ? Obx(() => controller.smsField.value
                                  ? Center(
                                      child: Container(
                                      height: 40,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xFFEBEFF2)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("sms_free_20".tr,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Roboto',
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: FlutterSwitch(
                                              height: 25.0,
                                              width: 40.0,
                                              padding: 4.0,
                                              toggleSize: 20.0,
                                              borderRadius: 20.0,
                                              inactiveColor: Colors.black,
                                              activeColor: Color(0xFF185ADB),
                                              value: true,
                                              onToggle: (value) {
                                                // controller.isOnline.value =
                                                //     value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                  : Container())
                              : Container(),
                          SizedBox(
                            height: 20,
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
                    : Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xFF185ADB), width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
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
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
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
                                            // border: InputBorder(bo),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                            child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Container(
                                                  height: 30,
                                                  child: VerticalDivider(
                                                      thickness: 2,
                                                      color: Color(0xFF185ADB),
                                                      indent: 0,
                                                      endIndent: 0)),
                                              InkWell(
                                                onTap: () {
                                                  _showCategoryDialog(
                                                      controller.categoryList,
                                                      size,
                                                      context);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0, left: 5),
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
                          Container(
                            height: size.height - 340,
                            child: ListView.builder(
                                shrinkWrap: true,
                                // scrollDirection: Axis.vertical,
                                // physics: AlwaysScrollableScrollPhysics(),
                                itemCount: controller.searchList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Product product = controller.searchList[
                                      controller.searchList.length - 1 - index];
                                  return InkWell(
                                      onTap: () {
                                        controller.animateButton();
                                        controller.addToCart(product);
                                      },
                                      child:
                                          // Obx(()=>
                                          Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ListTile(
                                            leading: product.imageUrl != null
                                                ? CachedNetworkImage(
                                                    imageUrl: product.imageUrl,
                                                    placeholder: (context,
                                                            url) =>
                                                        new CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        new Icon(Icons.error),
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
                                            title: Text(
                                              product.name,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto'),
                                              maxLines: 3,
                                            ),
                                            trailing: Text(
                                              '৳ ${product.sellingPrice}',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto'),
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
                          ),
                          controller.cart.length > 0
                              ? InkWell(
                                  onTap: () {
                                    Get.to(SellCartPage(),
                                        binding: SellBinding());
                                  },
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF185ADB),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: size.width,
                                      height: 48,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 40),
                                                ),
                                                Text(
                                                  "grand_total".tr,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 18,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    "${controller.totalCartProductPrice.value}",
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 18,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Spacer(),

                                            Obx(
                                              () => ShakeAnimatedWidget(
                                                enabled:
                                                    controller.animate.value,
                                                duration:
                                                    Duration(milliseconds: 100),
                                                shakeAngle: Rotation.deg(z: 07),
                                                curve: Curves.linear,
                                                child: Container(
                                                  height: 30,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white),
                                                  child: InkWell(
                                                    onTap: () {
                                                      // Get.toNamed(SellPageRoutes.SELL_CART_PAGE);
                                                      Get.to(SellCartPage(),
                                                          binding:
                                                              SellBinding());
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Obx(
                                                            () => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(3.0),
                                                              child: Text(
                                                                "${controller.cart.length}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_sharp,
                                                            color: Colors.black,
                                                            size: 20,
                                                          ),
                                                        ],
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
                                  ),
                                )
                              : Container()
                        ],
                      ))
              ],
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

  showPictureOptionDialogue(BuildContext context) {
    //final AddProductController controller = Get.find();
    var file;
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
                    file = value;
                    print("image path is +++++++++++++ $file");

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
                    file = value;

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

  showCalculatorOptionDialogue(BuildContext context) {
    print("working 11");
    return StatefulBuilder(builder: (context, snapshot) {
      return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          child: Container(
            height: 200,
            width: 400,
            child: CalcButton(),
          ));
    });
  }
}
