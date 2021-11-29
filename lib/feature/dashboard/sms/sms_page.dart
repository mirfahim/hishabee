import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/contact_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_model.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SmsHistory extends StatefulWidget {
  const SmsHistory({Key key}) : super(key: key);

  @override
  _SmsHistoryState createState() => _SmsHistoryState();
}

class _SmsHistoryState extends State<SmsHistory> {
  SmsController _smsController = SmsController();
  final ScrollController _firstController = ScrollController();
  List<GetAllMessage> _getAllMessage;
  bool _isLoading = true;
  var storageSms = GetStorage('sms');

  @override
  void initState() {
    _smsController
        .fetchAllSms(shopId: '${storageSms.read("shop_id")}')
        .then((value) {
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
              ? Scrollbar(
                  controller: _firstController,
                  isAlwaysShown: true,
                  showTrackOnHover: true,
                  hoverThickness: 10,
                  thickness: 8,
                  radius: Radius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: ListView.builder(
                      itemCount: _getAllMessage.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_getAllMessage[index].number}',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('${_getAllMessage[index].message}')
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    '${convertDateTimeDisplay('${_getAllMessage[index].createdAt}')} | ${_getAllMessage[index].messageCount}',
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                          text:
                                              '${_getAllMessage[index].message.toString()}'),
                                    ).then(
                                      (value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Copied'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}
