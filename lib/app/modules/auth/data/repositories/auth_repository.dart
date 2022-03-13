import 'dart:io';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_navigation/auth_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/nid_verify_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/register_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthProvider authProvider;
  final ILocalAuthProvider localAuthProvider;

  AuthRepository(this.authProvider, this.localAuthProvider);

  @override
  Future<LoginResponseModel> login({
    String mobileNumber,
    String pin,
    String fcmToken,
  }) async {
    try {
      final response = await authProvider.login(
        mobileNumber: mobileNumber,
        pin: pin,
        fcmToken: fcmToken,
      );
      if (response.body.code == 200) {
        saveCredentials(response.body);
        return getCredentials();
      } else if (response.body.code == 401) {
        removeCredentials();
        Get.offAllNamed(AuthRoutes.LOGIN);
        return getCredentials();
      } else {
        return Future.error(response.body.message);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<GenericResponseModel> logout({String token}) async {
    final response = await authProvider.logout(token: token);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<RegisterResponseModel> register({
    String brandName,
    String mobileNumber,
    String pin,
    String pinConfirmation,
    String fcmToken,
    String address
  }) async {
    final response = await authProvider.register(
      brandName: brandName,
      mobileNumber: mobileNumber,
      pin: pin,
      pinConfirmation: pinConfirmation,
      fcmToken: fcmToken,
      address: address,
    );
    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> resetPin({String mobileNumber}) async {
    final response = await authProvider.resetPin(mobileNumber: mobileNumber);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<LoginResponseModel> getCredentials() async {
    final result = await localAuthProvider.getCredentials();
    return result;
  }

  @override
  Future<void> removeCredentials() async {
    return await localAuthProvider.removeCredentials();
  }

  @override
  Future<void> saveCredentials(LoginResponseModel loginResponseModel) async {
    return await localAuthProvider.saveCredentials(loginResponseModel);
  }

  @override
  Future<GenericResponseModel> sendForgetPasswordOtp(
      String mobileNumber) async {
    final response = await authProvider.sendForgetPasswordOtp(mobileNumber);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> verifyForgetPasswordOtp(
      String mobileNumber, String code, String type) async {
    final response =
        await authProvider.verifyForgetPasswordOtp(mobileNumber, code, type);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> forgetPasswordResetPin(
      String mobileNumber, String code, String pin) async {
    final response =
        await authProvider.forgetPasswordResetPin(mobileNumber, code, pin);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<void> updateFcmToken({String fcmToken}) async {
    return await authProvider.updateFcmToken(fcmToken: fcmToken);
  }

  @override
  Future<NidVerifyResponseModel> verifyNid(
      {int shopId, String nidNumber, File nidFront, File nidBack}) async {
    final response = await authProvider.verifyNid(
        shopId: shopId,
        nidNumber: nidNumber,
        nidFront: nidFront,
        nidBack: nidBack);

    LoginResponseModel loginResponseModel = await getCredentials();

    loginResponseModel.user = response.user;

    await saveCredentials(loginResponseModel);

    return response /* ResponseDecoder.decode(response)*/;
  }
}
