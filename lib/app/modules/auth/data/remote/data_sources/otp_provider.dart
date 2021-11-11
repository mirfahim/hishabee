import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/otp_response_model.dart';

abstract class IOtpProvider {
  Future<Response<GenericResponseModel>> verifyOtp({String code});

  Future<Response<GenericResponseModel>> verifyForgotPinCode(
      {String mobileNumber, String code});

  Future<Response<OtpResponseModel>> resendOtp({String mobileNumber});

  Future<Response<GenericResponseModel>> sendVerifyOtp({String mobileNumber});
}

class OtpProvider extends GetConnect implements IOtpProvider {
  @override
  Future<Response<GenericResponseModel>> sendVerifyOtp(
      {String mobileNumber}) async {
    String url = '$BASE_URL/verify/otp/send';

    final body = {"mobile_number": mobileNumber};

    return post(url, body, decoder: genericResponseModelFromRawJson);
  }

  @override
  Future<Response<GenericResponseModel>> verifyForgotPinCode(
      {String mobileNumber, String code}) async {
    String url = '$BASE_URL/verify/forgot_pin';

    final body = {"mobile_number": mobileNumber, "code": code};
    return post(url, body, decoder: genericResponseModelFromRawJson);
  }

  @override
  Future<Response<GenericResponseModel>> verifyOtp({String code}) async {
    String url = '$BASE_URL/verify/otp?code=$code';
    return get(url, decoder: genericResponseModelFromRawJson);
  }

  @override
  Future<Response<OtpResponseModel>> resendOtp({String mobileNumber}) async {
    String url = '$BASE_URL/verify/otp/resend';

    final body = {"mobile_number": mobileNumber};

    return post(url, body, decoder: otpResponseModelRawJson);
  }
}
