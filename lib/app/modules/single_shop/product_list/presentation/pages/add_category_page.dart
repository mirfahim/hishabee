import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/add_category_controller.dart';

class AddCategoryPage extends GetView<AddCategoryController> {
  const AddCategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Stack(
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
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 25,
                                color: DEFAULT_BLACK,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Text(
                              'New Category',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Container(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 10),
                            child: Text(
                              "category".tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showCategoryDialog(controller, size, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 10, top: 8),
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
                                        child: Obx(
                                          () => Text(
                                            controller.selectedCategory.value
                                                        .name ==
                                                    null
                                                ? "select_category".tr
                                                : controller.selectedCategory
                                                    .value.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLACK,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 15, right: 15),
                            child: Text(
                              "sub_category".tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: DEFAULT_BLACK,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 15, right: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: TextFormField(
                                cursorColor: DEFAULT_BLACK,
                                keyboardType: TextInputType.text,
                                maxLength: 11,
                                onChanged: (value) {
                                  controller.subCatName.value = value;
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: 'Sub category name',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 50.0,
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
                                    controller.saveSubProductCategory();
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
                            ),
                          )
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
    );
  }

  _showCategoryDialog(
      AddCategoryController controller, Size size, BuildContext context) {
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
                          controller.searchCategoryName(value);
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
                            itemCount: controller.searchCategory.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedCategory.value =
                                      controller.searchCategory[index];
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          controller.searchCategory[index].icon,
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
                                                  .searchCategory[index].name,
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
}
