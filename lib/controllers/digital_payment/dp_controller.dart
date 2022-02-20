import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class DpController extends GetxController {
  ApiService _apiService = ApiService();
  final _totalComplete = 0.0.obs;
  final _totalPending = 0.0.obs;
  final _totalCancel = 0.0.obs;

  Future<dynamic> fetchDp(
      //dynamic is nullable so if we didnt get any response we can handle it
      {int shopId}) async {
    String url =
        "/digital_payment/all?shop_id=$shopId"; //todo it should be dynamic later ....
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the list from this request
  }

  Future<dynamic> generatePaymentLink(
      //dynamic is nullable so if we didnt get any response we can handle it
      {String shopId,
      String amount}) async {
    String url =
        "/digital_payment/custom?shop_id=15&amount=50"; //todo it should be dynamic later ....
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the list from this request
  }
}
