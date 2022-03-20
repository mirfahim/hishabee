import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_services/localization_service.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class EmiController extends GetxController {
  final storage = GetStorage();
  final url = ''.obs;

  final headers = Map<String, String>().obs;

  final isConnected = false.obs;

  final IAuthRepository authRepository;
  final ILocalizationService localizationService;
  final INetworkInfo networkInfo;
  EmiController({this.authRepository, this.localizationService, this.networkInfo});

  ApiService _apiService = ApiService();


  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final emiMoney = TextEditingController();
  final RxString bankName = ''.obs;
  int flag = 0;

  @override
  void onInit() async {
    // await init();
    // await getIsConnected();
    super.onInit();
  }

  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    emiMoney.dispose();
    super.onClose();
  }

  init() async {
    // final shopId = DataHolder.shopId;

    var language = 'bn';

    // final creds = await authRepository.getCredentials();

    headers.assignAll({'Authorization': 'Bearer ' + storage.read("token")});

    // final isBn = await localizationService.isBangla();

    // if (isBn) {
    //   language = 'bn';
    //   flag = 1;
    // }
    // url.value =
    // 'https://hishabee.business${flag == 1 ? '/$language' : ''}/help/emi/?source=app';
  }
  // Future<void> getIsConnected() async {
  //   isConnected.value = await networkInfo.isConnected();
  // }

  Future<dynamic> fetchAllEmi(
      {
    String shopId,
        String startDate,
        String endDate
  }) async {
    String url = "/digital_payment/emi_list?shop_id=$shopId${startDate != null ?'&start_date=$startDate':''}${endDate != null ?'&end_date=$endDate':''}";
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  fetchCustomer({String shopId}) async {
    String url = "/customer/all?shop_id=$shopId";
    return _apiService.makeApiRequest(
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
        "/digital_payment/emi?shop_id=$shop_id&amount=$amount&customer_name=$customerName&customer_mobile=$customerPhone&customer_address=$customerAddress&installment=$installment&payable_amount=$payable&app_platform=ANDROID&version_code=79";
    print("POST REQUEST APP");
    print(_apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null));
    return _apiService.makeApiRequest(
        method: apiMethods.post,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }
}
