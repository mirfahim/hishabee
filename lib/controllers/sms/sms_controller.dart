import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/models/sms/create_sms_model.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_package_model.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class SmsController extends GetxController {
  final maxLengthForText = 160.obs;
  final textInTheMessageField = ''.obs;
  final messageCount = 1.obs;
  final mobileNumbers = ''.obs;
  final smsCount = 0.obs;
  ApiService _apiService = ApiService();
  var storageSms = GetStorage('sms');
  Shop shopData = Shop().obs.value;

  Future<dynamic> fetchAllSms(
      {String shopId, String statDate, String endDate}) async {
    String url = "/sms?shop_id=$shopId";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> fetchSmsPackage() async {
    String url = "/sms/packages";
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> createSms(
      {String shopId, String number, String message, String smsCount}) async {
    String url =
        "/sms/add?shop_id=$shopId&number=[$number]&message=$message&sms_count=$smsCount";
    return _apiService.makeApiRequiest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> checkSubcription(String shopId) async {
    String url = '/subscription/verify?shop_id=$shopId';

    shopData = await _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  // @override
  // void onInit() {
  //   checkSubcription('${storageSms.read("shop_id")}');
  //   super.onInit();
  // }
}
