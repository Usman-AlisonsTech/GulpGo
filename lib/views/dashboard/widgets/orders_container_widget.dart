import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/helper_methods.dart';
import 'package:aqua_flow/views/dashboard/order_detail/order_detail_view.dart';
import 'package:aqua_flow/views/dashboard/widgets/dashboard_dialogs_widget.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget orderContainer(dynamic order, BuildContext context,
    {bool isRecurring = false}) {
  List<String> itemsText = [];
  bool isSubscriptionActive = false;
  String subscriptionId = '';

  if (isRecurring) {
    // For recurring orders, items are maps
    itemsText = (order.items as List)
        .map((e) {
          return '${e.quantity} × ${e.product}';
        })
        .toList()
        .cast<String>();
  } else {
    // For regular orders, items have product object
    itemsText = (order.items as List)
        .map((e) {
          return '${e.quantity} × ${e.product?.name}';
        })
        .toList()
        .cast<String>();
  }

  final statusColor = _getStatusColor(order.status ?? '-');
  if (isRecurring) {
    isSubscriptionActive =
        order.subscription?.status?.toUpperCase() == 'ACTIVE';

    subscriptionId = order.subscription?.id ?? '';

    print(isSubscriptionActive);
    print(subscriptionId);
  }
  double totalAmount = 0;
  if (isRecurring) {
    totalAmount = (order.items as List)
        .fold(0.0, (sum, item) => sum + ((item.total ?? 0) as num).toDouble());
  } else {
    totalAmount = order.totalAmount?.toDouble() ?? 0.0;
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha:0.15),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ================= HEADER =================
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Left stripe + icon
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: ColorConstants.themeColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),

            /// Order info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        'Order ${isRecurring ? (order.orderNumber ?? '-') : (order.orderNumberDisplay ?? '-')}',
                    fontSize: 16,
                    weight: FontWeight.w700,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha:0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      text: (order.status ?? '-').toUpperCase(),
                      fontSize: 11,
                      color: statusColor,
                      weight: FontWeight.w600,
                    ),
                  ),
                  if (isRecurring && order.subscription != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha:0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CustomText(
                          text: order.subscription.recurrence ?? 'RECURRING',
                          fontSize: 10,
                          color: Colors.blue,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// Amount
                CustomText(
                  text: 'Rs ${HelperMethods().formatNumber(totalAmount)}',
                  fontSize: 18,
                  weight: FontWeight.w800,
                ),

                if (isRecurring) ...[
                  const SizedBox(height: 6),
                  Transform.scale(
                    scale: 0.75,
                    child: CupertinoSwitch(
                      value: isSubscriptionActive,
                      activeTrackColor: ColorConstants.themeColor,
                      onChanged: (val) async {
                        bool confirm = await showDialog(
                              context: context,
                              builder: (_) => UnsubscribeDialog(
                                isActive: isSubscriptionActive,
                                context: context,
                                subscriptionId: subscriptionId,
                              ),
                            ) ??
                            false;
                      },
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// ================= ITEMS =================
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: itemsText
              .map<Widget>(
                (item) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText(
                    text: item,
                    fontSize: 12,
                    weight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              )
              .toList(),
        ),

        const SizedBox(height: 18),
        Divider(color: Colors.grey[300]),
        const SizedBox(height: 12),

        /// ================= DATE + ZONE =================
        Row(
          children: [
            Icon(Icons.calendar_today,
                size: 16, color: ColorConstants.darkGreyColor),
            const SizedBox(width: 6),
            CustomText(
              text: HelperMethods().formatDate(order.deliveryDate.toString()),
              fontSize: 13,
              color: ColorConstants.darkGreyColor,
            ),
            const SizedBox(width: 8),
            if (!isRecurring && order.zone?.name != null)
              Expanded(
                // 👈 yeh full fix hai
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.location_on,
                        size: 16, color: ColorConstants.darkGreyColor),
                    const SizedBox(width: 4),
                    Flexible(
                      child: CustomText(
                        text: order.zone!.name!,
                        fontSize: 13,
                        color: ColorConstants.darkGreyColor,
                        textOverflow: TextOverflow.ellipsis,
                        lines: 2,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),

        const SizedBox(height: 18),

        /// ================= BUTTON =================
        CommonButton(
          onPressed: () {
            if (isRecurring) {
              showDialog(
                context: context,
                builder: (_) => EditRecurringOrderDialog(
                  orderId: order.id ?? '',
                  quantity: (order.items?.first.quantity ?? 0),
                  deliveryDate:
                      HelperMethods().formatDate(order.deliveryDate.toString()),
                  skipThisWeek: (order.status?.toLowerCase() == 'cancelled'),
                ),
              );
            } else {
              Get.to(OrderDetailView(orders: order));
            }
          },
          title: isRecurring ? 'Edit' : 'View Details',
          bgColor: ColorConstants.themeColor.withValues(alpha: 0.1),
          borderColor: ColorConstants.themeColor.withValues(alpha:0.1),
          shadowColor: Colors.white,
          verticalPadding: 10,
          textColor: ColorConstants.themeColor,
          trailingIcon: Icon(Icons.arrow_forward,
              size: 20, color: ColorConstants.themeColor),
        ),
      ],
    ),
  );
}

Color _getStatusColor(status) {
  return status == 'completed'
      ? const Color(0xFF22C55E)
      : status == 'in_progress'
          ? Colors.grey
          : status == 'pending'
              ? const Color(0xFFF59E0B)
              : status == 'confirmed'
                  ? const Color(0xFF3B82F6)
                  : status == 'out_for_delivery'
                      ? const Color(0xFF8B5CF6)
                      : status == 'delivered'
                          ? const Color(0xFF10B981)
                          : status == 'cancelled'
                              ? const Color(0xFFEF4444)
                              : status == 'failed'
                                  ? const Color(0xFF991B1B)
                                  : status == 'assigned'
                                      ? const Color(0xFF0EA5E9)
                                      : const Color(0xFFB45309);
}
