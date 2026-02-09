import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var customerData = {}.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    loadCustomerFromLocal();
    super.onInit();
  }


  Future<void> loadCustomerFromLocal() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    String? customerString = prefs.getString("customerData");

    if (customerString != null && customerString.isNotEmpty) {
      customerData.value = jsonDecode(customerString);
      print("customer Loaded: ${customerData}");
    } else {
      print("No customer data found in local storage");
    }
    isLoading.value = false;
  }
}