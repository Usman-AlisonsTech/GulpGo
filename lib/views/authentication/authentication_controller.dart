import 'dart:async';
import 'dart:convert';

import 'package:aqua_flow/services/network_api_service.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/flushbar_helper.dart';
import 'package:aqua_flow/views/authentication/login/login_view.dart';
import 'package:aqua_flow/views/authentication/otp/otp_view.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  NetworkApiService apiService = NetworkApiService();
  RxBool isLoading = false.obs;
  TextEditingController numberController = TextEditingController();
  final userNameformKey = GlobalKey<FormState>();
  RxBool isVerifyLoading = false.obs;
  RxInt remainingSeconds = 0.obs;
  Timer? _timer;
  RxBool canResend = true.obs;
  String? otp;
  RxBool isOtpValid = false.obs;
  final token = GetStorage().read('fcmToken');

  void login(BuildContext context) async {
    if (!userNameformKey.currentState!.validate()) {
      return;
    }
    var formData = {
      'phone': numberController.text,
    };
    try {
      isLoading.value = true;
      final response = await apiService.postApi('${ApiConstants.baseUrl+ApiConstants.login}',formData,'');
      print(response);
      if (response['message'] == 'OTP sent to your phone' ) {
        Get.to(OtpView());
        FlushBarHelper.flushBarSuccessMessage(response['message']??'Otp Sent Successfully', context);
      }else {
        FlushBarHelper.flushBarErrorMessage(response['error'] ?? 'Failed to Sent Otp', context);
      }
     
    } catch (e) {
      print('Login ERror : $e');
        FlushBarHelper.flushBarErrorMessage('An error occurred while sending otp', context);
    }finally {
      isLoading.value = false;
    }
  }


   void verifyOtp(BuildContext context) async {
    var formData = {
      'phone': numberController.text,
      'otp': otp??'' ,
    };
    try {
      isVerifyLoading.value = true;
      final response = await apiService.postApi('${ApiConstants.baseUrl+ApiConstants.verifyOtp}',formData,'');
      print(response);
      if (response['success'].toString() == 'true') {
       if (response['customer'] != null && response['customer'] is Map && response['customer'].isNotEmpty) {
        final token = response['token'];

        await _saveToken(token, jsonEncode(response['customer']),jsonEncode(response['companyAdmin']));
        NetworkApiService.resetSessionFlag();
        await sendFCMToken();

        Get.offAll(BottomNavigation(index: 0));
       
      } else {
        FlushBarHelper.flushBarErrorMessage(
          response['error'] ?? 'No record found',
          context,
        );
      }
      }else {
        FlushBarHelper.flushBarErrorMessage(response['error'] ?? 'Failed to Login', context);
      }
     
    } catch (e) {
      print('Login ERror : $e');
        FlushBarHelper.flushBarErrorMessage('An error occurred while login', context);
    }finally {
      isVerifyLoading.value = false;
    }
  }

   void resendOTP(BuildContext context) async {
    var formData = {
      'phone': numberController.text,
    };
    print(formData);
    try {
      isLoading.value = true;
      final response = await apiService.postApi('${ApiConstants.baseUrl+ApiConstants.resendOtp}',formData,'');
      print(response);
      if (response['message'] == 'OTP resent to customer' ) {
        FlushBarHelper.flushBarSuccessMessage(response['message']??'Otp Sent Successfully', context);
      }else {
        FlushBarHelper.flushBarErrorMessage(response['error'] ?? 'Failed to Sent Otp', context);
      }
     
    } catch (e) {
      print('Login ERror : $e');
        FlushBarHelper.flushBarErrorMessage('An error occurred while sending otp', context);
    }finally {
      isLoading.value = false;
    }
  }


  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print('logout');
    Get.offAll(LoginView());
  }


   void startResendTimer() {
    remainingSeconds.value = 30;
    canResend.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        canResend.value = true;
      }
    });
  }

   Future<void> _saveToken(String? token, customerdata, companyAdminData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null && token.isNotEmpty) {
      await prefs.setString('token', token);
      await prefs.setString("customerData", customerdata);
      await prefs.setString("companyAdminData", companyAdminData);
      print("Token saved: $token");
      print("customerData: $customerdata");
      print("companyAdminData: $companyAdminData");
    }
  }

   Future<void> sendFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String driverToken = prefs.getString('token') ?? '';
    var formData = {
        "fcmToken": token??'',
    };
    print(formData);
    try {
      final response = await apiService.postApi('${ApiConstants.baseUrl+ApiConstants.sentFcmToken}',formData,driverToken);
      print(response);
      if (response['success'] == true ) {
        print('fcm token sent in api successfully');
      }else {
        print(response['message']);
      }
     
    } catch (e) {
      print('fcm token api error: $e');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}