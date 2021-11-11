import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_bindings/shop_main_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/edit_shop_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/_bindings/store_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_setting_controller.dart';

import 'change_banner_page.dart';
import 'online_shop_link_page.dart';
import 'online_shop_social_media_link_page.dart';

class ShopSettingPage extends GetView<OnlineStoreSettingController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Obx(
          () {
            final shop = controller.onlineShopInfoResponse.value.shop;
            return SingleChildScrollView(
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
                    padding: const EdgeInsets.only(top: 20, right: 10),
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
                            "Store Setting",
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 60, left: 20.0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Publish Online Store",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Container(
                            height: 80,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    shop.public ? "PUBLISHED" : "UNPUBLISHED",
                                    style: TextStyle(
                                      color: shop.public
                                          ? Colors.teal
                                          : Colors.red,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
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
                                    value: shop.public,
                                    onToggle: (value) async {
                                      controller.storePublished.value = value;
                                      await controller.storePublishToggle();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Online Store Logo",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Container(
                            height: 80,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showPictureOptionDialogue(context);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: Colors.grey.withOpacity(0.2),
                                      child:
                                          Center(child: Icon(Icons.camera_alt)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Online Store Banner",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => BannerChangePage(),
                                binding: StoreBinding(),
                              );
                            },
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 25,
                                      color: DEFAULT_BLACK,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Online Store Link",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => OnlineShopLinkPage(),
                                binding: StoreBinding(),
                              );
                            },
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.75,
                                      child: RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'hishabee.market/shop/',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                            TextSpan(
                                                text: '${shop.slug}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: DEFAULT_BLACK)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 25,
                                        color: DEFAULT_BLACK,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Social Media Link",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => OnlineShopSocialMediaLinkPage(),
                                binding: StoreBinding(),
                              );
                            },
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.75,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Facebook",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLACK
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.indigo,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  FontAwesomeIcons.facebookF,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Instagram",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLACK
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  FontAwesomeIcons.instagram,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Youtube",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLACK
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  FontAwesomeIcons.youtube,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 25,
                                        color: DEFAULT_BLACK,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Store Information",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 15, bottom: 15),
                              child: Container(
                                width: size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "shop_name".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK.withOpacity(0.7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10),
                                      child: Text(
                                        "${shop.name}",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "address".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK.withOpacity(0.7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10),
                                      child: Text(
                                        "${shop.address}",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "shop_type".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK.withOpacity(0.7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10),
                                      child: Obx(
                                        () => Text(
                                          "${controller.shopTypeName.value}",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "area".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK.withOpacity(0.7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10),
                                      child: Obx(
                                        () => Text(
                                          "${controller.areaName}",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 25.0,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                            onPrimary: DEFAULT_BLUE,
                                          ),
                                          onPressed: () {
                                            Get.to(
                                              () => EditShopPage(),
                                              binding: ShopMainBinding(),
                                              arguments: {
                                                "shop": controller
                                                    .onlineShopInfoResponse
                                                    .value
                                                    .shop
                                              },
                                            );
                                          },
                                          child: Text(
                                            "Update Shop info",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
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
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  showPictureOptionDialogue(BuildContext context) {
    final controller = Get.find<OnlineStoreSettingController>();
    try {
      if (Platform.isIOS) {
        showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          ImageHelper.getImageFromCamera().then((value) async {
                            controller.logo.value = value;
                            await controller.updateLogo();
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
                        onTap: () async {
                          //getImageFromGallery(option);
                          ImageHelper.getImageFromGallery().then((value) async {
                            controller.logo.value = value;
                            await controller.updateLogo();
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
                        onTap: () async {
                          ImageHelper.getImageFromCamera().then((value) async {
                            controller.logo.value = value;
                            await controller.updateLogo();
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
                        onTap: () async {
                          //getImageFromGallery(option);
                          ImageHelper.getImageFromGallery().then((value) async {
                            controller.logo.value = value;
                            await controller.updateLogo();
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
      }
    } catch (e) {}
  }
}
