import 'dart:convert';
import 'dart:io';

import 'package:wiliams/Globals/Globals.dart';
import 'package:wiliams/Plugins/get/get.dart';
import 'package:wiliams/Utils/Api/WebControllers.dart';
import 'package:wiliams/Utils/Api/routes/auth.dart';
import 'package:wiliams/Utils/Api/routes/data.dart';
import 'package:wiliams/Utils/storage_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class RequestsUtil extends GetConnect {
  static RequestsUtil instance = RequestsUtil();
  AuthApi auth = AuthApi();
  DataApi data = DataApi();
  static String baseRequestUrl = 'https://fmcg.parsa.today/api/';
  static String version = 'v1';

  String _makePath(WebControllers webController, String webMethod) {
    String controller = webController.toString().split('.').last;
    return "${RequestsUtil.baseRequestUrl}$version/$controller/${webMethod.toString()}";
  }

  Future<ApiResult> makeRequest({
    required WebControllers webController,
    required String webMethod,
    Map<String, dynamic> body = const {},
    Map<String, String>? headers,
    bool auth = false,
    bool postRequest = true,
    Map<String, File> files = const {},
    void Function(double value)? onData,
  }) async {
    String url = _makePath(webController, webMethod);
    print("Request url: $url\nRequest body: ${jsonEncode(body)}\n");
    headers ??= {};
    String token = (await StorageUtils.auth()) ?? 'no_token';
    if (auth) {
      headers.addAll({
        'auth': (await StorageUtils.auth()) ?? 'no_token',
      });
      print(headers);
    } else if (token != 'no_token') {
      headers.addAll({
        'auth': token,
      });
    }
    late http.Response response;
    FormData formData = FormData(
      body,
    );
    if (files.isNotEmpty) {
      files.forEach(
        (key, value) {
          formData.files.add(
            MapEntry(
              key,
              MultipartFile(
                value,
                filename: value.path.split('/').last,
              ),
            ),
          );
        },
      );
    }
    if (postRequest) {
      response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );
    } else {
      response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
    }
    ApiResult apiResult = ApiResult();

    print('response.body');
    print(utf8.decode(response.bodyBytes));
    print(response.body.runtimeType);
    apiResult.status = response.statusCode ?? 0;
    apiResult.isDone = response.statusCode.toString().split('').first == '2';
    // if (response.statusCode == 200) {
    if (response.statusCode == 403) {
      Globals.loginDialog();
      return apiResult;
    }
    try {
      apiResult.data = jsonDecode(utf8.decode(response.bodyBytes));
      apiResult.requestedMethod = "$webController $webMethod";
    } catch (e) {
      print(e);
      apiResult.isDone = false;
      apiResult.requestedMethod = webMethod.toString().split('.').last;
      apiResult.data = response.body;
    }
    // } else {
    //   apiResult.isDone = false;
    // }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "requestedMethod: ${apiResult.requestedMethod}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }
}

class ApiResult {
  late bool isDone;
  int status = 0;
  String? requestedMethod;
  dynamic data;

  ApiResult({
    this.isDone = false,
    this.requestedMethod,
    this.data,
    this.status = 0,
  });
}
