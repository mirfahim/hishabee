import 'package:freezed_annotation/freezed_annotation.dart';
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

  Future<dynamic> submitEmi(
      {String shop_id,
      String amount,
      String customerName,
      String customerPhone,
      String customerAddress,
      String installment,
      String payable}) async {
    String url =
        "digital_payment/emi?shop_id=$shop_id&amount=$amount&customer_name=$customerName&customer_mobile=$customerPhone&customer_address=$customerAddress&installment=$installment&payable_amount=$payable";
    print("POST REQUEST APP");
    print(_apiService.makeApiRequiest(
        method: apiMethods.post, url: url, body: null, headers: null));
    return _apiService.makeApiRequiest(
        method: apiMethods.post,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }
}
