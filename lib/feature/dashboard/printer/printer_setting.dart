import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class PrinterSetting extends StatefulWidget {

  String deviceName;
  String deviceAddress;
  PrinterSetting({this.deviceName, this.deviceAddress});
  @override
  _PrinterSettingState createState() => _PrinterSettingState();
}

class _PrinterSettingState extends State<PrinterSetting> {
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {},
                child: SvgPicture.asset('images/svg_image/help.svg')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(widget.deviceName),
                leading: Icon(Icons.print),
                subtitle: Text(widget.deviceAddress),
                trailing: InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6)
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
