import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';

class BoController extends GetxController {
  ApiService _apiService = ApiService();
  Future<dynamic> fetchOverview(
      //dynamic is nullable so if we didnt get any response we can handle it
      {String shopId,
      String statDate,
      String endDate}) async {
    String url =
        "/overview?shop_id=105&start_date=2021-01-8&end_date=2021-10-8";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> fetchProductWiseReport(
      {String shopId, String statDate, String endDate}) async {
    String url =
        "/overview/product?shop_id=105&start_date=2021-01-8&end_date=2021-10-8";
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  fetchCustomerWiseReport({String shopId, String statDate, String endDate}) {
    String url =
        "/overview/customer?shop_id=105&start_date=2021-01-8&end_date=2021-10-8";
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }
}
