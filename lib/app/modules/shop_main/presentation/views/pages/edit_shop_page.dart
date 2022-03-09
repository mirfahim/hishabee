import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/area_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_shop_all_type_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/edit_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/widgets/edit_shop_header.dart';

class EditShopPage extends GetResponsiveView<EditShopController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget builder() {
    return Scaffold(
      backgroundColor: DEFAULT_YELLOW_BG,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            EditShopHeader(),
            Form(
              key: formKey,
              child: Container(
                decoration: BoxDecoration(
                  color: DEFAULT_BODY_BG_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ),
                    topRight: Radius.circular(
                      30,
                    ),
                  ),
                ),
                // color: Colors.white,
                width: screen.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 30,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showPictureOptionDialogue();
                            },
                            child: Column(
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: DEFAULT_YELLOW_BG,
                                    child: Obx(() {
                                      return CircleAvatar(
                                        radius: 30,
                                        child: controller.shop.value.logoUrl ==
                                                null
                                            ? controller.image.value.path == ''
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Image(
                                                      image: AssetImage(
                                                          'images/signUpAvatar.png'),
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    child: Image.file(
                                                      File(controller
                                                          .image.value.path),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: CachedNetworkImage(
                                                  imageUrl: controller
                                                      .shop.value.logoUrl,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.amber[400],
                                                  )),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ), /*Image.network(
                                            state[index].logoUrl,
                                            fit: BoxFit.cover,
                                          ),*/
                                              ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "add_a_logo_or_picture_of_your_store".tr,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      // business name start
                      Text(
                        "shop_name".tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: DEFAULT_BLACK,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(() {
                              return TextFormField(
                                initialValue: controller.shop.value.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "General Store",
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Shop name can not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  controller.shopName.value = value;
                                },
                              );
                            }),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Container(
                        width: screen.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "shop_type".tr,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showShopTypeDialog(
                                    controller.shopTypes, screen.context.size);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(() {
                                          return Text(
                                            controller.selectedShopType.value
                                                        .name ==
                                                    null
                                                ? 'Select'
                                                : controller.selectedShopType
                                                    .value.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              // fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLACK,
                                              letterSpacing: 0,
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                width: screen.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        "division".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showDivisionDialog(
                                            controller.divisions,
                                            screen.context.size);
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Obx(() {
                                                  return Text(
                                                    controller.selectedDivision
                                                                .value.name ==
                                                            null
                                                        ? "Division"
                                                        : controller
                                                            .selectedDivision
                                                            .value
                                                            .name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      // fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
                                                      letterSpacing: 0,
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child:
                                                  Icon(Icons.arrow_drop_down),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                width: screen.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        "district".tr,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showDistrictDialog(
                                            controller.selectedDivision.value
                                                .districts,
                                            screen.context.size);
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Obx(() {
                                                  return Text(
                                                    controller.selectedDistrict
                                                                .value.name ==
                                                            null
                                                        ? "District"
                                                        : controller
                                                            .selectedDistrict
                                                            .value
                                                            .name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      // fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
                                                      letterSpacing: 0,
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child:
                                                  Icon(Icons.arrow_drop_down),
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: screen.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "area".tr,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showAreaDialog(
                                    controller.selectedDistrict.value.areas,
                                    screen.context.size);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(() {
                                          return Text(
                                            controller.selectedArea.value
                                                        .name ==
                                                    null
                                                ? "Area"
                                                : controller
                                                    .selectedArea.value.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLACK,
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "address".tr,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: DEFAULT_BLACK,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    initialValue: controller.shop
                                                .value.address ==
                                            null
                                        ? controller.shop
                                        .value.address
                                        : controller.shop
                                        .value.address
                                            ,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Address",
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Address can not be empty';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      controller.address.value = value;
                                    },
                                    onChanged: (value){
                                      controller.address.value = value;
                                    },
                                  )
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     // Get.to(PlacePicker(
                                //     //   apiKey: GMAP_API,
                                //     //   initialPosition:
                                //     //       controller.initialPosition,
                                //     //   useCurrentLocation: true,
                                //     //   selectInitialPosition: true,
                                //     //   onPlacePicked: (result) {
                                //     //     controller.selectedPlace.value = result;
                                //     //     Get.back();
                                //     //   },
                                //     // ));
                                //   },
                                //   child: Container(
                                //     height: 35,
                                //     child: Image(
                                //       image: AssetImage('images/mapIcon.png'),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "press_the_blue_map_icon_and_select_your_store_location_in_map"
                      //         .tr,
                      //     style: TextStyle(
                      //         color: DEFAULT_BLACK,
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.normal),
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Latitude",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: DEFAULT_BLACK,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: screen.width * 0.41,
                                  height: screen.height * 0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Obx(() {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${controller.shop.value.lat.toStringAsPrecision(5)}",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Longitude",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: DEFAULT_BLACK,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: screen.width * 0.41,
                                  height: screen.height * 0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Obx(() {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${controller.shop.value.lng.toStringAsPrecision(5)}",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        "vat_percent".tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: DEFAULT_BLACK,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(() {
                              return TextFormField(
                                initialValue:
                                    controller.shop.value.vatPercent.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "15 %",
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Vat can not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  controller.floorNumber.value = value.isEmpty
                                      ? controller.floorNumber.value
                                      : int.parse(value);
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "vat_percent_if_any_for_the_products_sold_in_your_shop"
                              .tr,
                          style: TextStyle(
                              color: DEFAULT_BLACK,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "public_phone".tr,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: DEFAULT_BLACK,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(() {
                              return TextFormField(
                                initialValue:
                                    controller.shop.value.publicNumber,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefix: Text(
                                    "+88 ",
                                    style: TextStyle(
                                        color: DEFAULT_BLACK.withOpacity(0.7)),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Public Phone Number",
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Public phone number can not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  controller.publicNumber.value = value;
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "this_number_will_be_visible_to_everyone_and_they_will_contact_you_through_this_number_alternatively_provide_helpline_number_if_you_have_any"
                              .tr,
                          style: TextStyle(
                              color: DEFAULT_BLACK,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 15),
                      // Row(
                      //   children: [
                      //     Flexible(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "shop_no".tr,
                      //             style: TextStyle(
                      //               fontFamily: 'Rubik',
                      //               fontSize: 16,
                      //               color: DEFAULT_BLACK,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.only(top: 8.0),
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(5),
                      //                 border: Border.all(
                      //                   color: Colors.grey,
                      //                 ),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                     horizontal: 8),
                      //                 child: Obx(() {
                      //                   return TextFormField(
                      //                     initialValue: controller
                      //                         .shop.value.shopNumber
                      //                         .toString(),
                      //                     keyboardType: TextInputType.number,
                      //                     decoration: InputDecoration(
                      //                       border: InputBorder.none,
                      //                       hintText: "556",
                      //                     ),
                      //                     onSaved: (value) {
                      //                       controller.shopNumber.value = value
                      //                               .isEmpty
                      //                           ? controller.shopNumber.value
                      //                           : int.parse(value);
                      //                     },
                      //                   );
                      //                 }),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Flexible(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "floor_no".tr,
                      //             style: TextStyle(
                      //               fontFamily: 'Rubik',
                      //               fontSize: 16,
                      //               color: DEFAULT_BLACK,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.only(top: 8.0),
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(5),
                      //                 border: Border.all(
                      //                   color: Colors.grey,
                      //                 ),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                     horizontal: 8),
                      //                 child: Obx(() {
                      //                   return TextFormField(
                      //                     initialValue: controller
                      //                         .shop.value.floorNumber
                      //                         .toString(),
                      //                     keyboardType: TextInputType.number,
                      //                     decoration: InputDecoration(
                      //                       border: InputBorder.none,
                      //                       hintText: "2",
                      //                     ),
                      //                     onSaved: (value) {
                      //                       controller.floorNumber.value = value
                      //                               .isEmpty
                      //                           ? controller.floorNumber.value
                      //                           : int.parse(value);
                      //                     },
                      //                   );
                      //                 }),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 15),
                      Text(
                        "referral_id_optional".tr,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: DEFAULT_BLACK,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(() {
                              return TextFormField(
                                initialValue:
                                    controller.shop.value.referralCode,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Referral ID",
                                ),
                                onSaved: (value) {
                                  controller.referralCode.value = value;
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      getDefaultBlueButton(screen.context, 'edit_shop'.tr,
                          () async {
                            formKey.currentState.save();
                            await controller.editShop();
                        // if (formKey.currentState.validate()) {
                        //   formKey.currentState.save();
                        //   await controller.editShop();
                        // }
                      }),
                      SizedBox(height: 35),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            navigator.pop();
                          },
                          child: Text(
                            "discard".tr,
                            style: TextStyle(
                                color: DEFAULT_BLUE,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showShopTypeDialog(List<ShopType> shopTypes, Size size) {
    final EditShopController controller = Get.find();

    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Shop Type",
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: size.height * 0.67,
            width: size.width,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: shopTypes.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectedShopType.value = shopTypes[index];
                    Navigator.pop(context);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: size.width / 2,
                          child: Text(
                            shopTypes[index].name,
                            style: TextStyle(
                                color: DEFAULT_BLUE, fontFamily: "Roboto"),
                          )),
                      SizedBox(height: 5),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            navigator.pop();
          },
        )
      ],
    );
  }

  _showDivisionDialog(List<Division> divisions, Size size) {
    final EditShopController controller = Get.find();
    try {
      if (Platform.isIOS) {
        showDialog(
            context: screen.context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text('Division'),
                  content: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              final result = controller.divisions
                                  .where((Division division) => division.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                              controller.divisionSearch.assignAll(result);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: size.height * 0.5,
                            width: size.width,
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.divisionSearch.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedDivision.value =
                                          controller.divisionSearch[index];

                                      navigator.pop();
                                      _showDistrictDialog(
                                          controller
                                              .selectedDivision.value.districts,
                                          size);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                width: size.width / 2,
                                                child: Text(
                                                  controller
                                                      .divisionSearch[index]
                                                      .name,
                                                  style: TextStyle(
                                                    color: DEFAULT_BLUE,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
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
                    ),
                  ),
                  actions: <Widget>[
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
            context: screen.context,
            builder: (_) => AlertDialog(
                  title: Text('Division'),
                  content: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              final result = controller.divisions
                                  .where((Division division) => division.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                              controller.divisionSearch.assignAll(result);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: size.height * 0.5,
                            width: size.width,
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.divisionSearch.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedDivision.value =
                                          controller.divisionSearch[index];
                                      controller.districtSearch.assignAll(
                                          controller.selectedDivision.value
                                              .districts);
                                      navigator.pop();
                                      _showDistrictDialog(
                                          controller
                                              .selectedDivision.value.districts,
                                          size);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                width: size.width / 2,
                                                child: Text(
                                                  controller
                                                      .divisionSearch[index]
                                                      .name,
                                                  style: TextStyle(
                                                    color: DEFAULT_BLUE,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
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
                    ),
                  ),
                  actions: <Widget>[
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
    //title: "Division",
    //titleStyle: TextStyle(
    //fontWeight: FontWeight.bold,
  }

  _showDistrictDialog(List<District> districts, Size size) {
    final EditShopController controller = Get.find();

    try {
      if (Platform.isIOS) {
        showDialog(
            context: screen.context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text("District"),
                  content: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              final result = controller
                                  .selectedDivision.value.districts
                                  .where((District district) => district.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                              controller.districtSearch.assignAll(result);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: size.height * 0.67,
                            width: size.width,
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.districtSearch.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedDistrict.value =
                                          controller.districtSearch[index];
                                      Navigator.pop(context);
                                      _showAreaDialog(
                                        controller.districtSearch[index].areas,
                                        size,
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: size.width / 2,
                                            child: Text(
                                              controller
                                                  .districtSearch[index].name,
                                              style: TextStyle(
                                                  color: DEFAULT_BLUE,
                                                  fontFamily: "Roboto"),
                                            )),
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
                    ),
                  ),
                  actions: <Widget>[
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
            context: screen.context,
            builder: (_) => AlertDialog(
                  title: Text("District"),
                  content: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              final result = controller
                                  .selectedDivision.value.districts
                                  .where((District district) => district.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                              controller.districtSearch.assignAll(result);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: size.height * 0.67,
                            width: size.width,
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.districtSearch.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedDistrict.value =
                                          controller.districtSearch[index];
                                      controller.areaSearch.assignAll(controller
                                          .districtSearch[index].areas);
                                      Navigator.pop(context);
                                      _showAreaDialog(
                                        controller.districtSearch[index].areas,
                                        size,
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: size.width / 2,
                                            child: Text(
                                              controller
                                                  .districtSearch[index].name,
                                              style: TextStyle(
                                                  color: DEFAULT_BLUE,
                                                  fontFamily: "Roboto"),
                                            )),
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
                    ),
                  ),
                  actions: <Widget>[
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

  _showAreaDialog(List<Area> areas, Size size) {
    final EditShopController controller = Get.find();

    try {
      if (Platform.isIOS) {
        showDialog(
            context: screen.context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text("Area"),
                  content: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              final result = controller
                                  .selectedDistrict.value.areas
                                  .where((Area area) => area.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                              controller.areaSearch.assignAll(result);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: size.height * 0.67,
                            width: size.width,
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.areaSearch.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedArea.value =
                                          controller.areaSearch[index];
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: size.width / 2,
                                            child: Text(
                                              controller.areaSearch[index].name,
                                              style: TextStyle(
                                                  color: DEFAULT_BLUE,
                                                  fontFamily: "Roboto"),
                                            )),
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
                    ),
                  ),
                  actions: <Widget>[
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
            context: screen.context,
            builder: (_) => AlertDialog(
                  title: Text("Area"),
                  content: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              final result = controller
                                  .selectedDistrict.value.areas
                                  .where((Area area) => area.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                              controller.areaSearch.assignAll(result);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: size.height * 0.67,
                            width: size.width,
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.areaSearch.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedArea.value =
                                          controller.areaSearch[index];
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: size.width / 2,
                                            child: Text(
                                              controller.areaSearch[index].name,
                                              style: TextStyle(
                                                  color: DEFAULT_BLUE,
                                                  fontFamily: "Roboto"),
                                            )),
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
                    ),
                  ),
                  actions: <Widget>[
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

  _showPictureOptionDialogue() {
    final EditShopController controller = Get.find();

    try {
      if (Platform.isIOS) {
        showDialog(
            context: screen.context,
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
            context: screen.context,
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
      }
    } catch (e) {}
  }
}
