import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/nid_verify_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/register_response_model.dart';

abstract class IAuthProvider {
  Future<Response<LoginResponseModel>> login({
    String mobileNumber,
    String pin,
    String fcmToken,
  });

  Future<Response<RegisterResponseModel>> register({
    String brandName,
    String mobileNumber,
    String pin,
    String pinConfirmation,
    String fcmToken,
  });

  Future<Response<GenericResponseModel>> resetPin({String mobileNumber});

  Future<Response<GenericResponseModel>> logout({String token});

  Future<Response<GenericResponseModel>> sendForgetPasswordOtp(
      String mobileNumber);

  Future<Response<GenericResponseModel>> verifyForgetPasswordOtp(
      String mobileNumber, String code, String type);

  Future<Response<GenericResponseModel>> forgetPasswordResetPin(
      String mobileNumber, String code, String pin);

  Future<void> updateFcmToken({String fcmToken});

  Future<NidVerifyResponseModel> verifyNid({
    int shopId,
    String nidNumber,
    File nidFront,
    File nidBack,
  });
}

class AuthProvider extends GetConnect implements IAuthProvider {
  final ILocalAuthProvider _localAuthProvider;

  AuthProvider(this._localAuthProvider);

  @override
  Future<Response<LoginResponseModel>> login({
    String mobileNumber,
    String pin,
    String fcmToken,
  }) async {
    String url = "$BASE_URL/login";
    final body = {
      "mobile_number": mobileNumber,
      "pin": pin,
      // "fcm_token": fcmToken,
    };

    return post(url, body, decoder: loginResponseModelFromRawJson);
  }

  @override
  Future<Response<GenericResponseModel>> resetPin(
      {String mobileNumber, String code, String pin}) async {
    String url = '$BASE_URL/verify/reset';

    final body = {
      "mobile": mobileNumber,
      "code": code,
      "pin": pin,
    };

    return post(url, body, decoder: genericResponseModelFromRawJson);
  }

  @override
  Future<Response<GenericResponseModel>> logout({String token}) async {
    String url = "$BASE_URL/logout";

    final headers = {'Authorization': 'Bearer $token'};
    return post(url, {},
        headers: headers, decoder: genericResponseModelFromRawJson);
  }

  @override
  Future<Response<RegisterResponseModel>> register({
    String brandName,
    String mobileNumber,
    String pin,
    String pinConfirmation,
    String fcmToken,
  }) async {
    String url = '$BASE_URL/register';
    final body = {
      "brand_name": brandName,
      "mobile_number": mobileNumber,
      "pin": pin,
      "pin_confirmation": pinConfirmation,
      "fcm_token": fcmToken,
    };

    return post(url, body, decoder: registerResponseModelFromRawJson);
  }

  @override
  Future<Response<GenericResponseModel>> sendForgetPasswordOtp(
      String mobileNumber) async {
    String url = "$BASE_URL/forget-password/otp/send";

    final body = {
      "mobile_number": mobileNumber,
    };
    return post(url, body, decoder: genericResponseModelFromRawJson);
  }

  @override
  Future<Response<GenericResponseModel>> verifyForgetPasswordOtp(
      String mobileNumber, String code, String type) async {
    String url = "$BASE_URL/forget-password/verify";

    final body = {
      "mobile_number": mobileNumber,
      "code": code,
      "type": type,
    };
    return post(url, body, decoder: genericResponseModelFromRawJson);
  }

  @override
  Future<Response<GenericResponseModel>> forgetPasswordResetPin(
      String mobileNumber, String code, String pin) async {
    String url = "$BASE_URL/forget-password/reset";

    final body = {
      "mobile_number": mobileNumber,
      "code": code,
      "pin": pin,
    };
    return post(url, body, decoder: genericResponseModelFromRawJson);
  }

  @override
  Future<void> updateFcmToken({String fcmToken}) async {
    final url = '$BASE_URL/fcm/update?fcm_token=$fcmToken';

    final creds = await _localAuthProvider.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(url, {}, headers: headers);
  }

  @override
  Future<NidVerifyResponseModel> verifyNid(
      {int shopId, String nidNumber, File nidFront, File nidBack}) async {
    final url = "$BASE_URL/nid/verify";

    print("ShopId : $shopId");
    print("NID Number : $nidNumber");
    print("front : ${nidFront.path}");
    print("back : ${nidBack.path}");

    String frontName = nidFront.path.split('/').last;
    String backName = nidBack.path.split('/').last;

    /* var body = new FormData({
      'shop_id': shopId,
      'nid_number': nidNumber,
      'front': MultipartFile(nidFront.readAsBytesSync(), filename: frontName),
      'back': MultipartFile(nidBack.readAsBytesSync(), filename: backName),
    });*/

    final creds = await _localAuthProvider.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final body = {
      "shop_id": shopId,
      'nid_number': nidNumber,
    };

    /*return post(
      url,
      body,
      headers: headers,
      decoder: nidVerifyResponseModelFromRawJson,
    );*/
    http.Response response;
    http.MultipartRequest request;
    try {
      List<http.MultipartFile> files = [];
      files.add(await http.MultipartFile.fromPath("front", nidFront.path,
          filename: frontName));
      files.add(await http.MultipartFile.fromPath("back", nidBack.path,
          filename: backName));

      request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.fields.addAll(body);
      request.files.addAll(files);
      /* request.files.add(await http.MultipartFile.fromPath(
          "front", nidFront.path,
          filename: frontName));
      request.files.add(await http.MultipartFile.fromPath("back", nidBack.path,
          filename: backName));*/

      response = await http.Response.fromStream(await request.send());

      print("STC : ${response.statusCode}");
    } on SocketException {
      Fluttertoast.showToast(msg: "Please check your internet connection");
    } catch (e) {
      print("Error : $e");
    }
    return NidVerifyResponseModel.fromJson(jsonDecode(response.body));
  }
}
