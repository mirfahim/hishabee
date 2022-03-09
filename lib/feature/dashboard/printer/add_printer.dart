import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/local/models/contact_us_model.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/printer/print_page.dart';
class AddPrinter extends StatelessWidget {

  Shop shop = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: InkWell(
          onTap: (){
            Get.to(
                PrintPage(),
              arguments: shop
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: DEFAULT_BLUE,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('proceed'.tr,textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 18, fontFamily: 'Roboto',color: Colors.white
              ),),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('printer'.tr,style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('steps_to_add_printer'.tr, style: TextStyle(
              fontSize: 18, fontFamily: 'Roboto'
            ),),
            SizedBox(height: 10,),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: DEFAULT_BLUE)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('1'.tr, style: TextStyle(),),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('printer_switch_on'.tr, style: TextStyle(
                              fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w700
                            ),),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /1.25,
                              child: Text('first_turn_the_printer_on_by_pressing_the_power_button'.tr, style: TextStyle(
                                fontSize: 14, fontFamily: 'Roboto',
                              ),),
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: DEFAULT_BLUE)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('2'.tr, style: TextStyle(),),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('give_permission_to_bluetooth'.tr, style: TextStyle(
                                fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w700
                            ),),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /1.25,
                              child: Text('if_you_want_to_on_bluetooth_on_your_device_click_allow'.tr, style: TextStyle(
                                fontSize: 14, fontFamily: 'Roboto',
                              ),),
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: DEFAULT_BLUE)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('3'.tr, style: TextStyle(),),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('pin_number'.tr, style: TextStyle(
                                fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w700
                            ),),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /1.25,
                              child: Text('find_pin_number_bluetooth'.tr, style: TextStyle(
                                fontSize: 14, fontFamily: 'Roboto',
                              ),),
                            )

                          ],
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
    );
  }
}
