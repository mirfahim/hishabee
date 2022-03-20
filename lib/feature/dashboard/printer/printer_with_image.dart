import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_services/sharedPref_service.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';

import 'add_printer.dart';
class PrinterWithImage extends StatefulWidget {


  @override
  State<PrinterWithImage> createState() => _PrinterWithImageState();
}

class _PrinterWithImageState extends State<PrinterWithImage> {
  Shop shop = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('printer'.tr, style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () {
            // SharedPref.to.prefss.getString('bluetooth_name').isEmpty ?
            Get.back();
            // :
            // Get.to(
            //     ShopFeatureShowCase(shop: shop),
            //   binding: ShopFeaturesBinding()
            // );
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {},
                child: SvgPicture.asset('images/svg_image/help.svg')),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text('${SharedPref.to.prefss.getString('bluetooth_name')}'),
                  leading: Icon(Icons.print),
                  subtitle: Text('${SharedPref.to.prefss.getString('bluetooth_address')}'),
                  trailing: InkWell(
                    onTap: (){
                      Get.to(AddPrinter(), arguments: shop);
                      SharedPref.to.prefss.remove('bluetooth_name');
                      SharedPref.to.prefss.remove('bluetooth_address');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFF00AF91)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('change'.tr, style: TextStyle(
                            fontSize: 14, color: Colors.white, fontFamily: 'Roboto'
                        ),),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: DEFAULT_BLUE)
                ),
                child: ListTile(
                  title: Text('printer_language'.tr, style: TextStyle(
                      fontSize: 14, fontFamily: 'Roboto'
                  ),),
                  subtitle: Text('bangla'.tr, style: TextStyle(
                      fontSize: 14, fontFamily: 'Roboto'
                  ),),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(height: 10,),

              SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}
