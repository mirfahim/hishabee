import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:http/http.dart' as http;

abstract class IFileProvider {
  Future<String> uploadFile({File file, String type});
}

class FileProvider extends GetConnect implements IFileProvider {
  final IAuthRepository authRepository;

  FileProvider(this.authRepository);

  @override
  Future<String> uploadFile({File file, String type}) async {
    String url = "$BASE_URL/upload";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    String fileName = file.path.split('/').last;

    final body = {
      "type": type,
    };

    /*final form = FormData({
      'image':
          MultipartFile(File(file.path).readAsBytesSync(), filename: fileName),
      'type': type,
    });

    final response = await post(
      url,
      form,
      headers: headers,
    );
    return response;*/

    http.Response response;
    http.MultipartRequest request;

    try {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields.addAll(body)
        ..files.add(await http.MultipartFile.fromPath("image", file.path,
            filename: fileName));

      response = await http.Response.fromStream(await request.send());
    } on SocketException {
      Fluttertoast.showToast(msg: "Please check your internet connection");
    } catch (e) {
      throw e;
    }
    return response.body;
  }
}
