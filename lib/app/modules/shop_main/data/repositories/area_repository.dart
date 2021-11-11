import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_area_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/area_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/area_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_area_repository.dart';

class AreaRepository implements IAreaRepository {
  final IAreaProvider areaProvider;
  final ILocalAreaProvider localAreaProvider;
  final INetworkInfo networkInfo;

  AreaRepository(this.areaProvider, this.localAreaProvider, this.networkInfo);

  @override
  Future<List<Division>> getAllArea() async {
    if (await networkInfo.isConnected()) {
      final response = await areaProvider.getAllArea();
      if (response.hasError) {
        return Future.error(response.statusText);
      }
      localAreaProvider.saveAllArea(response.body);
      return response.body;
    } else {
      try {
        final result = await localAreaProvider.getAllArea();
        return result;
      } catch (e) {
        return Future.error(e);
      }
    }
  }
}
