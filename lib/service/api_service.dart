
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';

class ApiService {
  final storage = GetStorage();

  Future<String> uploadFile({File file, String type}) async {
    String url = "$BASE_URL/upload";

    // final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ' + storage.read("token")};

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

  makeApiRequest({method, url, body, headers}) async {
    try {
      http.Response response;
      Uri apiURL = Uri.parse(BASE_URL + url);
      var header = headers;
      // use storage // getx storage
      if (headers == null) {

        header = {
          "Content-Type": "application/json",
          "Authorization": 'Bearer ' + storage.read("token")
        };
      }
      if (method == apiMethods.post) {

        response = await http.post(apiURL,
            body: convert.jsonEncode(body), headers: header);
        print("Response code: ${response.statusCode}");
        // print('response code from function: ${response.statusCode}');
        print('response code from function: ${response.body}');
        print(apiURL);
        // print(response.body);
      }
      if (method == apiMethods.get) {
        response = await http.get(apiURL, headers: header);
        print("my response is $response");
      }
      if (method == apiMethods.delete) {
        response = await http.delete(apiURL, headers: header);
      }
      if (method == apiMethods.put) {
        response = await http.put(apiURL,
            body: convert.jsonEncode(body), headers: header);
        print('response code from put: ${response.body}');
      }

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        var res = convert.jsonDecode(response.body);
        print("my response is $res");
        return res;
      } else if(response != null &&
          (response.statusCode == 403)){
        var res = convert.jsonDecode(response.body);
        print("my response is $res");
        return res;
      }
      else {
        var res = convert.jsonDecode(response.body);

        handleError(res);
      }

    } catch (e) {

      print(e.toString());
      handleError(e);
    }
  }

  handleError(err) {
    var message = 'Something went wrong. Please try again later';
    print(message);
    if (err != null && err['messages'] != null && err['messages'].length > 0) {
      message = err['messages'][0];
    }
    Utils.showToast(message);
  }
}
