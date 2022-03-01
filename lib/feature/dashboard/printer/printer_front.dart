import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/printer/add_printer.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/printer/print_page.dart';
import 'package:intl/intl.dart';
class PrinterFront extends StatefulWidget {

  @override
  State<PrinterFront> createState() => _PrinterFrontState();
}

class _PrinterFrontState extends State<PrinterFront> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  Shop shop = Get.arguments;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('printer'.tr),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('images/svg_image/printer_front.svg'),
            SizedBox(height: 20,),
            Text('there_is_no_printer'.tr, style: TextStyle(
              fontSize: 18, fontFamily: 'Roboto'
            ),),
            SizedBox(height: 10,),
            Text('to_add_printer_click_buy_button'.tr,textAlign: TextAlign.center, style: TextStyle(
              fontSize: 18, fontFamily: 'Roboto'
            ),),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                    color: DEFAULT_BLUE,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0,vertical: 8),
                  child: Text('buy_it'.tr,style: TextStyle(
                      fontSize: 18, fontFamily: 'Roboto',color: Colors.white
                  ),),
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Get.to(
                    AddPrinter(),
                  arguments: shop
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
                  child: Text('add'.tr,style: TextStyle(
                      fontSize: 18, fontFamily: 'Roboto',color: DEFAULT_BLUE
                  ),),
                ),
              ),
            ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         primary:Color(0xFFF8F9FA),
            //         fixedSize: Size(120, 30),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10)
            //         )
            //     ),
            //     onPressed: (){}, child: Text('add'.tr,style: TextStyle(
            //     fontSize: 18, fontFamily: 'Roboto',color: DEFAULT_BLUE
            // ),))
          ],
        ),
      ),
    );
  }

}
