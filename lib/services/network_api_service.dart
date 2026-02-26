import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aqua_flow/exceptions/app_exceptions.dart';
import 'package:aqua_flow/views/authentication/login/login_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiService {
  static bool _isSessionExpiredHandled = false;

  Future<dynamic> getApi(String url, String token) async {
    print(url);
    dynamic jsonResponse;
    try {
      final response = await http
          .get(Uri.parse(url), headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          })
          .timeout(const Duration(seconds: 30));

      jsonResponse = await returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet');
    } on TimeoutException {
      throw RequestTimeoutException('Request Time Out');
    }
    return jsonResponse;
  }

  Future<dynamic> postApi(String url, data, String token) async {
    print(url);
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url),
              body: json.encode(data),
              headers: {
                "Content-Type": "application/json", 'Authorization': 'Bearer $token'
              }).timeout(const Duration(seconds: 30));

      jsonResponse = await returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet');
    } on TimeoutException {
      throw RequestTimeoutException('Request Time Out');
    }
    return jsonResponse;
  }


  Future<dynamic> putApi(String url, data, String token) async {
    print(url);
    dynamic jsonResponse;
    try {
      final response = await http
          .put(Uri.parse(url),
              body: json.encode(data),
              headers: {
                "Content-Type": "application/json", 'Authorization': 'Bearer $token'
              }).timeout(const Duration(seconds: 30));

      jsonResponse = await returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet');
    } on TimeoutException {
      throw RequestTimeoutException('Request Time Out');
    }
    return jsonResponse;
  }

  Future<dynamic> patchApi(String url, data, String token) async {
  print(url);
  dynamic jsonResponse;
  try {
    final response = await http
        .patch(
          Uri.parse(url),
          body: json.encode(data),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token'
          },
        )
        .timeout(const Duration(seconds: 30));

    jsonResponse = await returnResponse(response);
  } on SocketException {
    throw NoInternetException('No Internet');
  } on TimeoutException {
    throw RequestTimeoutException('Request Time Out');
  }
  return jsonResponse;
}


  Future<dynamic> returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 400:
      case 403:
      case 404:
      case 422:
      case 429:
      case 500:
        return jsonDecode(response.body);

      case 401:
        if (!_isSessionExpiredHandled) {
          _isSessionExpiredHandled = true;

          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          Future.delayed(const Duration(milliseconds: 200), () {
            Get.offAll(() => LoginView());
          });
        }

        throw UnAuthorisedException('Session expired');

      default:
        throw FetchDataException(
          'Error occurred while communicating with server with StatusCode : ${response.statusCode}',
        );
    }
  }

  static void resetSessionFlag() {
    _isSessionExpiredHandled = false;
  }
}
