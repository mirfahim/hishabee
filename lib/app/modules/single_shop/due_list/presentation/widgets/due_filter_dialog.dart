import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';

class DueFilterDialog extends GetView<DueFrontController> {
  const DueFilterDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        color: DEFAULT_BODY_BG_COLOR,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('ফিল্টার'), Icon(Icons.cut)],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'তারিখ নির্বাচন করুন',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GroupButton(
                  spacing: size.width * 0.05,
                  isRadio: true,
                  borderRadius: BorderRadius.circular(8),
                  textPadding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  unselectedBorderColor: DEFAULT_BLACK,
                  selectedColor: Colors.black,
                  unselectedColor: Colors.white,
                  direction: Axis.horizontal,
                  unselectedTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: DEFAULT_BLUE,
                  ),
                  onSelected: (index, isSelected) {
                    switch (index) {
                      case 0:
                        controller.selectedStartDate.value = DateTime.now();
                        controller.selectedEndDate.value = DateTime.now();
                        controller.dateDiff.value = controller
                            .selectedStartDate.value
                            .difference(controller.selectedEndDate.value)
                            .inDays;
                        break;
                      case 1:
                        final now = DateTime.now();
                        controller.selectedStartDate.value =
                            DateTime(now.year, now.month, now.day - 1);
                        controller.selectedEndDate.value =
                            DateTime(now.year, now.month, now.day - 1);
                        controller.dateDiff.value = controller
                            .selectedStartDate.value
                            .difference(controller.selectedEndDate.value)
                            .inDays;
                        break;
                      case 2:
                        final now = DateTime.now();
                        controller.selectedStartDate.value =
                            DateTime(now.year, now.month, now.day - 7);
                        controller.selectedEndDate.value =
                            DateTime(now.year, now.month, now.day);
                        controller.dateDiff.value = controller
                            .selectedStartDate.value
                            .difference(controller.selectedEndDate.value)
                            .inDays;
                        break;
                      case 3:
                        final now = DateTime.now();
                        controller.selectedStartDate.value =
                            DateTime(now.year, now.month, 1);
                        controller.selectedEndDate.value =
                            DateTime(now.year, now.month, now.day);
                        controller.dateDiff.value = controller
                            .selectedStartDate.value
                            .difference(controller.selectedEndDate.value)
                            .inDays;
                        break;
                      case 4:
                        final now = DateTime.now();
                        controller.selectedStartDate.value =
                            DateTime(now.year, now.month - 1, 1);
                        controller.selectedEndDate.value =
                            DateTime(now.year, now.month - 1, 30);
                        controller.dateDiff.value = controller
                            .selectedStartDate.value
                            .difference(controller.selectedEndDate.value)
                            .inDays;
                        break;
                      case 5:
                        getDialog(context);
                        break;
                    }
                  },
                  buttons: [
                    'আজ',
                    'গতকাল',
                    'গত ৭ দিন',
                    'এই মাস',
                    'গত মাস',
                    'সময় সীমা',
                  ],
                  selectedButton: 0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'শ্রেনী নির্বাচন করুন',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                    () => RadioGroup.builder(
                  horizontalAlignment: MainAxisAlignment.start,
                  activeColor: DEFAULT_BLACK,
                  groupValue: controller.selectedClassStatus.value,
                  spacebetween: 40,
                  direction: Axis.horizontal,
                  onChanged: (value) {
                    controller.selectedClassStatus.value = value;
                    print(controller.selectedClassStatus.value);
                  },
                  items: controller.classStatus,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'বাকির ধরণ নির্বাচন করুন',
                style: TextStyle(fontSize: 16),
              ),
              Obx(
                    () => RadioGroup.builder(
                  horizontalAlignment: MainAxisAlignment.start,
                  activeColor: DEFAULT_BLACK,
                  groupValue: controller.selectedDueStatus.value,
                  spacebetween: 40,
                  direction: Axis.horizontal,
                  onChanged: (value) {
                    controller.selectedDueStatus.value = value;
                  },
                  items: controller.dueStatus,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    controller.customFilter();
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      'নিশ্চিত',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: DEFAULT_BLUE,
                    fixedSize: Size(width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  getDialog(BuildContext context) async {
    await _selectStartDate(context);
    //await _selectEndDate(context);
  }
  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "start_date".tr,
      context: context,
      initialDate: controller.selectedStartDate.value, // Refer step 1
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
      controller.selectedStartDate.value = DateTime(picked.day,picked.month,picked.year);
      print(controller.selectedStartDate.value);
      _selectEndDate(context);
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "end_date".tr,
      context: context,
      initialDate: controller.selectedEndDate.value, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: DEFAULT_BLACK,
              onPrimary: DEFAULT_BODY_BG_COLOR,
              surface: Colors.redAccent,
              onSurface: DEFAULT_BLACK,
            ),
            dialogBackgroundColor: DEFAULT_BODY_BG_COLOR,
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != controller.selectedEndDate.value) {
      controller.selectedEndDate.value = DateTime(picked.day,picked.month,picked.year);
    }
  }
}
