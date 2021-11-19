import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class EmiController extends GetxController {
  ApiService _apiService = ApiService();
  Future<dynamic> fetchAllEmi(
      //dynamic is nullable so if we didnt get any response we can handle it
      {
    String shopId,
  }) async {
    String url = "/digital_payment/emi_list?shop_id=18";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  fetchCustomer({String shopId}) async {
    String url = "/customer/all?shop_id=105";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }
}
