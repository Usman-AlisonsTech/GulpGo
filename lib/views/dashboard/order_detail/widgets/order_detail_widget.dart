import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class OrderDetailWidgets {
  Widget buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Size size,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: ColorConstants.darkGreyColor,
          size: size.width * 0.045,
        ),
        SizedBox(width: size.width * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: label,
                fontSize: size.width * 0.032,
                color: ColorConstants.darkGreyColor,
              ),
              SizedBox(height: size.height * 0.003),
              CustomText(
                  text: value,
                  fontSize: size.width * 0.038,
                  weight: FontWeight.w500),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPaymentRow(String label, String value, Size size, bool isBold) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          fontSize: size.width * 0.038,
          weight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isBold ? Colors.black : Colors.grey[700],
        ),
        CustomText(
          text: value,
          fontSize: size.width * 0.038,
          weight: isBold ? FontWeight.bold : FontWeight.w600,
          color: isBold ? Colors.black : Colors.black87,
        ),
      ],
    );
  }
}
