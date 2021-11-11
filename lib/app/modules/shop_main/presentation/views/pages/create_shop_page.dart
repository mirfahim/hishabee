import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/area_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_shop_all_type_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/create_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/widgets/create_shop_header.dart';

class CreateShopPage extends GetResponsiveView<CreateShopController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget builder() {
    return Scaffold(
      backgroundColor: DEFAULT_YELLOW_BG,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            CreateShopHeader(),
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
                width: screen.context.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 10,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _showPictureOptionDialogue();
                            },
                            child: Column(
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.amber[400],
                                    child: Obx(
                                      () {
                                        return CircleAvatar(
                                            radius: 30,
                                            child: controller.image.value ==
                                                    null
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
                                                            30),
                                                    child: Image(
                                                      image: FileImage(
                                                          controller
                                                              .image.value),
                                                    ),
                                                  ));
                                      },
                                    ),
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
                            child: TextFormField(
                              cursorColor: Colors.black,
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
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: screen.context.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "shop_type".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Obx(() {
                                          return Text(
                                            controller.selectedShopType.value
                                                        .name ==
                                                    null
                                                ? "Shop Type"
                                                : controller.selectedShopType
                                                    .value.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
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

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                width: screen.context.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        "division".tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
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
                                                    left: 10.0),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
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
                                width: screen.context.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        "district".tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.selectedDivision.value
                                                .districts !=
                                            null) {
                                          _showDistrictDialog(
                                              controller.selectedDivision.value
                                                  .districts,
                                              screen.context.size);
                                        } else {
                                          CustomDialog.showStringDialog(
                                              "Please Select division first..!");
                                        }
                                      },
                                      child: Container(
                                        height: 48,
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
                                                    left: 10.0),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
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
                        width: screen.context.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "area".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (controller.selectedDistrict.value.areas !=
                                    null) {
                                  _showAreaDialog(
                                      controller.selectedDistrict.value.areas,
                                      screen.context.size);
                                } else {
                                  CustomDialog.showStringDialog(
                                      "Please Select district first..!");
                                }
                              },
                              child: Container(
                                // margin: EdgeInsets.all(8),
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
                          fontFamily: 'Rubik',
                          fontSize: 16,
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
                                    cursorColor: Colors.black,
                                    // initialValue: controller.selectedPlace
                                    //             .value.formattedAddress ==
                                    //         null
                                    //     ? "address".tr
                                    //     : controller.selectedPlace.value
                                    //         .formattedAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "address".tr,
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
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Get.to(PlacePicker(
                                    //   apiKey: GMAP_API,
                                    //   initialPosition:
                                    //       controller.initialPosition,
                                    //   useCurrentLocation: true,
                                    //   selectInitialPosition: true,
                                    //   onPlacePicked: (result) {
                                    //     controller.selectedPlace.value = result;
                                    //     print("FFS: $result");
                                    //     print(controller
                                    //         .selectedPlace.value.name);
                                    //     Get.back();
                                    //   },
                                    // ));
                                  },
                                  child: Container(
                                    height: 35,
                                    child: Image(
                                      image: AssetImage('images/mapIcon.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "press_the_blue_map_icon_and_select_your_store_location_in_map"
                              .tr,
                          style: TextStyle(
                              color: DEFAULT_BLACK,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "referral_id_optional".tr,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
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
                            child: TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Referral ID",
                              ),
                              onSaved: (value) {
                                controller.referralCode.value = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      getDefaultBlueButton(screen.context, 'create_shop'.tr,
                          () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          await controller.createShop();
                        }
                      }),
                      SizedBox(height: 35),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            "cancel".tr,
                            style: TextStyle(
                                color: DEFAULT_BLUE,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
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

  _showShopTypeDialog(List<ShopType> shopTypes, Size size) {
    final CreateShopController controller = Get.find();
    Get.defaultDialog(
      radius: 4,
      barrierDismissible: false,
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
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.grey,
                      elevation: 0.0),
                  onPressed: () {
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
                                fontSize: 16,
                                color: DEFAULT_BLUE,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Rubik"),
                          )),
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
      actions: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: Text(
              'close'.tr,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        )
      ],
    );
  }

  _showDivisionDialog(List<Division> divisions, Size size) {
    final CreateShopController controller = Get.find();
    try {
      showDialog(
          context: screen.context,
          builder: (_) => KeyboardAwareDialog(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select Division",
                        style: TextStyle(
                            color: DEFAULT_BLACK,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              cursorColor: DEFAULT_BLACK,
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.grey,
                                          elevation: 0.0),
                                      onPressed: () {
                                        controller.selectedDivision.value =
                                            controller.divisionSearch[index];

                                        controller.districtSearch.assignAll(
                                            controller.selectedDivision.value
                                                .districts);

                                        navigator.pop();
                                        _showDistrictDialog(
                                            controller.selectedDivision.value
                                                .districts,
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
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                          child: Text(
                            'close'.tr,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ));
      // }
    } catch (e) {}
  }

  _showDistrictDialog(List<District> districts, Size size) {
    final CreateShopController controller = Get.find();
    try {
      showDialog(
          context: screen.context,
          builder: (_) => KeyboardAwareDialog(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select Ditrict",
                        style: TextStyle(
                            color: DEFAULT_BLACK,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.grey,
                                          elevation: 0.0),
                                      onPressed: () {
                                        controller.selectedDistrict.value =
                                            controller.districtSearch[index];

                                        controller.areaSearch.assignAll(
                                            controller
                                                .selectedDistrict.value.areas);
                                        Navigator.pop(context);
                                        _showAreaDialog(
                                          controller
                                              .districtSearch[index].areas,
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
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                          child: Text(
                            'close'.tr,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ));
      // }
    } catch (e) {}
  }

  _showAreaDialog(List<Area> areas, Size size) {
    final CreateShopController controller = Get.find();
    showDialog(
        context: screen.context,
        builder: (_) => KeyboardAwareDialog(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select Area",
                      style: TextStyle(
                          color: DEFAULT_BLACK,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
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
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Colors.grey,
                                        elevation: 0.0),
                                    onPressed: () {
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
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextButton(
                        child: Text(
                          'close'.tr,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  _showPictureOptionDialogue() {
    final CreateShopController controller = Get.find();
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
}
