import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/data/models/get_all_message_model.dart';

class SmsHistory extends GetResponsiveView {
  // final Shop shop;
  // final GetAllMessage getAllMessage;
  //
  // SmsHistory(this.shop, this.getAllMessage);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('S M S'),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Text('${GetAllMessage().number}'),
          ),
        ),
      ),
    );
  }
}
