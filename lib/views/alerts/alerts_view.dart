import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AlertsView extends StatelessWidget {
  const AlertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenConstants.horizontalPadding,
              vertical: ScreenConstants.verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const CustomText(
                  text: 'Notifications',
                  fontSize: 18,
                  weight: FontWeight.w500,
                ),
                // const SizedBox(height: 4),
          
                // Subtitle + Mark All Read
                Row(
                  children: [
                    const CustomText(
                      text: '2 unread messages',
                      fontSize: 13,
                      color: Color(0xff4A4A4A),
                      weight: FontWeight.w500,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: CustomText(
                        text: 'Mark All Read',
                        fontSize: 13,
                        color: ColorConstants.themeColor,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
          
                // Divider
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Divider(color: Color(0xffD1D4D9)),
                ),
                const SizedBox(height: 16),
          
                // Notification Items
                _buildNotificationItem(
                  icon: Icons.local_shipping,
                  iconColor: ColorConstants.themeColor,
                  title: "Order Out for Delivery",
                  body: "Your order #1234 is on the way. Expected delivery: 2:00 PM",
                  timeAgo: "15 min ago",
                  hasUnreadDot: true,
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.payment,
                  iconColor: Colors.orange,
                  title: "Payment Reminder",
                  body: "Your bill of Pkr 48.50 is due on Nov 15, 2025",
                  timeAgo: "2 hours ago",
                  hasUnreadDot: true,
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  title: "Order Delivered",
                  body: "Your order #1233 has been successfully delivered",
                  timeAgo: "1 day ago",
                  hasUnreadDot: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Notification Item
  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String body,
    required String timeAgo,
    required bool hasUnreadDot,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasUnreadDot? Color(0xffEFF6FF) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Circle
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 14,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: body,
                  fontSize: 11,
                  color: ColorConstants.darkGreyColor,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 6),
                CustomText(
                  text: timeAgo,
                  fontSize: 10,
                  color: ColorConstants.greyColor,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),

          // Unread Dot
          if (hasUnreadDot)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: ColorConstants.themeColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}