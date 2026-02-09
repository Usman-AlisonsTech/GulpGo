import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget summaryCard({
  required String title,
  required String value,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        CustomText(text: title, fontSize: 13, color: Colors.white70),
        const SizedBox(height: 8),
        CustomText(
          text: value,
          fontSize: 22,
          weight: FontWeight.w800,
          color: Colors.white,
        ),
      ],
    ),
  );
}
