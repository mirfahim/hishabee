import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
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
import 'package:rect_getter/rect_getter.dart';

class AddProductToCart extends GetView<SellController> {
  AddProductToCart({
    Key key,
  }) : super(key: key);
  RxBool smsCheckBox = false.obs;
  RxBool mobileNumberCheckbox = false.obs;
  RxBool profitCheckBox = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final shopFeatureController = Get.find<ShopFeaturesController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          "Sell",
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
                Obx(() => Stack(children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Container(
                                  // width: MediaQuery.of(context).size.width /
                                  //     1.25,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xFF185ADB), width: 1.5),
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
                                        flex: 3,
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
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
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
                                                        controller.categoryList,
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
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
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
                            height: MediaQuery.of(context).size.height - 220,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: controller.searchList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Product product = controller.searchList[
                                      controller.searchList.length - 1 - index];
                                  var key = RectGetter.createGlobalKey();
                                  return RectGetter(
                                    key: key,
                                    child: InkWell(
                                        onTap: () {
                                          var rect =
                                              RectGetter.getRectFromKey(key);
                                          controller.animationX.value =
                                              rect.left;
                                          controller.animationY.value =
                                              rect.top;

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
                                                      imageUrl:
                                                          product.imageUrl,
                                                      placeholder: (context,
                                                              url) =>
                                                          new CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
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
                                        )),
                                  );
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
                      ),
                      Positioned(
                          right: 60,
                          bottom: 5,
                          child: Obx(
                            () => Container(
                              child: controller.animate.value
                                  ? TranslationAnimatedWidget.tween(
                                      duration: Duration(milliseconds: 700),
                                      enabled: true,
                                      translationDisabled: Offset(
                                          -size.width +
                                              controller.animationX.round() +
                                              50,
                                          -size.height +
                                              controller.animationY.round()),
                                      translationEnabled: Offset(0, 0),
                                      child: OpacityAnimatedWidget.tween(
                                        enabled: true,
                                        opacityDisabled: 0,
                                        opacityEnabled: 1,
                                        child: Image.asset(
                                            'images/hishabeeLogo.png',
                                            height: 35,
                                            width: 35),
                                      ),
                                    )
                                  : Container(),
                            ),
                          )),
                    ]))
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
    // return StatefulBuilder(builder: (context, snapshot) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        context: context,
        builder: (context) => Container(
              height: 300,
              width: 400,
              child: CalcButton(),
            ));
    // }
    // );
  }
}
