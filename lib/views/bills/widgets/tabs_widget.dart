import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/bills/bills_controller.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildTabs(BillsController controller) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Obx(() {
      return Row(
        children: [
          _buildTabChip('All', 0, controller),
          _buildTabChip('Immediate', 1, controller),
          _buildTabChip('Monthly', 2, controller),
          _buildTabChip('Overdue', 3, controller),
        ],
      );
    }),
  );
}

Widget _buildTabChip(String label, int index, BillsController controller) {
  final isSelected = controller.selectedTab.value == index;
  return GestureDetector(
    onTap: () => controller.selectedTab.value = index,
    child: Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? ColorConstants.themeColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: label,
        fontSize: 13,
        color: isSelected ? Colors.white : Colors.black87,
        weight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    ),
  );
}
