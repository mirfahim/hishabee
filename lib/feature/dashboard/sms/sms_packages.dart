import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/sms_page.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_package_model.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SMSPackages extends StatefulWidget {
  @override
  State<SMSPackages> createState() => _SMSPackagesState();
}

class _SMSPackagesState extends State<SMSPackages> {
  SmsController _smsController = Get.put(SmsController());
  bool _isLoading = true;
  List<SmsPackages> _smsPackages;

  @override
  void initState() {
    _smsController.fetchSmsPackage().then((value) {
      setState(() {
        _smsPackages = getSmsPackagesFromModel(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.amber,
            title: const Text('SMS'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.to(SmsHistory());
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.history),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Message History')
                    ],
                  ),
                ),
              )
            ],
          ),
          body:
              // LoadingOverlay(
              //   isLoading: _isLoading,
              //   child: _smsPackages != null
              //       ?
              ListView.builder(
                  itemCount: _smsPackages.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: SizedBox(
                        height: 80,
                        child: Card(
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Column(
                                  children: [
                                    Text(
                                      _smsPackages[index].smsAmount.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'S M S',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const VerticalDivider(
                                width: 10,
                                thickness: 1,
                                color: Colors.black,
                                indent: 10,
                                endIndent: 10,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '৳${_smsPackages[index].price.toString()}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        )),
                                    Text(
                                        'Per SMS ${(_smsPackages[index].price.toInt() / _smsPackages[index].smsAmount.toInt())} TK only',
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
          // : Container(),
          // ),
          ),
    );
  }
}
