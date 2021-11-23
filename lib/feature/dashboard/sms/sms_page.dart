import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_model.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SmsHistory extends StatefulWidget {
  const SmsHistory({Key key}) : super(key: key);

  @override
  _SmsHistoryState createState() => _SmsHistoryState();
}

class _SmsHistoryState extends State<SmsHistory> {
  SmsController _smsController = SmsController();
  List<GetAllMessage> _getAllMessage;
  bool _isLoading = true;
  var storageSms = GetStorage('sms');
  @override
  void initState() {
    _smsController.fetchAllSms(shopId: '${storageSms.read("shop_id")}').then((value) {
      setState(() {
        _getAllMessage = getSmsFromModel(value);
        _isLoading = false;
      });
    });
  print(storageSms.read("shop_id"));
    super.initState();
  }

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
        body: LoadingOverlay(
          isLoading: _isLoading,
          child: _getAllMessage != null
              ? SingleChildScrollView(
                  child: ListView.builder(
                    itemCount: _getAllMessage.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        child:
                            Text('${_getAllMessage[index].message.toString()}'),
                      );
                    },
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
