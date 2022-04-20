import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';

class TransactionNewController extends GetxController {
  ApiService _apiService = ApiService();
  RxInt count = 0.obs;
  RxInt countAdd = 0.obs;
  Future<dynamic> fetchOverview(
      //dynamic is nullable so if we didnt get any response we can handle it
      {String shopId,
      String startDate,
      String endDate}) async {
    String url =
        "/overview?shop_id=$shopId&start_date=$startDate&end_date=$endDate";
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> fetchProductWiseReport(
      {String shopId, String startDate, String endDate}) async {
    String url =
        "/overview/product?shop_id=$shopId&start_date=$startDate&end_date=$endDate";
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  fetchCustomerWiseReport({String shopId, String startDate, String endDate}) {
    String url =
        "/overview/customer?shop_id=$shopId&start_date=$startDate&end_date=$endDate";
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  fetchEmployeWiseReport({String shopId, String startDate, String endDate}) {
    String url =
        "/overview/employee?shop_id=$shopId&start_date=$startDate&end_date=$endDate";
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }
}
