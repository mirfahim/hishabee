import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:get/get.dart';

DateTime startDate = DateTime.now();
_selectStartDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    helpText: "start_date".tr,
    context: context,
    initialDate: startDate, // Refer step 1
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
  if (picked != null) {
    // setState(() {
    //   // widgets.controller.selectedStartDate.value = picked;
    //   startDate = picked;
    // });
  }
}

class DueNewTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: ElevatedButton(
          onPressed: () {},
          child: Center(
            child: Text(
              'save'.tr,
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
      ),
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'new_due'.tr,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: height,
            color: DEFAULT_BODY_BG_COLOR,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'select_type'.tr,
                    style: TextStyle(
                        color: Colors.black, fontSize: 16, fontFamily: 'Roboto'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 'কাস্টমার',
                        groupValue: 'groupValue',
                        onChanged: (value) {},
                        activeColor: Colors.blue,
                      ),
                      Text('customer'.tr, style: TextStyle(
                        fontSize: 14, fontFamily: 'Roboto',color: Color(0xFF232323)
                      ),),
                      Radio(
                        value: 'কাস্টমার',
                        groupValue: 'groupValue',
                        onChanged: (value) {},
                      ),
                      Text('supplier'.tr, style: TextStyle(
                          fontSize: 14, fontFamily: 'Roboto',color: Color(0xFF232323)
                      ),),
                      Radio(
                        value: 'কাস্টমার',
                        groupValue: 'groupValue',
                        onChanged: (value) {},
                      ),
                      Text('employee'.tr, style: TextStyle(
                          fontSize: 14, fontFamily: 'Roboto',color: Color(0xFF232323)
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'select_due_type'.tr,
                    style: TextStyle(
                        color: Color(0xFF232323), fontSize: 16, fontFamily: 'Roboto '),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              '৳receive/taken'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              '৳given/due'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('name'.tr, style: TextStyle(
                    fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w500
                  ),),
                  TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed:(){},
                          icon: Icon(Icons.arrow_drop_down,size: 30,),),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'name'.tr,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('mobile_number'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',fontWeight: FontWeight.w500
                  )),
                  TextFormField(
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
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'mobile_number'.tr,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('due_amount'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',fontWeight: FontWeight.w500
                  )),
                  TextFormField(
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
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'due_amount'.tr,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('description'.tr, style: TextStyle(
                  fontSize: 16, fontFamily: 'Roboto',fontWeight: FontWeight.w500
                  )),
                  TextFormField(
                    maxLines: 5,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z0-9]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'description'.tr,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35))
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('১৮ অক্টোবর , ২০২১'),
                          )
                      ), onTap: (){
                        _selectStartDate(context);
                      },),
                      InkWell(
                        onTap: (){},
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset('images/svg_image/receipt_add.svg'),
                                  SizedBox(width: 5,),
                                  Text('রিসিপ্ট যুক্ত করুন'),
                                ],
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 30,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.35),
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'sms_free_20'.tr,
                              style: TextStyle(color: Colors.blue),
                            ),
                            Switch(
                              onChanged: (bool value) {},
                              value: true,
                              activeColor: DEFAULT_BLUE,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
