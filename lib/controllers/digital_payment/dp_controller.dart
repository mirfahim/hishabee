import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class DpController extends GetxController {
  //DP = Digital Payment . All the Module of digital payment is here
  ApiService _apiService = ApiService();
  Future<dynamic> fetchDp(
      //dynamic is nullable so if we didnt get any response we can handle it
      {String shopId}) async {
    String url =
        "/digital_payment/all?shop_id=105"; //todo it should be dynamic later ....
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the list from this request
  }
}
