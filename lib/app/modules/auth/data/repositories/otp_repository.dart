import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/otp_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/otp_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_otp_repository.dart';

class OtpRepository implements IOtpRepository {
  final IOtpProvider otpProvider;

  OtpRepository(this.otpProvider);

  @override
  Future<OtpResponseModel> resendOtp({String mobileNumber}) async {
    final response = await otpProvider.resendOtp(mobileNumber: mobileNumber);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> sendVerifyOtp({String mobileNumber}) async {
    final response =
        await otpProvider.sendVerifyOtp(mobileNumber: mobileNumber);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> verifyForgotPinCode(
      {String mobileNumber, String code}) async {
    final response = await otpProvider.verifyForgotPinCode(
        mobileNumber: mobileNumber, code: code);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> verifyOtp({String code}) async {
    final response = await otpProvider.verifyOtp(code: code);

    return ResponseDecoder.decode(response);
  }
}
