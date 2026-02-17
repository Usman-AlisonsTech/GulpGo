import 'dart:convert';

import 'package:aqua_flow/models/all_product_model.dart';
import 'package:aqua_flow/services/network_api_service.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  NetworkApiService apiService = NetworkApiService();
  RxBool isLoading = false.obs;
  RxString recurrence = ''.obs;
  RxString preferredTime = ''.obs;
  RxMap<String, int> quantities = <String, int>{}.obs;
  final dateController = TextEditingController();
  final addressController = TextEditingController();
  RxInt currentStep = 1.obs;

  // RxString bottlePreference = "auto".obs;
  // RxInt customNewBottles = 0.obs;
  // RxInt customRefillBottles = 0.obs;
  // RxInt returnEmpties = 0.obs;

  RxBool isRecurring = false.obs;
  RxBool withBottles = false.obs;

  /// calculated totals
  RxInt totalAmount = 0.obs;
  RxInt totalDeposit = 0.obs;
  RxInt depositAmountTaking = 0.obs;
  RxInt grandTotal = 0.obs;

  var allProductData = Rxn<AllProductModel>();
  var customerData = {}.obs;

  Future<void> fetchAllProducts(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    isLoading.value = true;

    print(token);

    try {
      final response = await apiService.getApi(
        '${ApiConstants.baseUrl + ApiConstants.getProducts}',
        token,
      );
      print(response);
      if (response['products'] != null && response['products'] is List) {
        allProductData.value = AllProductModel.fromJson(response);
      } else {
        FlushBarHelper.flushBarErrorMessage(response['error'], context);
      }
    } catch (e) {
      print("❌ Error fetching all products data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void goToStep(int step) {
    currentStep.value = step;
  }

  void nextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
    }
  }

  void backStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  Future<void> loadCustomerFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    String? customerString = prefs.getString("customerData");

    if (customerString != null && customerString.isNotEmpty) {
      customerData.value = jsonDecode(customerString);
      print("customer Loaded: ${customerData}");
    } else {
      print("No customer data found in local storage");
    }
  }

  void updateQuantity(Product product, bool isAdd, bool withBottles) {
    final id = product.id ?? '';
    if (id.isEmpty) return;

    final currentQty = quantities[id] ?? 0;
    if (isAdd) {
      quantities[id] = currentQty + 1;
    } else {
      if (currentQty > 0) {
        quantities[id] = currentQty - 1;
      }
    }
    recalculate(withBottles);
  }

  void recalculate(bool withBottles, {bool isRecurring = false}) {
    int amount = 0;
    int deposit = 0;

    quantities.forEach((productId, qty) {
      if (qty == 0) return;

      final product = allProductData.value?.products
          ?.firstWhereOrNull((p) => p.id == productId);
      if (product == null) return;

      // 🔹 Ignore non-reusable if recurring
      if (isRecurring && product.isReusable != true) return;

      // 🔹 Ignore non-reusable if withBottles
      if (withBottles && product.isReusable != true) return;

      /// price calculation
      amount += (product.price ?? 0) * qty;

      /// deposit calculation only for reusable products
      if (withBottles && (product.depositAmount ?? 0) > 0) {
        deposit += (product.depositAmount ?? 0) * qty;
      }
    });

    totalAmount.value = amount;
    totalDeposit.value = deposit;

    updateGrandTotal();

    print("🧮 Amount: $amount");
    print("🧮 Total Deposit (Display): $deposit");
    print("🧮 Deposit Taking (User Input): ${depositAmountTaking.value}");
    print("🧮 Grand Total: ${grandTotal.value}");
  }

  void updateGrandTotal() {
    grandTotal.value = totalAmount.value + depositAmountTaking.value;
    print(grandTotal.value);
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      dateController.text = formattedDate;
    }
  }

  bool canProceedFromStep1() {
    return quantities.values.any((qty) => qty > 0);
  }

  // int get totalItems {
  //   int count = 0;
  //   quantities.forEach((_, qty) {
  //     count += qty;
  //   });
  //   return count;
  // }

//   int get totalItems {
//   int count = 0;

//   quantities.forEach((productId, qty) {
//     if (qty == 0) return;

//     final product = allProductData.value?.products
//         ?.firstWhereOrNull((p) => p.id == productId);

//     if (product == null) return;

//     /// ignore non reusable when recurring OR with bottles filter active
//     if (isRecurring.value && product.isReusable != true) return;

//     if (withBottles.value && product.isReusable != true) return;

//     count += qty;
//   });

//   return count;
// }

  int get totalItems {
    int count = 0;

    quantities.forEach((productId, qty) {
      if (qty == 0) return;

      final product = allProductData.value?.products
          ?.firstWhereOrNull((p) => p.id == productId);
      if (product == null) return;

      // ignore non-reusable for recurring or withBottles
      if (isRecurring.value && product.isReusable != true) return;
      if (withBottles.value && product.isReusable != true) return;

      count += qty;
    });

    return count;
  }

  bool get hasReusable {
    return quantities.entries.any((entry) {
      if (entry.value == 0) return false;
      final product = allProductData.value?.products
          ?.firstWhereOrNull((p) => p.id == entry.key);
      return product?.isReusable == true;
    });
  }

  bool get hasNonReusable {
    return quantities.entries.any((entry) {
      if (entry.value == 0) return false;
      final product = allProductData.value?.products
          ?.firstWhereOrNull((p) => p.id == entry.key);
      return product?.isReusable == false;
    });
  }

  // void applyBottlePreferenceLogic() {
  //   final int totalQty = totalItems;

  //   switch (bottlePreference.value) {
  //     case "auto":
  //       depositAmountTaking.value = totalDeposit.value;
  //       break;

  //     case "new_only":
  //       depositAmountTaking.value = totalDeposit.value;
  //       break;

  //     case "custom":
  //       if (customNewBottles.value + customRefillBottles.value != totalQty) {
  //         return;
  //       }

  //       if (totalQty == 0) return;

  //       final double perBottleDeposit = totalDeposit.value / totalQty;

  //       depositAmountTaking.value =
  //           (perBottleDeposit * customNewBottles.value).round();
  //       break;
  //   }

  //   updateGrandTotal();
  // }

  void createOrder(BuildContext context) async {
    /// ---------------- VALIDATIONS ----------------
    print('create order call');
    if (isRecurring.value && hasNonReusable) {
      Get.snackbar(
          "Error", "Recurring orders cannot include non-reusable items");
      return;
    }

    if (isRecurring.value && recurrence.value.isEmpty) {
      Get.snackbar("Error", "Please select recurrence type");
      return;
    }

    /// ---------------- ITEMS PAYLOAD ----------------

    final items = quantities.entries
      .where((e) {
        if (e.value == 0) return false;

        final product = allProductData.value?.products
            ?.firstWhereOrNull((p) => p.id == e.key);
        if (product == null) return false;

        // apply same filters as UI/calculation
        if (isRecurring.value && product.isReusable != true) return false;
        if (withBottles.value && product.isReusable != true) return false;

        return true;
      })
      .map((e) => {
            "productId": e.key,
            "quantity": e.value,
          })
      .toList();

    /// ---------------- FORM DATA ----------------

    final Map<String, dynamic> formData = {
      "deliveryDate": dateController.text,
      "items": items,
      "withBottles": withBottles.value,
    };

    // Deposit rules
    if (withBottles.value && depositAmountTaking.value > 0) {
      formData["acceptableDepositAmount"] = depositAmountTaking.value;
    }

    // if (withBottles.value) {
    //   formData["bottlePreference"] = bottlePreference.value;

    //   formData["acceptableDepositAmount"] = depositAmountTaking.value;

    //   if (bottlePreference.value == "custom") {
    //     if (customNewBottles.value + customRefillBottles.value != totalItems) {
    //       Get.snackbar("Error", "Custom bottle total must match quantity");
    //       return;
    //     }

    //     formData["customNewBottles"] = customNewBottles.value;
    //     formData["customRefillBottles"] = customRefillBottles.value;
    //   }

    //   if (returnEmpties.value > 0) {
    //     formData["returnEmpties"] = returnEmpties.value;
    //   }
    // }

    // Recurring payload
    if (isRecurring.value) {
      formData.addAll({
        "isRecurring": true,
        "recurrence": recurrence.value,
        "preferredTime": preferredTime.value,
      });
    }

    /// ---------------- DEBUG PRINT ----------------
    print("🔥 FINAL ORDER PAYLOAD 🔥");
    print(const JsonEncoder.withIndent('  ').convert(formData));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    try {
      isLoading.value = true;
      final response = await apiService.postApi(
          '${ApiConstants.baseUrl + ApiConstants.createOrder}',
          formData,
          token);
      print(response);
      if (response['success'] == true) {
        goToStep(4);
      } else {
        FlushBarHelper.flushBarErrorMessage(
            response['error'] ?? 'Failed to Sent Otp', context);
      }
    } catch (e) {
      print('Add order error : $e');
      FlushBarHelper.flushBarErrorMessage(
          'An error occurred while adding order', context);
    } finally {
      isLoading.value = false;
    }
  }
}
