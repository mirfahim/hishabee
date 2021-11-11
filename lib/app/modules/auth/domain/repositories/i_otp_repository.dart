import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/otp_response_model.dart';

abstract class IOtpRepository {
  Future<GenericResponseModel> verifyOtp({String code});

  Future<GenericResponseModel> verifyForgotPinCode(
      {String mobileNumber, String code});

  Future<OtpResponseModel> resendOtp({String mobileNumber});

  Future<GenericResponseModel> sendVerifyOtp({String mobileNumber});
}
