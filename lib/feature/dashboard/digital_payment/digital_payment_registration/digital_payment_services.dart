import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

import 'acount_selecttion.dart';

class DigitalPaymentService extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('digital_payment_services'.tr),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Center(child: SvgPicture.asset('images/svg_image/digital_payment/DP_phone.svg')),
                SizedBox(height: 10,),
                DottedBorder(
                  radius: Radius.circular(6),
                  borderType: BorderType.RRect,
                  dashPattern: [8, 4],
                  strokeWidth: 2,
                  color: Color(0xFF185ADB),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'how_to_use_digital_payment'.tr,
                            textAlign:
                            TextAlign.center,
                            style: TextStyle(
                                color:
                                Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 12
                            )),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SvgPicture.asset('images/svg_image/digital_payment/bank_card.svg'),
                                  SizedBox(height: 5,),
                                  Text('sell_bank_card'.tr, textAlign: TextAlign.center, style: TextStyle(
                                      fontFamily: 'Roboto',fontSize: 12,color: Color(0xFF232323)
                                  ),)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset('images/svg_image/digital_payment/mobile_banking.svg'),
                                    SizedBox(height: 5,),
                                    Text('sell_in_mobile_banking'.tr, textAlign: TextAlign.center, style: TextStyle(
                                        fontFamily: 'Roboto',fontSize: 12,color: Color(0xFF232323)
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset('images/svg_image/digital_payment/emi_services.svg'),
                                    SizedBox(height: 5,),
                                    Text('sell_in_emi'.tr, textAlign: TextAlign.center, style: TextStyle(
                                        fontFamily: 'Roboto',fontSize: 12,color: Color(0xFF232323)
                                    ),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: new BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xFFC4C4C4).withOpacity(.35),
                        offset: const Offset(
                          2.0,
                          8.0,
                        ),
                        blurRadius: 20.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                      child: Column(
                        children: [
                          Center(
                            child: Text('usefulness_of_digital_payment'.tr, style: TextStyle(
                                fontSize: 14, color: Color(0xFF232323)
                            ),),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.check_circle,color: DEFAULT_BLUE,),
                              SizedBox(width: 5,),
                              Text('digital_collection'.tr, style: TextStyle(
                                  fontSize: 12, color: Color(0xFF232323)
                              ),)
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(Icons.check_circle,color: DEFAULT_BLUE,),
                              SizedBox(width: 5,),
                              Text('EMI_service'.tr, style: TextStyle(
                                  fontSize: 12, color: Color(0xFF232323)
                              ),)
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(Icons.check_circle,color: DEFAULT_BLUE,),
                              SizedBox(width: 5,),
                              Text('payment_service_in_online'.tr, style: TextStyle(
                                  fontSize: 12, color: Color(0xFF232323)
                              ),)
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(Icons.check_circle,color: DEFAULT_BLUE,),
                              SizedBox(width: 5,),
                              Text('100%_safe_and_secured'.tr, style: TextStyle(
                                  fontSize: 12, color: Color(0xFF232323)
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4).withOpacity(.5),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('more_information_regarding_digital_payment'.tr, style: TextStyle(
                          fontSize: 14, color: Color(0xFF141414)
                        ),),
                        SizedBox(width: 5,),
                        Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF141414),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Get.to(AccountSelection());
                  },
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text('registration_for_payment_service'.tr, style: TextStyle(
                          fontSize: 16, color: Colors.white
                        ),),
                      ),
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
