import 'package:animated_widgets/animated_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/add_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/confirm_payment_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/tabs_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/confirm_payment_page.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:showcaseview/showcaseview.dart';

class SellPageShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(builder: (context) => SellPage()),
      autoPlay: true,
      autoPlayDelay: Duration(seconds: 3),
      autoPlayLockEnable: true,
    );
  }
}

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  SellController sellController;
  TabsController tabsController;

  void initState() {
    super.initState();
    AnalyticsService.sendAnalyticsToServer(event: AnalyticsEvent.sellStarted);
    sellController = Get.find();
    tabsController = Get.put(TabsController(), tag: '1');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 2 - 5);
    final double itemWidth = (size.width);
    ScrollController scrollController = new ScrollController();
    return Obx(
      () => sellController.categoryList.length <= 0
          ? Scaffold()
          : Scaffold(
              backgroundColor: DEFAULT_BODY_BG_COLOR,
              body: SafeArea(
                child: DefaultTabController(
                  length: sellController.subCategoryNames.length,
                  initialIndex: 1,
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
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, right: 10),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                      ),
                                      child: Text(
                                        'sell'.tr,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Obx(
                                      () => Padding(
                                          padding: const EdgeInsets.only(
                                            right: 5,
                                          ),
                                          child: sellController.isGrid.value
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.list,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {
                                                    sellController
                                                        .isGrid.value = false;
                                                  })
                                              : IconButton(
                                                  icon: Icon(
                                                    Icons.grid_view,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {
                                                    sellController
                                                        .isGrid.value = true;
                                                  })),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.contact_support,
                                          size: 35,
                                          color: DEFAULT_BLUE,
                                        ),
                                        onPressed: () {
                                          final String url =
                                              "https://www.youtube.com/watch?v=c5N9_QhAzFw&list=PLO7C_xRyL47emWQfUcp2-djjzgdlPGcqS&index=8";
                                          final String title =
                                              "sell_page_showcase".tr;
                                          Navigator.of(context).push(
                                              TutorialOverlay(url, title));
                                        })
                                  ],
                                ),
                              ),
                              SearchBarWidget(
                                  size: size, tabsController: tabsController),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: size.width - 10,
                                    child: TabBar(
                                      isScrollable: true,
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.black,
                                      labelPadding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.black,
                                      ),
                                      tabs: getTabs(sellController),
                                      onTap: (index) {
                                        if (index > 0) {
                                          setState(() {
                                            tabsController =
                                                Get.find<TabsController>(
                                                    tag: '$index');
                                            tabsController.clearSearch(index);
                                            sellController
                                                .searchTextEditingController
                                                .clear();
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Container(
                                        height: size.height / 1.5,
                                        child: TabBarView(
                                          children: getTabBarViews(
                                              size,
                                              sellController,
                                              scrollController,
                                              itemWidth,
                                              itemHeight,
                                              context),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            openBottomSheet(context, size, sellController);
                          },
                          child: Container(
                            width: size.width,
                            height: 70,
                            decoration: BoxDecoration(
                                color: DEFAULT_YELLOW_BG,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Container(
                                    width: 60,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
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
                                                "${sellController.totalCartPrice.value}",
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
                                                enabled: sellController
                                                    .animate.value,
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
                                                      if (sellController
                                                              .cart.length >
                                                          0) {
                                                        Get.to(
                                                            () =>
                                                                ConfirmPaymentPage(),
                                                            binding:
                                                                ConfirmPaymentBinding(),
                                                            arguments: {
                                                              'shop':
                                                                  sellController
                                                                      .shop
                                                                      .value,
                                                              'cart':
                                                                  sellController
                                                                      .cart,
                                                              'totalPrice':
                                                                  sellController
                                                                      .totalCartPrice
                                                                      .value,
                                                            });
                                                      } else {
                                                        CustomDialog
                                                            .showStringDialog(
                                                                'Cart  empty!');
                                                      }
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Obx(
                                                          () => Text(
                                                            "${sellController.cart.length}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Rubik',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLUE,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 60,
                          bottom: 5,
                          child: Obx(
                            () => Container(
                              child: sellController.animate.value
                                  ? TranslationAnimatedWidget.tween(
                                      duration: Duration(milliseconds: 700),
                                      enabled: true,
                                      translationDisabled: Offset(
                                          -size.width +
                                              sellController.animationX
                                                  .round() +
                                              50,
                                          -size.height +
                                              sellController.animationY
                                                  .round()),
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
                      sellController.showHide.value == false
                          ? Positioned(
                              right: 50,
                              top: 20,
                              child: Obx(
                                () => OpacityAnimatedWidget.tween(
                                  opacityEnabled: 1, //define start value
                                  opacityDisabled: 0, //and end value
                                  enabled: sellController.showCase.value,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: DEFAULT_BLACK,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 40,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "sell_page_showcase".tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.play_arrow_sharp,
                                          size: 30,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
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
    );
  }
}

openBottomSheet(BuildContext context, Size size, SellController controller) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: new BoxDecoration(
          color: DEFAULT_YELLOW_BG,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 45.0, top: 75),
              child: Container(
                child: Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        var product =
                            controller.cart[controller.cart.length - 1 - index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      height: 50,
                                      width: 50,
                                      child: product.imageUrl != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: CachedNetworkImage(
                                                height: 50,
                                                width: 50,
                                                imageUrl: product.imageUrl,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Center(
                                              child: Image.asset(
                                                'images/hishabeeLogo.png',
                                                height: 50,
                                                width: 50,
                                              ),
                                            )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Container(
                                      height: 70,
                                      width: 130,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${product.name}"),
                                          Text("TK ${product.sellingPrice}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "X",
                                      style: TextStyle(
                                          color: DEFAULT_BLACK,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${product.unit}",
                                      style: TextStyle(
                                          color: DEFAULT_BLUE,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.removeFromCart(product);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.delete_forever,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: size.width,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          width: 60,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
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
                                      "${controller.totalCartPrice.value}",
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLUE,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white),
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.cart.length > 0) {
                                          Get.to(() => ConfirmPaymentPage(),
                                              binding: ConfirmPaymentBinding(),
                                              arguments: {
                                                'shop': controller.shop.value,
                                                'cart': controller.cart,
                                                'totalPrice': controller
                                                    .totalCartPrice.value,
                                              });
                                        } else {
                                          CustomDialog.showStringDialog(
                                              'Cart  empty!');
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Obx(
                                            () => Text(
                                              "${controller.cart.length}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLUE,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: DEFAULT_BLUE,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: DEFAULT_YELLOW_BG,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.clearCart();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: size.width - 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: DEFAULT_BLUE, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {
                              if (controller.cart.length > 0) {
                                Get.to(() => ConfirmPaymentPage(),
                                    binding: ConfirmPaymentBinding(),
                                    arguments: {
                                      'shop': controller.shop.value,
                                      'cart': controller.cart,
                                      'totalPrice':
                                          controller.totalCartPrice.value,
                                    });
                              } else {
                                CustomDialog.showStringDialog('Cart  empty!');
                              }
                            },
                            child: Center(
                              child: Text(
                                "confirm".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        )),
  );
}

showUpdateStockDialog(BuildContext context, Product product, Shop shop,
    List<Category> productCategoryList, SellController controller) {
  String catagory;
  productCategoryList
      .forEach((Category c) => c.subCategory.forEach((SubCategory sc) {
            if (sc.id == product.subCategory) {
              catagory = sc.name;
            }
          }));
  Size size = MediaQuery.of(context).size;
  TextEditingController txtController =
      TextEditingController(text: controller.productCount.value.toString());
  controller.calculateProductPrice(product);
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => KeyboardAwareDialog(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.15,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          product.imageUrl == null || product.imageUrl == "null"
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
                          '$catagory',
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
                          "tk".tr + ' ${product.sellingPrice}',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.productCount.value > 1) {
                                controller.productCount.value--;
                                controller.calculateProductPrice(product);
                              }
                              txtController.text =
                                  controller.productCount.value.toString();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
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
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
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
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey)),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: txtController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 5, right: 5, bottom: 10),
                              ),
                              onChanged: (value) {
                                controller.productCount.value =
                                    int.parse(value);
                                controller.calculateProductPrice(product);
                              },
                            ),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              controller.productCount.value++;
                              controller.calculateProductPrice(product);
                              txtController.text =
                                  controller.productCount.value.toString();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(width: 0.1, color: Colors.black),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      width: size.width * 0.16,
                                      child: Text(
                                        "discount".tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                    child: VerticalDivider(
                                      thickness: 0.6,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.4,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        controller.discountPercent.value =
                                            int.parse(value);
                                        controller
                                            .calculateProductPrice(product);
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(right: 15),
                                        suffix: Text("%"),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(width: 0.1, color: Colors.black),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      width: size.width * 0.16,
                                      child: Text(
                                        "tk_discount".tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: VerticalDivider(
                                      thickness: 0.6,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.4,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        controller.discountTk.value =
                                            double.parse(value);
                                        controller
                                            .calculateProductPrice(product);
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(right: 15),
                                        suffix: Text("Tk"),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.blueGrey,
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
                    Obx(
                      () => Text(
                        "tk".tr + "  ${controller.productPrice.value}",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                              controller.productCount.value = 1;
                              controller.discountPercent.value = 0;
                              controller.discountTk.value = 0.0;
                              controller.calculateProductPrice(product);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Image.asset(
                                "images/icons/red_delete.png",
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.5,
                            height: 40,
                            child: Obx(
                              () => RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                onPressed: controller.productCount.value <= 0
                                    ? null
                                    : () {
                                        //TODO Update cart By product Item Count
                                        controller.addToCart(product);
                                        Get.back();
                                        controller.productCount.value = 1;
                                        controller.discountPercent.value = 0;
                                        controller.discountTk.value = 0.0;
                                        controller
                                            .calculateProductPrice(product);
                                      },
                                child: Text(
                                  "confirm".tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}

List<Tab> getTabs(SellController controller) {
  List<Tab> tabs = <Tab>[];

  controller.subCategoryNames.forEach((element) {
    var tab = Tab(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
            ),
            child: Text(
              element,
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ),
        ),
      ),
    );

    tabs.add(tab);
  });

  return tabs;
}

List<Widget> getTabBarViews(
    Size size,
    SellController controller,
    ScrollController scrollController,
    double itemWidth,
    double itemHeight,
    BuildContext context) {
  List<Widget> tabBarViews = <Widget>[
    Container(
      height: (size.height / 1.8),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: DEFAULT_BLACK,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size.width / 3,
                        child: TextFormField(
                          onSaved: (value) {
                            controller.customProductName.value = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 12),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Product Name",
                            hintStyle: TextStyle(
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        width: size.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: size.width * 0.4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Obx(
                                  () => Text(
                                    controller.customProductPrice.value.isEmpty
                                        ? "৳ " + "0"
                                        : "৳ " +
                                            controller.customProductPrice.value,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: DEFAULT_BLACK,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.backspace,
                                color: DEFAULT_BLACK,
                              ),
                              onPressed: () {
                                controller.customProductPrice.value = "";
                              },
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                )),
            Expanded(
              child: Container(
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  controller: scrollController,
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisCount: 3,
                  children: List.generate(
                    12,
                    (index) {
                      var customKey = RectGetter.createGlobalKey();
                      switch (index) {
                        case 0:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "1";
                              },
                              child: Text(
                                "1",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 1:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "2";
                              },
                              child: Text(
                                "2",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 2:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "3";
                              },
                              child: Text(
                                "3",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 3:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "4";
                              },
                              child: Text(
                                "4",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 4:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "5";
                              },
                              child: Text(
                                "5",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 5:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "6";
                              },
                              child: Text(
                                "6",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 6:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "7";
                              },
                              child: Text(
                                "7",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 7:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "8";
                              },
                              child: Text(
                                "8",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 8:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "9";
                              },
                              child: Text(
                                "9",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 9:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (controller
                                    .customProductPrice.value.isEmpty) {
                                  controller.customProductPrice.value += "0.";
                                } else if (controller.customProductPrice
                                    .contains(".")) {
                                } else {
                                  controller.customProductPrice.value += ".";
                                }
                              },
                              child: Text(
                                ".",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 10:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.customProductPrice.value += "0";
                              },
                              child: Text(
                                "0",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 11:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: RectGetter(
                              key: customKey,
                              child: TextButton(
                                onPressed: () {
                                  if (controller
                                      .customProductPrice.value.isNotEmpty) {
                                    if (controller.formKey.currentState
                                        .validate()) {
                                      var rect =
                                          RectGetter.getRectFromKey(customKey);
                                      controller.animationX.value = rect.left;
                                      controller.animationY.value = rect.top;
                                      controller.formKey.currentState.save();

                                      controller.animateButton();
                                      Product product = Product(
                                          name: controller
                                              .customProductName.value,
                                          sellingPrice: double.parse(controller
                                              .customProductPrice.value),
                                          stock: 1);

                                      controller.addToCart(product);
                                      controller.customProductPrice.value = "";
                                    }
                                  } else {
                                    CustomDialog.showStringDialog(
                                        "Price Shouldn't be Empty!");
                                  }
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    size: 35,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                              ),
                            ),
                          );
                          break;
                        default:
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                              ),
                            ),
                          );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  for (int i = 1; i < controller.subCategoryNames.length; i++) {
    var products = i == 1
        ? controller.productList
        : controller
            .getProductsByCategory(controller.subCategoryList[i - 2].id);

    var tabBarView = buildTabBody(products, '$i', size, context);
    tabBarViews.add(tabBarView);
  }

  return tabBarViews;
}

Widget buildTabBody(
    List<Product> products, String tag, Size size, BuildContext context) {
  final TabsController tabsController = Get.put(TabsController(), tag: tag);
  final SellController sellController = Get.find();
  tabsController.init(products);
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 5),
    child: Obx(
      () => sellController.isGrid.value
          ? Expanded(
              child: Container(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Obx(
                    () => StaggeredGridView.countBuilder(
                        crossAxisCount: 3,
                        itemCount: tabsController.searchList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Product product = tabsController.searchList[
                              tabsController.searchList.length - 1 - index];
                          var key = RectGetter.createGlobalKey();

                          return RectGetter(
                            key: key,
                            child: InkWell(
                              onTap: () {
                                var rect = RectGetter.getRectFromKey(key);
                                sellController.animationX.value = rect.left;
                                sellController.animationY.value = rect.top;
                                sellController.animateButton();
                                sellController.addToCart(product);
                              },
                              onLongPress: () {
                                showUpdateStockDialog(
                                    context,
                                    product,
                                    sellController.shop.value,
                                    sellController.categoryList,
                                    sellController);
                              },
                              child: Container(
                                height: 150,
                                width: size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                          height: 80,
                                          //width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: product.stock > 0
                                              ? product.imageUrl != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      child: CachedNetworkImage(
                                                        height: 70,
                                                        width:
                                                            size.width * 0.25 -
                                                                10,
                                                        imageUrl:
                                                            product.imageUrl,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(
                                                          Icons.error,
                                                          color: Colors.red,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Image.asset(
                                                        'images/hishabeeLogo.png',
                                                        height: 70,
                                                        width:
                                                            size.width * 0.25 -
                                                                10,
                                                      ),
                                                    )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Stack(
                                                    children: [
                                                      product.imageUrl != null
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              child:
                                                                  CachedNetworkImage(
                                                                height: 80,
                                                                width:
                                                                    size.width *
                                                                            0.3 -
                                                                        10,
                                                                imageUrl: product
                                                                    .imageUrl,
                                                                errorWidget:
                                                                    (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            )
                                                          : Center(
                                                              child:
                                                                  Image.asset(
                                                                'images/hishabeeLogo.png',
                                                                height: 80,
                                                                width:
                                                                    size.width *
                                                                            0.3 -
                                                                        10,
                                                              ),
                                                            ),
                                                      Container(
                                                        height: 100,
                                                        width:
                                                            size.width * 0.3 -
                                                                4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Colors.grey
                                                              .withOpacity(0.6),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "Out of Stock",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Center(
                                        child: Text(
                                          product.name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: DEFAULT_BLACK,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Container(
                                            width: size.width * 0.15,
                                            child: Text(
                                              '৳ ${product.sellingPrice}',
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLUE,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, bottom: 5),
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: DEFAULT_BLUE,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.shopping_cart_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
                  ),
                ),
              ),
            )
          : Container(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tabsController.searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = tabsController.searchList[
                          tabsController.searchList.length - 1 - index];
                      var key = RectGetter.createGlobalKey();

                      return RectGetter(
                        key: key,
                        child: InkWell(
                          onTap: () {
                            var rect = RectGetter.getRectFromKey(key);
                            sellController.animationX.value = rect.left;
                            sellController.animationY.value = rect.top;
                            sellController.animateButton();
                            sellController.addToCart(product);
                          },
                          onLongPress: () {
                            showUpdateStockDialog(
                                context,
                                product,
                                sellController.shop.value,
                                sellController.categoryList,
                                sellController);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                left:
                                    BorderSide(width: 1.0, color: Colors.grey),
                                right:
                                    BorderSide(width: 1.0, color: Colors.grey),
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.grey),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 5, bottom: 5),
                                    child: Container(
                                      child: product.imageUrl != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: CachedNetworkImage(
                                                height: 50,
                                                width: 50,
                                                imageUrl: product.imageUrl,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                                fit: BoxFit.fill,
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
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              width: size.width * 0.3,
                                              child: Text(
                                                product.name,
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  // fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              child: Text(
                                                product.stock > 0
                                                    ? ""
                                                    : 'Out of Stock',
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  // fontSize: 28,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Container(
                                      child: Text(
                                        '৳ ${product.sellingPrice}',
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLUE,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: DEFAULT_BLUE,
                                      ),
                                      child: Icon(
                                        Icons.shopping_cart_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
    ),
  );
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key key,
    @required this.size,
    @required this.tabsController,
  }) : super(key: key);

  final Size size;
  final TabsController tabsController;

  @override
  Widget build(BuildContext context) {
    final sellController = Get.find<SellController>();
    return Padding(
      padding: const EdgeInsets.only(
        top: 76.0,
        right: 10,
        left: 10,
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.search,
                color: DEFAULT_BLUE,
                size: 22,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Container(
                width: size.width / 2,
                child: TextFormField(
                  controller: sellController.searchTextEditingController,
                  onChanged: (value) {
                    tabsController.search(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Search Product",
                    hintStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: VerticalDivider(
                thickness: 0.6,
                color: DEFAULT_BLACK,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: InkWell(
                onTap: () async {
                  await tabsController.scanProduct();
                },
                child: Container(
                  child: Row(
                    children: [
                      Image(
                        height: 20,
                        image: AssetImage('images/icons/barcodeIcon.png'),
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
          ],
        ),
      ),
    );
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
