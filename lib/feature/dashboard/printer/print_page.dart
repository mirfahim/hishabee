import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/app/_services/sharedPref_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/printer/printer_setting.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
class PrintPage extends StatefulWidget {


  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  Shop shop = Get.arguments;
  List<BluetoothDevice> _devices = [];

  String deviceMsg = '';

  // final f = NumberFormat("\$###, ###.00",'en_US');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_)=>{
      initPriner()
    });
    super.initState();
  }
  Future<void> initPriner(){
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    if(!mounted){

    }
    bluetoothPrint.scanResults.listen((val) {
      if(!mounted){

      }
      setState(() {
        _devices = val;
        if(_devices.isEmpty){
          setState(() {
            deviceMsg = 'No Device';
          });
        }
      });
    }

    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('printer'.tr, style: TextStyle(
          color: Colors.black
        ),),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        titleSpacing: 0,
      ),
      body: _devices.isEmpty ? Center(child: Text(deviceMsg ?? ''),) :
          ListView.builder(
            itemCount: _devices.length,
              itemBuilder: (c,i){
              return InkWell(
                onTap: (){
                  print('printer setting');
                  Get.to(
                      PrinterSetting(),
                    arguments: shop
                  );
                  SharedPref.to.prefss.setString('bluetooth_name', _devices[i].name);
                  SharedPref.to.prefss.setString('bluetooth_address',  _devices[i].address);
                },
                child: ListTile(
                  leading: Icon(Icons.print),
                  title: Text(_devices[i].name),
                  subtitle: Text(_devices[i].address),
                  onTap: (){
                    // _startPrint(_devices[i]);
                  },
                ),
              );
              })
    );
  }
  Future<void> _startPrint(BluetoothDevice device) async{
    if(device != null && device.address != null){
      await bluetoothPrint.connect(device);

      Map<String, dynamic> config = Map();
      List<LineText> list = [];
      
      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: 'GroceryApp',
        )
      );
    }
  }
}
