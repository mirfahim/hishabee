import 'package:get/get.dart';

import 'bn_BD.dart';
import 'en_US.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'bn_BD': bn_BD,
      };
}
