import 'dart:convert';
import 'package:aqua_flow/models/customer_bottle_info_model.dart';
import 'package:aqua_flow/models/customer_orders_model.dart' as CustomerModels;
import 'package:aqua_flow/models/recurring_upcoming_model.dart' as RecurringModels;
import 'package:aqua_flow/services/network_api_service.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardController extends GetxController {
  NetworkApiService apiService = NetworkApiService();
  RxBool isLoading = false.obs;
  RxBool isBottleInfoLoading = false.obs;
  RxBool isCustomerDataLoading = false.obs;
  RxBool isRecurringSubscription = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxInt currentTabIndex = 0.obs;
  var customerData = {}.obs;
  var companyAdminData = {}.obs;

  var customerOrders = Rxn<CustomerModels.CustomerOrdersModel>();
  var customerBottleInfo = Rxn<CustomerBottleInfoModel>();
  var recurringUpcoming = Rxn<RecurringModels.RecurringUpcomingModel>();
  RxList<CustomerModels.Order> allPendingOrders = <CustomerModels.Order>[].obs;
  RxList<RecurringModels.Order> allRecurringOrders = <RecurringModels.Order>[].obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore.value &&
        !isLoading.value &&
        hasMore.value) {
      loadMoreOrders(Get.context!);
    }
  }


  Future<void> loadCustomerFromLocal() async {
    isCustomerDataLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    String? customerString = prefs.getString("customerData");

    if (customerString != null && customerString.isNotEmpty) {
      customerData.value = jsonDecode(customerString);
      print("customer Loaded: ${customerData}");
    } else {
      print("No customer data found in local storage");
    }
    isCustomerDataLoading.value = false;
  }

  Future<void> loadCompanyDataFromLocal() async {
    isCustomerDataLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    String? companyDataString = prefs.getString("companyAdminData");

    if (companyDataString != null && companyDataString.isNotEmpty) {
      companyAdminData.value = jsonDecode(companyDataString);
      print("companyData Loaded: ${companyAdminData}");
    } else {
      print("No company data found in local storage");
    }
    isCustomerDataLoading.value = false;
  }
  
  Future<void> fetchCustomerOrders({int page = 1}) async {
    // Prevent duplicate calls
    if (page == 1 && isLoading.value) return;
    if (page > 1 && isLoadingMore.value) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    if (page == 1) {
      isLoading.value = true;
      allPendingOrders.clear();
      currentPage.value = 1;
      hasMore.value = true;
    } else {
      isLoadingMore.value = true;
    }

    try {
      final response = await apiService.getApi(
        '${ApiConstants.baseUrl + ApiConstants.customerOrder}?page=$page',
        token,
      );

      print(response);

      print('📄 Dashboard Page $page loaded');

      if (response['success'] == true) {
        customerOrders.value = CustomerModels.CustomerOrdersModel.fromJson(response);

        if (customerOrders.value?.orders != null) {
          // Filter only pending orders and add to list
        if (customerOrders.value?.orders != null) {
          allPendingOrders.addAll(customerOrders.value!.orders);
        }
          
          // allPendingOrders.addAll(pendingFromThisPage);
        }

        // Update pagination info
        if (customerOrders.value?.pagination != null) {
          currentPage.value = customerOrders.value?.pagination?.page??0;
          totalPages.value = customerOrders.value?.pagination?.totalPages??0;
          hasMore.value = currentPage.value < totalPages.value;
        }
      } else {
        // FlushBarHelper.flushBarErrorMessage(response['error'], context);
      }
    } catch (e) {
      print("❌ Error fetching customers Order data: $e");
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }


  Future<void> fetchCustomerBottleInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

   isBottleInfoLoading.value = true;

    try {
      final response = await apiService.getApi(
        '${ApiConstants.baseUrl + ApiConstants.customerBottleInfo}',
        token,
      );

      print(response);

      if (response['success'] == true) {
        customerBottleInfo.value = CustomerBottleInfoModel.fromJson(response);
      } else {
      }
    } catch (e) {
      print("❌ Error fetching customers bottle info data: $e");
    } finally {
      isBottleInfoLoading.value = false;
    }
  }


  Future<void> fetchRecurringUpcoming() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    print(token);

    isLoading.value = true;
    allRecurringOrders.clear();

    try {
      final response = await apiService.getApi(
        '${ApiConstants.baseUrl + ApiConstants.recurringUpcoming}',
        token,
      );

      print(response);

      if (response['success'] == true) {
        recurringUpcoming.value = RecurringModels.RecurringUpcomingModel.fromJson(response);
        
        // Add all recurring orders to the list
        if (recurringUpcoming.value?.orders != null) {
          allRecurringOrders.addAll(recurringUpcoming.value!.orders);
        }
      } else {
        print("${response['message']}");
      }
    } catch (e) {
      print("❌ Error fetching recurring orders data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreOrders(BuildContext context) async {
    if (currentTabIndex.value == 0 && hasMore.value && !isLoadingMore.value && !isLoading.value) {
      print('🔄 Loading more pending orders - Current page: ${currentPage.value}');
      await fetchCustomerOrders(page: currentPage.value + 1);
    }
  }

  void refreshOrders(BuildContext context) {
    if (currentTabIndex.value == 0) {
      currentPage.value = 1;
      hasMore.value = true;
      allPendingOrders.clear();
      fetchCustomerOrders();
    } else {
      fetchRecurringUpcoming();
    }
  }


  Future recurringSubscription(formData, String subscriptionId, BuildContext context)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    try {
      isRecurringSubscription.value = true;
      final response = await apiService.putApi(
          '${ApiConstants.baseUrl + ApiConstants.recurringSubscription}/$subscriptionId/toggle',
          formData,
          token);
      print(response);
      if (response['success'] == true) {
        Get.back();
        fetchRecurringUpcoming();
        FlushBarHelper.flushBarSuccessMessage(response['message'], context);
      } else {
        FlushBarHelper.flushBarErrorMessage(
            response['error'] ?? 'Failed to Update Recurring Subsction', context);
      }
    } catch (e) {
      print('Update Recurring Subscription error : $e');
      FlushBarHelper.flushBarErrorMessage(
          'An error occurred update recurring subscription', context);
    } finally {
      isRecurringSubscription.value = false;
    }
  }


  Future editRecurringOrder(formData, String orderId, BuildContext context)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    try {
      isRecurringSubscription.value = true;
      final response = await apiService.putApi(
          '${ApiConstants.baseUrl + ApiConstants.editRecurringOrder}/$orderId',
          formData,
          token);
      print(response);
      if (response['success'] == true) {
        Get.back();
        fetchRecurringUpcoming();
        FlushBarHelper.flushBarSuccessMessage(response['message'], context);
      } else {
        FlushBarHelper.flushBarErrorMessage(
            response['error'] ?? 'Failed to Edit Recurring Order', context);
      }
    } catch (e) {
      print('Update Recurring Subscription error : $e');
      FlushBarHelper.flushBarErrorMessage(
          'An error occurred edit recurring order', context);
    } finally {
      isRecurringSubscription.value = false;
    }
  }

  List<CustomerModels.Order> get pendingOrders => allPendingOrders;
  List<RecurringModels.Order> get recurringOrders => allRecurringOrders;
}