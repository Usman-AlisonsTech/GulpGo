import 'package:aqua_flow/models/order_payment_model.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/helper_methods.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget buildBillItem(Payment payment) {
  final paidAmount = payment.paidAmount ?? 0;
  final pendingAmount = payment.pendingAmount ?? 0;
  final status = payment.status ?? 'UNKNOWN';
  final dueDate = payment.dueDate != null
      ? HelperMethods().formatDate(payment.dueDate.toString())
      : 'N/A';
  final orderNumber = payment.order?.orderNumberDisplay ?? 'N/A';
  final collectionType = payment.collectionType ?? 'IMMEDIATE';

  /// -------- STATUS (ONLY API BASED) --------
  final String statusDisplay = status.toUpperCase();

  Color statusBadgeColor;
  Color backgroundColor;

  switch (statusDisplay) {
    case 'OVERDUE':
      statusBadgeColor = Colors.red;
      backgroundColor = Colors.red.withValues(alpha: 0.15);
      break;

    case 'PAID':
    case 'PARTIAL':
      statusBadgeColor = Colors.green;
      backgroundColor = Colors.green.withValues(alpha: 0.15);
      break;

    default:
      statusBadgeColor = Colors.blue;
      backgroundColor = Colors.blue.withValues(alpha: 0.15);
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ---------- HEADER BADGES ----------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCollectionBadge(collectionType),
            _statusBadge(statusDisplay, statusBadgeColor),
          ],
        ),
        const SizedBox(height: 16),

        /// ---------- ORDER INFO ----------
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.receipt_long,
                  size: 22, color: ColorConstants.themeColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Order $orderNumber",
                    fontSize: 17,
                    weight: FontWeight.w700,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: payment.paymentNumber ?? 'N/A',
                    fontSize: 13,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        /// ---------- AMOUNT + DATE ----------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                    text: 'Pending Amount',
                    fontSize: 12,
                    color: Colors.black54),
                const SizedBox(height: 4),
                CustomText(
                  text: 'PKR ${HelperMethods().formatNumber(pendingAmount)}',
                  fontSize: 20,
                  weight: FontWeight.w700,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CustomText(
                    text: 'Due Date', fontSize: 12, color: Colors.black54),
                const SizedBox(height: 4),
                CustomText(
                  text: dueDate,
                  fontSize: 14,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),

        /// ---------- PARTIAL PAYMENT ----------
        if (statusDisplay == 'PARTIAL') ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 16, color: Colors.green),
                const SizedBox(width: 6),
                CustomText(
                  text: 'Paid: PKR ${HelperMethods().formatNumber(paidAmount)}',
                  color: Colors.green,
                  fontSize: 13,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 14),
        Divider(color: Colors.black26),
        const SizedBox(height: 12),

        Row(
          children: [
            Icon(Icons.shopping_bag, size: 18, color: Colors.black54),
            const SizedBox(width: 8),
            CustomText(
              text: 'Items',
              weight: FontWeight.w700,
              fontSize: 14,
            ),
          ],
        ),
        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: payment.paymentItems?.map<Widget>((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: ColorConstants.themeColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomText(
                            text: '${item.productName} × ${item.quantity}',
                            fontSize: 13,
                            weight: FontWeight.w500,
                          ),
                        ),
                        CustomText(
                          text:
                              'PKR ${HelperMethods().formatNumber(item.totalAmount)}',
                          fontSize: 13,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCollectionBadge(String type) {
  Color bgColor;
  Color textColor;
  String label;

  switch (type) {
    case 'IMMEDIATE':
      bgColor = Colors.orange[50]!;
      textColor = Colors.orange;
      label = 'IMMEDIATE';
      break;

    case 'RECURRING':
      bgColor = Colors.blue[50]!;
      textColor = Colors.blue;
      label = 'MONTHLY';
      break;

    default:
      bgColor = Colors.grey[200]!;
      textColor = Colors.grey[700]!;
      label = type;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _statusBadge(String statusDisplay, Color statusColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: statusColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: CustomText(
      text: statusDisplay,
      fontSize: 12,
      color: Colors.white,
      weight: FontWeight.w600,
    ),
  );
}
