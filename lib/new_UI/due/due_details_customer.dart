import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:get/get.dart';
class DueDetailsCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    'give/due'.tr,
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Roboto'),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  fixedSize: Size(width, 30),
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
                    'পেলাম/জমা',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Roboto'),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  fixedSize: Size(width, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Column(
          children: [
            Text(
              'dueList'.tr,
              style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Roboto'),
            ),
            Text(
              'তুসার টেলিকম',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
        titleSpacing: 0,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Container(
              // height: height - 470,
              // width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: DEFAULT_BLUE,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'এস এম আলীউজ্জামান',
                      style: TextStyle(color: Color(0xFFF1F1F1), fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '০১৭৮৮৬৫১৭৭৪',
                      style: TextStyle(color: Color(0xFFF1F1F1), fontSize: 14, fontFamily: 'Roboto'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'total_get :'.tr,
                              style: TextStyle(
                                  color: Color(0xFFFECD1A), fontSize: 16, fontFamily: 'Roboto'),
                            ),
                            Text(
                              '৳ 8,000',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20,fontFamily: 'Roboto' ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset('images/svg_image/phone_due.svg'),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset('images/svg_image/sms_due.svg'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Color(0xFFC4C4C4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'date_for_pay_due'.tr,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12, fontFamily: 'Roboto'),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'select_date'.tr,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12, fontFamily: 'Roboto'),
                            ),
                            SizedBox(width: 3,),
                            SvgPicture.asset('images/svg_image/calender.svg', color: Colors.white,)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'due_history'.tr,
                  style: TextStyle(color: Color(0xFF141414), fontSize: 16, fontFamily: 'Roboto'),
                ),
                Row(
                  children: [
                    Text(
                      'বাকি /',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontFamily: 'Roboto'),
                    ),
                    Text(
                      'জমা',
                      style: TextStyle(color: Colors.green, fontSize: 12, fontFamily: 'Roboto'),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('১৯ অক্টোবর , ২০২১', style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 14
                  ),),
                ),
                subtitle: Text('১০.৩৫ AM', style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 14
                ),),
                trailing: Text(
                  '৳ ১০৯৯',
                  style: TextStyle(color: Colors.green, fontFamily: 'Roboto', fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ElevatedButton(
            //         onPressed: () {},
            //         child: Center(
            //           child: Text(
            //             'give/due'.tr,
            //             textAlign: TextAlign.center,
            //             style:
            //                 TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Roboto'),
            //           ),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.red,
            //           fixedSize: Size(width, 20),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: ElevatedButton(
            //         onPressed: () {},
            //         child: Center(
            //           child: Text(
            //             'পেলাম/জমা',
            //             textAlign: TextAlign.center,
            //             style:
            //                 TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Roboto'),
            //           ),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.green,
            //           // fixedSize: Size(, 20),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
