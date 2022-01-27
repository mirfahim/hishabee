
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_naviagtion/due_page_routes.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_navigation/due_page_routs.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_details_controller.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_page/add_new_due.dart';
import 'package:intl/intl.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_app_bar.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_left_menue.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';

class DueItemDetails extends GetView<DueDetailsController> {
  const DueItemDetails({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final shopFeatureController = Get.find<ShopFeaturesController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: size.height,
                width: size.width - 250,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 25,
                                  color: DEFAULT_BLUE,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              Text('due_details'.tr,style: TextStyle(fontSize: 16,color: DEFAULT_BLUE),),
                            ],
                          ),
                        ),
                        Text('বাকির পরিমাণ'),
                        Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: DEFAULT_BLACK),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(()=> Text('${controller.selectedDueItem.value.amount.abs()}')),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('বিবরণ'),
                        Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: DEFAULT_BLACK),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(()=> Text('${controller.selectedDueItem.value.note ?? '[Not Given]'}')),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: DEFAULT_BLACK, width: 1),
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.calendar_today_rounded),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Obx(
                                        () => Text(
                                      DateFormat('dd MMMM yyyy').format(
                                          controller
                                              .dueDate.value),
                                      style: TextStyle(
                                          color: DEFAULT_BLACK,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: (){
                                Get.defaultDialog(
                                  title: "Are you sure?",
                                  content: Text('You want to delete this due record'),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Get.back();
                                    }, child: Text('Cancel',style: TextStyle(color: DEFAULT_BLUE),)),
                                    TextButton(onPressed: (){
                                      Get.back();
                                      controller.deleteDueItem();
                                    }, child: Text('Delete',style: TextStyle(color: DEFAULT_BLUE))),
                                  ],
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius:
                                  BorderRadius.circular(
                                      4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete,color: Colors.red,),
                                      SizedBox(width: 10,),
                                      Text('delete'.tr,style: TextStyle(color: DEFAULT_BLACK,fontSize: 20),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            InkWell(
                              onTap: (){
                                Get.toNamed(DuePageRoutes.ADD_DUE_PAGE,
                                  arguments: {
                                    'shop': controller.shop.value,
                                    "due": controller.due.value,
                                    'dueType' : controller.selectedDueItem.value.amount > 0 ? 0 : 1,
                                    'route': 2,
                                    'dueItem' : controller.selectedDueItem.value,
                                  },);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius:
                                  BorderRadius.circular(
                                      4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit,color: DEFAULT_BLUE,),
                                      SizedBox(width: 10,),
                                      Text('edit'.tr,style: TextStyle(color: DEFAULT_BLACK,fontSize: 20),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "select date",
      context: context,
      initialDate: controller.dueDate.value, // Refer step 1
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
    if (picked != null && picked != controller.dueDate.value) {
      controller.dueDate.value = picked;
    }
  }
}