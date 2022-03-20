import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KnowMoreAboutEMI extends StatefulWidget {


  @override
  _KnowMoreAboutEMIState createState() => _KnowMoreAboutEMIState();
}

class _KnowMoreAboutEMIState extends State<KnowMoreAboutEMI> {

  EmiController _emiController = Get.find();
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.amber,
        title: Text('emi'.tr, style: TextStyle(
            color: Colors.black
        ),),
      ),
      body: SafeArea(
        child: Container(
          child: WebView(
            initialUrl: 'https://hishabee.business/bn/help/emi/?source=app',
          ),
        )
      ),
    );
  }
}
