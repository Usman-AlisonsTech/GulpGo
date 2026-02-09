import 'package:flutter/material.dart';

class ApiConstants {
  // baseUrls
  static String baseUrl = 'http://192.168.50.227:8001/api';
  static String imageBaseUrl = 'http://192.168.50.227:8001';
  // static String baseUrl = 'https://aquaflow.alisonstech-dev.com/backend/api';
  // static String imageBaseUrl = 'https://aquaflow.alisonstech-dev.com/backend';
  
  static String login = '/auth/customers/send-otp';
  static String verifyOtp = '/auth/customers/verify-otp';
  static String resendOtp = '/auth/customers/resend-otp';
  static String getProducts = '/products/all';
  static String createOrder = '/customer/orders/orders/create';
  static String customerOrder = '/customer/orders/orders';
  static String orderPayment = '/customer/orders/payments';
  static String customerBottleInfo = '/customer/orders/bottles-info';
  static String recurringUpcoming = '/customer/recurring/recurring/upcoming';
  static String recurringSubscription = '/customer/recurring/recurring/subscription';
  static String editRecurringOrder = '/customer/recurring/recurring/edit';
  static String sentFcmToken = '/fcm/update-token-customer';
  static String number = '03350024090';
}
class ColorConstants {
  static Color buttoncolor = Color(0xff285FAA);
  static Color themeColor = Color(0xff285FAA);
  static Color greyColor = Color(0xff9DA3AE);
  static Color darkGreyColor = Color(0xff9B9B9B);
  static Color lightGrey = Color(0xffBEBEBE);
  static Color redColor = Colors.red[600]!;
  static Color gradientColor1 = Color(0XFF34B2E6);
  static Color gradientColor2 = Color(0xff3891CF);
  static Color lightBlue = Color(0xff6CC9F9);
}

class ScreenConstants {
 static double verticalPadding = 15;
 static double horizontalPadding = 20;
}