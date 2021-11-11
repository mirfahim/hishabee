import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/area_response_model.dart';

abstract class IAreaRepository {
  Future<List<Division>> getAllArea();
}
