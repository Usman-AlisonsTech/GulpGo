import 'package:aqua_flow/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/custom_text.dart';

class BillsView extends StatefulWidget {
  const BillsView({super.key});

  @override
  State<BillsView> createState() => _BillsViewState();
}

class _BillsViewState extends State<BillsView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenConstants.horizontalPadding,
            vertical: ScreenConstants.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const CustomText(
                text: 'Billing & Payments',
                fontSize: 18,
                weight: FontWeight.w500,
              ),
              const CustomText(
                text: 'Manage your finances',
                fontSize: 13,
                color: Color(0xff4A4A4A),
                weight: FontWeight.w500,
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Divider(color: Color(0xffD1D4D9)),
              ),
              const SizedBox(height: 16),

              // Current Balance Card
              _buildBalanceCard(),
              const SizedBox(height: 20),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      "Total Paid",
                      "\$132.00",
                      "Last 3 months",
                      Icons.trending_up,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      "Invoices",
                      "12",
                      "This year",
                      Icons.description,
                      ColorConstants.themeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildTabBar(),
              const SizedBox(height: 16),

              // Content based on tab
              if (_selectedTab == 0) ...[
                _buildBillItem(
                  invoice: "INV-1234",
                  date: "Nov 1, 2025",
                  due: "Due: Nov 15, 2025",
                  amount: "\$48.50",
                  status: "Pending",
                  statusColor: Color(0xffA65F00),
                  showPayNow: true,
                ),
                const SizedBox(height: 12),
                _buildBillItem(
                  invoice: "INV-1233",
                  date: "Oct 1, 2025",
                  paidOn: "Paid on: Oct 28, 2025",
                  amount: "\$36.00",
                  status: "Paid",
                  statusColor: Colors.green,
                  showDownloadReceipt: true,
                ),
              ] else ...[
                _buildPaymentHistoryItem(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: Row(
        children: [
          // Bills Tab
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTab == 0 ? Colors.white : Colors.transparent,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                ),
                child: Center(
                  child: CustomText(
                    text: "Bills",
                    fontSize: 14,
                    weight: FontWeight.w500,
                    color: _selectedTab == 0 ? Colors.black87 : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          // Payment History Tab
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTab == 1 ? Colors.white : Colors.transparent,
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
                ),
                child: Center(
                  child: CustomText(
                    text: "Payment History",
                    fontSize: 14,
                    weight: FontWeight.w500,
                    color: _selectedTab == 1 ? Colors.black87 : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PAY-5678 + $36.00
          Row(
            children: [
              const CustomText(
                text: "PAY-5678",
                fontSize: 16,
                weight: FontWeight.w500,
              ),
              const Spacer(),
              const CustomText(
                text: "\$36.00",
                fontSize: 18,
                weight: FontWeight.w500,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Date
          Row(
            children:  [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              CustomText(
                text: "Oct 28, 2025",
                fontSize: 13,
                color: ColorConstants.darkGreyColor,
                weight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Credit Card • For INV-1233
           CustomText(
            text: "Credit Card • For INV-1233",
            fontSize: 13,
            color: ColorConstants.darkGreyColor,
            weight: FontWeight.w500,
          ),
          const SizedBox(height: 25),

          // Download Receipt Button
          CommonButton(
            title: "Download Receipt",
            onPressed: () {},
            textColor: Colors.black87,
            verticalPadding: 8,
            bgColor: Colors.white,
            borderColor: ColorConstants.lightGrey,
            icon: const Icon(Icons.download, size: 20),
          ),
        ],
      ),
    );
  }


  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorConstants.themeColor, const Color(0xff4BBFF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Current Balance",
            fontSize: 14,
            color: Colors.white70,
            weight: FontWeight.w500,
          ),
          const SizedBox(height: 15),
          const CustomText(
            text: "\$48.50",
            fontSize: 32,
            color: Colors.white,
            weight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(
                      text: "Due Date",
                      fontSize: 12,
                      color: Colors.white70,
                      weight: FontWeight.w500,
                    ),
                    CustomText(
                      text: "Nov 15, 2025",
                      fontSize: 14,
                      color: Colors.white,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(
                      text: "Days Left",
                      fontSize: 12,
                      color: Colors.white70,
                      weight: FontWeight.w500,
                    ),
                    CustomText(
                      text: "11 days",
                      fontSize: 14,
                      color: Colors.white,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          CommonButton(
            title: "Pay Now",
            onPressed: () {},
            bgColor: Colors.white,
            textColor: ColorConstants.themeColor,
            fontSize: 14,
            verticalPadding: 8,
            borderRadius: 8,
            borderColor: Colors.white,
            icon: Icon(Icons.payment, size: 20, color: ColorConstants.themeColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorConstants.lightGrey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 6),
              CustomText(
                text: title,
                fontSize: 13,
                color: Colors.grey[700],
                weight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomText(
            text: value,
            fontSize: 20,
            weight: FontWeight.w500,
          ),
          const SizedBox(height: 12),
          CustomText(
            text: subtitle,
            fontSize: 12,
            color: Colors.grey[600],
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildBillItem({
    required String invoice,
    required String date,
    String? due,
    String? paidOn,
    required String amount,
    required String status,
    required Color statusColor,
    bool showPayNow = false,
    bool showDownloadReceipt = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                text: invoice,
                fontSize: 16,
                weight: FontWeight.w500,
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomText(
                  text: status,
                  fontSize: 11,
                  color: statusColor,
                  weight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              CustomText(
                text: amount,
                fontSize: 18,
                weight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              CustomText(
                text: date,
                fontSize: 13,
                color: ColorConstants.darkGreyColor,
                weight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 25),
          if (due != null)
            CustomText(
              text: due,
              fontSize: 13,
              color: ColorConstants.darkGreyColor,
              weight: FontWeight.w500,
            ),
          if (paidOn != null)
            CustomText(
              text: paidOn,
              fontSize: 13,
              color: Colors.green,
              weight: FontWeight.w500,
            ),
          const SizedBox(height: 25),
          if (showPayNow || showDownloadReceipt)
            Row(
              children: [
                if (showPayNow)
                  Expanded(
                    child: CommonButton(
                      title: "Pay Now",
                      onPressed: () {},
                      verticalPadding: 8,
                      textColor: Colors.white,
                    ),
                  ),
                if (showPayNow) const SizedBox(width: 12),
                if (showDownloadReceipt || showPayNow)
                  Expanded(
                    child: CommonButton(
                      title: showDownloadReceipt ? "Download Receipt" : "Download",
                      onPressed: () {},
                      textColor: Colors.black87,
                      verticalPadding: 8,
                      bgColor: Colors.white,
                      borderColor: ColorConstants.lightGrey,
                      icon: const Icon(Icons.download, size: 20),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}