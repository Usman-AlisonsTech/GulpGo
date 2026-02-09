import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget buildEmptyState(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Icon(Icons.receipt_long, size: 64, color: ColorConstants.lightGrey),
          const SizedBox(height: 16),
          CustomText(
            text: message,
            fontSize: 16,
            color: ColorConstants.darkGreyColor,
            weight: FontWeight.w500,
          ),
        ],
      ),
    ),
  );
}
