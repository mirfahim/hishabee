import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/digital_payment_registration/important_infromation.dart';

class AccountSelection extends StatefulWidget {

  @override
  State<AccountSelection> createState() => _AccountSelectionState();
}

class _AccountSelectionState extends State<AccountSelection> {
  String _selectedUnit = '';
  List _getAllUnit = ['1','2','3'];
  String radioValue;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: (){
            Get.to(ImportantInformation());
          },
          child: Container(
            height: 40,
            width: width,
            decoration: BoxDecoration(
                color: DEFAULT_BLUE,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text('proceed'.tr, style: TextStyle(
                    fontSize: 16, color: Colors.white
                ),),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('select_account'.tr,),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('type_of_business'.tr, style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600,
                  color: Color(0xFF232323)
                ),),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('more_information_regarding_digital_payment'.tr, style: TextStyle(
                            fontSize: 14, color: Colors.white
                        ),),
                        Radio(
                          activeColor: Colors.white,
                          value: radioValue,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35), width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('partnership'.tr, style: TextStyle(
                            fontSize: 14, color: Color(0xFF141414)
                        ),),
                        Radio(
                          activeColor: Colors.grey,
                          value: radioValue,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35), width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('private_limited_company'.tr, style: TextStyle(
                            fontSize: 14, color: Color(0xFF141414)
                        ),),
                        Radio(
                          activeColor: Colors.grey,
                          value: radioValue,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35), width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('alumni_club'.tr, style: TextStyle(
                            fontSize: 14, color: Color(0xFF141414)
                        ),),
                        Radio(
                          activeColor: Colors.grey,
                          value: radioValue,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35), width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('donation'.tr, style: TextStyle(
                            fontSize: 14, color: Color(0xFF141414)
                        ),),
                        Radio(
                          activeColor: Colors.grey,
                          value: radioValue,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35), width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('event'.tr, style: TextStyle(
                            fontSize: 14, color: Color(0xFF141414)
                        ),),
                        Radio(
                          activeColor: Colors.grey,
                          value: radioValue,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35), width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('educational_institute'.tr, style: TextStyle(
                            fontSize: 14, color: Color(0xFF141414)
                        ),),
                        Radio(
                          activeColor: Colors.grey,
                          value: radioValue,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Color(0xFFC4C4C4).withOpacity(.35),
                //     borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text('how_many_educated_person_you_have'.tr, style: TextStyle(
                //           fontSize: 14, color: Color(0xFF232323), fontWeight: FontWeight.w600
                //         ),),
                //         SizedBox(height: 10,),
                //         Text('combined_literate_number'.tr, style: TextStyle(
                //             fontSize: 14, color: Color(0xFF232323)
                //         ),),
                //         // Padding(
                //         //   padding:
                //         //   const EdgeInsets
                //         //       .symmetric(
                //         //       vertical: 8.0),
                //         //   child: Container(
                //         //     height: 48,
                //         //     child: TextFormField(
                //         //       inputFormatters: [
                //         //         FilteringTextInputFormatter
                //         //             .digitsOnly
                //         //       ],
                //         //       keyboardType:
                //         //       TextInputType
                //         //           .number,
                //         //       decoration:
                //         //       InputDecoration(
                //         //         suffixIcon:
                //         //         PopupMenuButton(
                //         //           icon: Icon(
                //         //             Icons
                //         //                 .arrow_drop_down,
                //         //             color: Color(
                //         //                 0xFF707070),
                //         //           ),
                //         //           itemBuilder: (context) =>
                //         //               _getAllUnit
                //         //                   .map((e) =>
                //         //                   PopupMenuItem(
                //         //                     child: Text(e.name),
                //         //                     value: e.name,
                //         //                   ))
                //         //                   .toList(),
                //         //           onSelected:
                //         //               (value) {
                //         //             setState(() {
                //         //               _selectedUnit =
                //         //                   value;
                //         //               print(
                //         //                   "my selected unit is $value");
                //         //             });
                //         //           },
                //         //         ),
                //         //         filled: true,
                //         //         fillColor:
                //         //         Colors.white,
                //         //         border: new OutlineInputBorder(
                //         //             borderSide:
                //         //             new BorderSide(
                //         //                 color:
                //         //                 Color(0xFFC4C4C4))),
                //         //         focusedBorder: new OutlineInputBorder(
                //         //             borderRadius:
                //         //             BorderRadius
                //         //                 .circular(
                //         //                 10),
                //         //             borderSide:
                //         //             new BorderSide(
                //         //                 color:
                //         //                 Color(0xFFC4C4C4))),
                //         //         enabledBorder: new OutlineInputBorder(
                //         //             borderRadius:
                //         //             BorderRadius
                //         //                 .circular(
                //         //                 10),
                //         //             borderSide:
                //         //             new BorderSide(
                //         //                 color:
                //         //                 Color(0xFFC4C4C4))),
                //         //         hintText: 'number'.tr,
                //         //         hintStyle: TextStyle(
                //         //             fontFamily:
                //         //             'Roboto',
                //         //             color: Colors
                //         //                 .blueGrey,
                //         //             fontSize: 12),
                //         //       ),
                //         //     ),
                //         //   ),
                //         // ),
                //       ],
                //     ),
                //   ),
                // )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
