import 'package:aqua_flow/utils/helper_methods.dart';
import 'package:aqua_flow/views/bills/bills_controller.dart';
import 'package:aqua_flow/views/bills/widgets/bills_widget.dart';
import 'package:aqua_flow/views/bills/widgets/empty_state_widget.dart';
import 'package:aqua_flow/views/bills/widgets/summary_card_widget.dart';
import 'package:aqua_flow/views/bills/widgets/tabs_widget.dart';
import 'package:flutter/material.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:get/get.dart';

class BillsView extends StatefulWidget {
  const BillsView({super.key});

  @override
  State<BillsView> createState() => _BillsViewState();
}

class _BillsViewState extends State<BillsView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BillsController());
    controller.fetchOrderPayments(context);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final allPayments =
            controller.orderPaymentData.value?.payments ?? [];
        final summary = controller.orderPaymentData.value?.summary;

        // 🔥 FILTER LOGIC
        final filteredPayments = allPayments.where((payment) {
          final selectedTab = controller.selectedTab.value;

          switch (selectedTab) {
            case 1: // Immediate
              return payment.collectionType == 'IMMEDIATE';

            case 2: // Monthly
              return payment.collectionType == 'RECURRING';

            case 3: // Overdue
              return payment.collectionType == 'OVERDUE';

            default: // All
              return true;
          }
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              padding: EdgeInsets.all(ScreenConstants.horizontalPadding),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.themeColor,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    CustomText(
                      text: 'Billing & Payments',
                      fontSize: 22,
                      weight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: 'Manage your finances',
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                    const SizedBox(height: 20),
                
                    // SUMMARY
                    if (summary != null)
                      Row(
                        children: [
                          Expanded(
                            child: summaryCard(
                              title: "Total Paid",
                              value:
                                  "₨ ${HelperMethods().formatNumber(summary.totalPaid)}",
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: summaryCard(
                              title: "Total Pending",
                              value:
                                  "₨ ${HelperMethods().formatNumber(summary.totalPending)}",
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenConstants.horizontalPadding,
                  vertical: ScreenConstants.verticalPadding,
                ),
                child: Column(
                  children: [
                    buildTabs(controller),
                    const SizedBox(height: 16),

                    if (filteredPayments.isEmpty)
                      buildEmptyState("No payment found")
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredPayments.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: buildBillItem(filteredPayments[index]),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}