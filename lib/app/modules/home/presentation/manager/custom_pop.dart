import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/splash_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/pages/splash_page.dart';

class CustomPopup extends StatefulWidget {
  @override
  _CustomPopupState createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  String _authStatus = 'Unknown';
  bool flag = false;
  var internalStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    // Can't show a dialog in initState, delaying initialization
    //  WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        // Show a custom explainer dialog before the system dialog
        if (await showCustomTrackingDialog(context)) {
          // Wait for dialog popping animation
          await Future.delayed(const Duration(milliseconds: 200));
          // Request system's tracking authorization dialog
          final TrackingStatus status =
              await AppTrackingTransparency.requestTrackingAuthorization();
          setState(() => _authStatus = '$status');
        }
      }
    } on PlatformException {
      // setState(() => _authStatus = 'PlatformException was thrown'
      //     // flag = true
      // );
      setState(() {
        _authStatus = 'PlatformException was thrown';
        flag = true;
      });
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    // print("UUID: $uuid");
  }

  Future<bool> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            '''
            To make the app experience better we collect some usage information. We assure you no personal data data is collected and used in this process. We care about your privacy and data security. To enable us better understand your need and how we can improve our services for you please allow the app tracking permission.

You can change your choice anytime in
the app settings.


            ''',
          ),
          actions: [
            TextButton(
              onPressed: () {
                internalStorage.write('track', 'false');
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => SplashPage()));
              },
              child: const Text("I'll decide later"),
            ),
            TextButton(
              onPressed: () {
                internalStorage.write('track', 'true');
                final SplashController controller = Get.find();
                Navigator.pop(context, true);
              },
              child: const Text('Allow tracking'),
            ),
          ],
        ),
      ) ??
      false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Text('Tracking status: $_authStatus\n'),
      ),
    );
  }
}
