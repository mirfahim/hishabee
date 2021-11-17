import 'package:flutter/material.dart';

import 'customer_add_dialog.dart';

class DialogHelper {
  static exit(context) => showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
              Animation secondAnimation) =>
          SafeArea(child: CustomerAddFromContact()));
}
