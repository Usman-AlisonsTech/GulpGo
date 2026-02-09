import 'package:aqua_flow/models/order_payment_model.dart';
import 'package:aqua_flow/services/network_api_service.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillsController extends GetxController {
  NetworkApiService apiService = NetworkApiService();
  RxBool isLoading = false.obs;
  RxInt selectedTab = 0.obs;
  var orderPaymentData = Rxn<OrderPaymentModel>();

  Future<void> fetchOrderPayments(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    isLoading.value = true;

    try {
      final response = await apiService.getApi(
        '${ApiConstants.baseUrl + ApiConstants.orderPayment}',
        token,
      );
      print(response);
      if (response['success'] == true) {
        orderPaymentData.value = OrderPaymentModel.fromJson(response);
      } else {
        FlushBarHelper.flushBarErrorMessage(response['error'], context);
      }
    } catch (e) {
      print("❌ Error fetching all products data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
