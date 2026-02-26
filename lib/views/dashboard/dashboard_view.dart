import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/helper_methods.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation.dart';
import 'package:aqua_flow/views/dashboard/dashboard_controller.dart';
import 'package:aqua_flow/views/dashboard/widgets/dashboard_summary_card_widget.dart';
import 'package:aqua_flow/views/dashboard/widgets/orders_container_widget.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final controller = Get.find<DashboardController>();
  @override
  void initState() {
    super.initState();
    controller.loadCustomerFromLocal();
    controller.fetchCustomerOrders();
    controller.fetchCustomerBottleInfo();
    controller.loadCompanyDataFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    controller.currentTabIndex.value = 0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: ScreenConstants.horizontalPadding,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.themeColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    CustomText(
                      text: 'Welcome',
                      fontSize: 22,
                      weight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Obx(() {
                      if (controller.isCustomerDataLoading.value) {
                        return CustomText(
                          text: "Loading...",
                          color: Colors.white70,
                          fontSize: 15,
                        );
                      }
                      return CustomText(
                        text: controller.customerData['name'] ?? "-",
                        fontSize: 15,
                        color: Colors.white70,
                      );
                    }),
                    const SizedBox(height: 16),
                    Obx(() {
                      if (controller.isBottleInfoLoading.value) {
                        return Row(
                          children: [
                            Expanded(child: summaryCardShimmer()),
                            const SizedBox(width: 10),
                            Expanded(child: summaryCardShimmer()),
                            const SizedBox(width: 10),
                            Expanded(child: summaryCardShimmer()),
                          ],
                        );
                      }

                      final bottlesInfo =
                          controller.customerBottleInfo.value?.bottlesInfo;
                      if (bottlesInfo == null) {
                        return const SizedBox.shrink();
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: dashboardSummaryCard(
                              title: 'Total Bottles Given',
                              value: '${bottlesInfo.totalBottlesGiven ?? 0}',
                              color: Colors.orange,
                              isStatCard: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: dashboardSummaryCard(
                              title: 'Security Deposit',
                              value:
                                  '${HelperMethods().formatNumber(bottlesInfo.securityDeposit ?? 0)}',
                              color: Colors.blueAccent,
                              isStatCard: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: dashboardSummaryCard(
                              title: 'Empty Bottles Available',
                              value: '${bottlesInfo.emptiesAvailable ?? 0}',
                              color: Colors.greenAccent,
                              isStatCard: true,
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: dashboardSummaryCard(
                            title: 'Request Water',
                            value: 'Order bottles now',
                            color: Colors.green,
                            ontap: () => Get.offAll(BottomNavigation(index: 1)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: dashboardSummaryCard(
                            title: 'Support',
                            value: 'Call our 24/7 Support',
                            color: Colors.orange,
                            phoneNumber: controller.companyAdminData['phone'],
                            isCallSupport: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // tabbar

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: TabBar(
                onTap: (index) {
                  controller.currentTabIndex.value = index;
                  if (index == 0) {
                    controller.fetchCustomerOrders();
                  } else if (index == 1) {
                    controller.fetchRecurringUpcoming();
                  }
                },
                indicator: BoxDecoration(
                  color: ColorConstants.themeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black87,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CustomText(
                      text: "All Orders",
                      fontSize: 13,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CustomText(
                      text: "Upcoming",
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.currentPage.value == 1) {
                  return Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // Check which tab is active
                final isActiveOrdersTab = controller.currentTabIndex.value == 0;
                final orders = isActiveOrdersTab
                    ? controller.pendingOrders
                    : controller.recurringOrders;

                return RefreshIndicator(
                   onRefresh: ()async{
                      Future.wait([    
                      controller.fetchCustomerOrders(),
                     controller.fetchRecurringUpcoming()
                ]);
              },
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstants.horizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (orders.isEmpty && !controller.isLoading.value)
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 100),
                                child: CustomText(
                                  text: isActiveOrdersTab
                                      ? 'No Orders Found.'
                                      : 'No Recurring Orders Found.',
                                  color: ColorConstants.darkGreyColor,
                                ),
                              ),
                            ),
                          /// Orders List
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: orders.length,
                            separatorBuilder: (_, __) => SizedBox(height: 15),
                            itemBuilder: (context, index) {
                              print(orders[index]);
                              return orderContainer(orders[index], context,
                                  isRecurring: !isActiveOrdersTab);
                            },
                          ),
                  
                          if (controller.isLoadingMore.value && isActiveOrdersTab)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                  
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
