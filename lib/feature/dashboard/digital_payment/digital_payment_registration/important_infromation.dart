import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/digital_payment/digital_payment_registration/personal_information.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ImportantInformation extends StatefulWidget {
  @override
  _ImportantInformationState createState() => _ImportantInformationState();
}

class _ImportantInformationState extends State<ImportantInformation> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'important_information'.tr,
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: DEFAULT_BLUE,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  'give_proper_information_to_start_digital_payment'
                                      .tr,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              CircularPercentIndicator(
                                radius: 30.0,
                                lineWidth: 10.0,
                                percent: 0.8,
                                center: Text(
                                  '80%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: 'Roboto'
                                  ),
                                ),
                                backgroundColor: DEFAULT_BLUE,
                                progressColor: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Stack(
                            children: [
                              Container(
                                height: 10,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(.5)
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFFECD1A)
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: (){
                      Get.to(PersonalInformation());
                    },
                    child: Card(
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          'personal_information'.tr
                                              .tr,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          'here_you_have_to_give_owners_information'.tr
                                              .tr,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Color(0xFF707070), fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircularPercentIndicator(
                                    radius: 30.0,
                                    lineWidth: 10.0,
                                    percent: 0.8,
                                    center: Text(
                                      '80%',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: DEFAULT_BLUE,
                                          fontFamily: 'Roboto'
                                      ),
                                    ),
                                    backgroundColor: Colors.white ,
                                    progressColor: DEFAULT_BLUE,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'organization_information'.tr
                                            .tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'here_you_have_to_give_organization_information'.tr
                                            .tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Color(0xFF707070), fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 10.0,
                                  percent: 0.8,
                                  center: Text(
                                    '80%',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: DEFAULT_BLUE,
                                        fontFamily: 'Roboto'
                                    ),
                                  ),
                                  backgroundColor: Colors.white ,
                                  progressColor: DEFAULT_BLUE,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'important_papers'.tr
                                            .tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'business_related_important_information'.tr
                                            .tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Color(0xFF707070), fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 10.0,
                                  percent: 0.8,
                                  center: Text(
                                    '80%',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: DEFAULT_BLUE,
                                        fontFamily: 'Roboto'
                                    ),
                                  ),
                                  backgroundColor: Colors.white ,
                                  progressColor: DEFAULT_BLUE,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'voter_id_card_and_picture'.tr
                                            .tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'voter_id_card_owner'.tr
                                            .tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Color(0xFF707070), fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 10.0,
                                  percent: 0.8,
                                  center: Text(
                                    '70%',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: DEFAULT_BLUE,
                                        fontFamily: 'Roboto'
                                    ),
                                  ),
                                  backgroundColor: Colors.white ,
                                  progressColor: DEFAULT_BLUE,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'bank_info'.tr
                                            .tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'provide_bank_info'.tr
                                            .tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Color(0xFF707070), fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 10.0,
                                  percent: 0.4,
                                  center: Text(
                                    '40%',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: DEFAULT_BLUE,
                                        fontFamily: 'Roboto'
                                    ),
                                  ),
                                  backgroundColor: Colors.white ,
                                  progressColor: DEFAULT_BLUE,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFEBEFF2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('images/svg_image/digital_payment/security.svg'),
                        Text('100%_secured'.tr, style: TextStyle(
                          fontSize: 14, color: DEFAULT_BLUE, fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
