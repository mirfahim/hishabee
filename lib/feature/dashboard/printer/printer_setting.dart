import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_services/sharedPref_service.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/_binding/shop_features_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/pages/shop_features_page.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/printer/print_page.dart';

import 'add_printer.dart';
class PrinterSetting extends StatefulWidget {

  // String deviceName;
  // String deviceAddress;
  // PrinterSetting({this.deviceName, this.deviceAddress});
  @override
  _PrinterSettingState createState() => _PrinterSettingState();
}

class _PrinterSettingState extends State<PrinterSetting> {

  Shop shop = Get.arguments;
  
  List<String> printerFontSize = ['8','10','12','14','16','18','20','24'];
  String dropdownValue = '8';
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('printer'.tr),
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
          icon: Icon(Icons.arrow_back),
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: DEFAULT_BLUE)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('printer_font'.tr, style: TextStyle(
                          fontSize: 14, fontFamily: 'Roboto'
                      ),),
                    ),
                    DropdownButton(
                      onChanged: (value){
                        setState(() {
                          dropdownValue = value;
                        });
                      },
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      items: printerFontSize.map((String e) => DropdownMenuItem(
                        value: e,
                          child: Text(e))).toList(),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: DEFAULT_BLUE)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('print_online_store_qr'.tr, style: TextStyle(
                          fontSize: 14, fontFamily: 'Roboto'
                      ),),
                    ),
                    Switch(value: switchValue,activeColor: DEFAULT_BLUE, onChanged: (value){
                      setState(() {
                        switchValue = value;
                      });
                    })
                  ],
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  _displayTextInputDialog(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: DEFAULT_BLUE)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
                        child: Text('custom_text'.tr, style: TextStyle(
                            fontSize: 14, fontFamily: 'Roboto'
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: Column(
              children: [
                TextField(
                  onChanged: (value) {

                  },
                  // controller: _textFieldController,
                  decoration: InputDecoration(hintText: "Text Field in Dialog"),
                ),
                TextButton(onPressed: (){
                  Get.back();
                },
                    child: Text('ok'.tr, style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 14, color: Colors.black
                    ),))
              ],
            ),

          );
        });
  }
}
