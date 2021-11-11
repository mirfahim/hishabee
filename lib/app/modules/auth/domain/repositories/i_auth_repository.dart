import 'dart:io';

import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/nid_verify_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/register_response_model.dart';

abstract class VerificationType {
  static const manual = "MANUAL";
  static const firebase = "FIREBASE";
}

abstract class IAuthRepository {
  Future<LoginResponseModel> login({
    String mobileNumber,
    String pin,
    String fcmToken,
  });

  Future<RegisterResponseModel> register({
    String brandName,
    String mobileNumber,
    String pin,
    String pinConfirmation,
    String fcmToken,
  });

  Future<GenericResponseModel> resetPin({String mobileNumber});

  Future<GenericResponseModel> logout({String token});

  Future<GenericResponseModel> sendForgetPasswordOtp(String mobileNumber);

  Future<GenericResponseModel> verifyForgetPasswordOtp(
      String mobileNumber, String code, String type);

  Future<GenericResponseModel> forgetPasswordResetPin(
      String mobileNumber, String code, String pin);

  Future<void> updateFcmToken({String fcmToken});

  Future<NidVerifyResponseModel> verifyNid({
    int shopId,
    String nidNumber,
    File nidFront,
    File nidBack,
  });

  Future<LoginResponseModel> getCredentials();

  Future<void> saveCredentials(LoginResponseModel loginResponse);

  Future<void> removeCredentials();
}
