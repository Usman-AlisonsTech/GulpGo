
  import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget buildSectionCard(
      {required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.3),
            offset: const Offset(0, 3),
            blurRadius: 2,
            spreadRadius: 0.2,
          ),
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.3),
            offset: const Offset(3, 0),
            blurRadius: 2,
            spreadRadius: 0.2,
          ),
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.3),
            offset: const Offset(-3, 0),
            blurRadius: 2,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: title,
              fontSize: 16,
              weight: FontWeight.w600,
              color: ColorConstants.themeColor),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  // Info Row
  Widget buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 24, color: ColorConstants.themeColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: label, fontSize: 12, color: Colors.grey[600]),
                const SizedBox(height: 4),
                CustomText(text: value, fontSize: 15, weight: FontWeight.w600),
              ],
            ),
          ),
        ],
      ),
    );
  }