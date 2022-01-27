import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/add_edit_due_controller.dart';
import 'package:intl/intl.dart';

import '../../../../../../new_UI/constants.dart';
import '../../../contacts/data/remote/models/contact_model.dart';

class DueNew extends GetView<DueEditAddController>{
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height,
              width: size.width - 250,
              child: SingleChildScrollView(
                child: Container(
                  color: DEFAULT_BODY_BG_COLOR,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                              Text('add_due'.tr,style: TextStyle(fontSize: 16,color: DEFAULT_BLUE),),
                            ],
                          ),
                        ),
                        Text(
                          'শ্রেনী নির্বাচন করুন',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                              ()=> RadioGroup.builder(
                            horizontalAlignment: MainAxisAlignment.start,
                            activeColor: DEFAULT_BLACK,
                            groupValue: controller.selectedClassStatus.value,
                            spacebetween: 40,
                            direction: Axis.horizontal,
                            onChanged: (value) {
                              controller.selectedEmployee.value = null;
                              controller.selectedCustomer.value = null;
                              controller.selectedSupplier.value = null;
                              controller.nameTextEditingController.value.text = '';
                              controller.numberTextEditingController.value.text = '';
                              controller.selectedClassStatus.value = value;
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
                          style: TextStyle(
                              color: Colors.black, fontSize: 14, fontFamily: 'Rubik'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Obx(
                                ()=> GroupButton(
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
                                    controller.dueType.value = 0;
                                    break;
                                  case 1:
                                    controller.dueType.value = 1;
                                    break;
                                }
                              },
                              buttons: [
                                'দিলাম/বাকি',
                                'নিলাম/জমা',
                              ],
                              selectedButton: controller.dueType.value,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('নাম'),
                        Obx(
                              ()=> Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 0.75,
                                  child: TextFormField(
                                    controller: controller.nameTextEditingController.value,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                      hintText: 'নাম',
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){
                                    contactDialog(context);
                                  },
                                  icon: Icon(Icons.arrow_drop_down,size: 30,color: DEFAULT_BLACK,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('মোবাইল নাম্বার'),
                        Obx(
                              ()=> TextFormField(
                            controller:controller.numberTextEditingController.value,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              counterText: "",
                              hintText: 'মোবাইল নাম্বার',
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('বাকির পরিমাণ'),
                        Form(
                          key: controller.formKey,
                          child:Obx(
                                ()=> TextFormField(
                              initialValue: controller.selectedDueItem.value.amount.toString() ?? '',
                              validator: (value){
                                if(value.isEmpty){
                                  return 'Due Amount Should not be empty';
                                }
                                return null;
                              },
                              onSaved: (value){
                                controller.dueAmount.value = int.parse(value);
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]'),
                                ),
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                hintText: 'বাকির পরিমাণ',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('বিবরণ ( না দিলেও হবে)'),
                        TextFormField(
                          onChanged: (value){
                            controller.dueDetails.value = value;
                          },
                          maxLines: 5,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4)),
                            hintText: 'বিবরণ',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black26,
                            ),
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
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: 210,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.35),
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Text(
                                    'এস এম এস - ফ্রি (২০)',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  Obx(
                                        ()=> FlutterSwitch(
                                        value: controller.sms.value,
                                        onToggle: (value){
                                          if(controller.sms.value){
                                            controller.sms.value = false;
                                          }else{
                                            controller.sms.value = true;
                                          }
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.addNewDue();
                          },
                          child: Center(
                            child: Text(
                              'সেভ করুন',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: DEFAULT_BLUE,
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
  contactDialog(BuildContext context) {
    final dueEditAddController = Get.find<DueEditAddController>();
    showDialog(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: new Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 18.0,
                  left: 10,
                ),
                child: Text(
                  "Select Contact",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: TextField(
                        cursorColor: DEFAULT_BLACK,
                        onChanged: (value) {
                          //controller.searchEmployee(value);
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: DEFAULT_BLACK),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: DEFAULT_BLACK),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: DEFAULT_BLUE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                        () => ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.selectedClassStatus.value == "কাস্টমার" ? controller.customerList.length : controller.selectedClassStatus.value == "সাপ্লায়ার" ? controller.supplierList.length : controller.employeeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Contact item;
                        controller.selectedClassStatus.value == "কাস্টমার" ?
                        item = controller.customerList[index] :
                        controller.selectedClassStatus.value == "সাপ্লায়ার" ?
                        item = controller.supplierList[index] : item = controller.employeeList[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.selectedClassStatus.value == "কাস্টমার" ?
                                controller.selectedCustomer.value = item :
                                controller.selectedClassStatus.value == "সাপ্লায়ার" ?
                                controller.selectedSupplier.value = item : controller.selectedEmployee.value = item;
                                controller.nameTextEditingController.value.text = item.name;
                                controller.numberTextEditingController.value.text = item.mobile;
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${item.name} ( ${item.mobile} )",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: DEFAULT_BLACK,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: DEFAULT_BLACK,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "close".tr,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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