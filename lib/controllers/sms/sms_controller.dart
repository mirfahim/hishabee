import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/models/sms/create_sms_model.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class SmsController extends GetxController {
  final maxLengthForText = 160.obs;
  final textInTheMessageField = ''.obs;
  final messageCount = 1.obs;
  final mobileNumbers = ''.obs;

  ApiService _apiService = ApiService();
  List<CreateSms> _createSms = <CreateSms>[].obs;
  RxBool _isLoading = true.obs;

  Future<dynamic> fetchAllSms(
      //dynamic is nullable so if we didnt get any response we can handle it
      {String shopId,
      String statDate,
      String endDate}) async {
    String url = "/sms?shop_id=105";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> fetchSmsPackage(
      //dynamic is nullable so if we didnt get any response we can handle it
      {String shopId,
      String statDate,
      String endDate}) async {
    String url = "/sms/packages";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> createSms(
      {String shopId, String number, String message, String smsCount}) async {
    String url =
        "/sms/add?shop_id=$shopId&number=[$number]&message=$message&sms_count=$smsCount";
    return _apiService.makeApiRequiest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  // void sendMessage(
  //     String shopId, String number, String message, String smsCount) {
  //   createSms(
  //           shopId: shopId,
  //           number: number,
  //           message: message,
  //           smsCount: smsCount)
  //       .then((value) {
  //     _createSms = getSmsFromModel(value);
  //     _isLoading = false.obs;
  //   });
  // }

  // @override
  // void onInit() {
  //   createSms().then((value) {
  //     _createSms = getSmsFromModel(value);
  //     _isLoading = false.obs;
  //   });
  //   super.onInit();
  // }
}
