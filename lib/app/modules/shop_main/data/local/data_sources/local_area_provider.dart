import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/area_response_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalAreaProvider {
  Future<List<Division>> getAllArea();

  Future<void> saveAllArea(List<Division> areas);
}

class LocalAreaProvider implements ILocalAreaProvider {
  final String boxKey = 'areaBox';
  final String areasKey = 'areas';

  @override
  Future<List<Division>> getAllArea() async {
    final areaBox = await Hive.openBox(boxKey);

    final areas = areaBox.get(areasKey);

    if (areas != null) {
      return areaResponseFromRawJson(jsonDecode(areas));
    } else {
      return Future.error("Catch error");
    }
  }

  @override
  Future<void> saveAllArea(List<Division> areas) async {
    final areaBox = await Hive.openBox(boxKey);

    return await areaBox.put(areasKey, areaResponseToJson(areas));
  }
}
