import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_setting_controller.dart';

class BannerChangePage extends GetView<OnlineStoreSettingController> {
  final portraitImageList = [
    NetworkImage('images/slider/slide1.png'),
    NetworkImage('images/slider/slide2.png'),
    NetworkImage('images/slider/slide3.png'),
    NetworkImage('images/slider/slide4.png'),
    NetworkImage('images/slider/slide5.png'),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
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
                        "Change Banner",
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
                padding: const EdgeInsets.only(top: 70, left: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preview",
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
                        height: 120,
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
                          padding: const EdgeInsets.all(5.0),
                          child: Carousel(
                            boxFit: BoxFit.fill,
                            images: portraitImageList,
                            autoplay: true,
                            animationCurve: Curves.fastOutSlowIn,
                            animationDuration: Duration(milliseconds: 1000),
                            dotBgColor: Colors.transparent,
                            dotSize: 5.0,
                            showIndicator: false,
                            dotVerticalPadding: 10,
                            dotColor: Colors.blueGrey,
                            dotPosition: DotPosition.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Selected",
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
                        height: 120,
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
                        child: Obx(
                          () => ListView.builder(
                              itemCount: controller.selectedBannerList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                /* var product = controller
                                    .products[controller.products.length - 1 - index];*/
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.black,
                                    child: Image.file(
                                        controller.selectedBannerList[index]),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                                  child: Center(child: Icon(Icons.camera_alt)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.3,
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
                        child: Obx(
                          () => StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              itemCount: controller.bannerList.length,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    controller.selectedBannerList
                                        .add(controller.bannerList[index]);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 150,
                                    color: Colors.black,
                                    child: Image.file(
                                        controller.bannerList[index]),
                                  ),
                                );
                              },
                              staggeredTileBuilder: (index) =>
                                  StaggeredTile.fit(1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: DEFAULT_BLUE,
                          ),
                          onPressed: () async {
                            await controller.updateBanner();
                          },
                          child: Text(
                            "Save",
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
              )
            ],
          ),
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
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            controller.bannerList.add(value);
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
                            controller.bannerList.add(value);
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
                            controller.bannerList.add(value);
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
                            controller.bannerList.add(value);
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
