import 'dart:convert';

import 'package:fclp_app/services/response/Failure.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class NetworkRequest {
  Object? finalResponse;

  static NetworkRequest? _instance;

  NetworkRequest._();

  factory NetworkRequest() {
    return _instance ??= NetworkRequest._();
  }

  Future<Object> getRequest(
      {required String url, Map<String, String>? headers}) async {
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      finalResponse = _getResponse(response);
      return finalResponse!;
    } catch (exception) {
      finalResponse =
          Failure(statusCode: 600, message: AppStrings.unknownApiError);
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      return finalResponse!;
    }
  }

  Future<Object> postRequest(
      {required String url,
      Map<String, String>? headers,
      required Map<String, String> body}) async {
    try {
      Response response =
          await post(Uri.parse(url), headers: headers, body: jsonEncode(body));
      finalResponse = _getResponse(response);
      return finalResponse!;
    } catch (exception) {
      finalResponse =
          Failure(statusCode: 600, message: AppStrings.unknownApiError);
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      return finalResponse!;
    }
  }

  Object _getResponse(Response response) {
    if (response.statusCode == 200) {
      return Success(
          response: jsonDecode(response.body), statusCode: response.statusCode);
    } else {
      return Failure(statusCode: response.statusCode);
    }
  }
}
