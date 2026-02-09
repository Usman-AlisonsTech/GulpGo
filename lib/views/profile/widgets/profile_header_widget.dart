// Profile Header
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/profile/profile_controller.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildProfileHeader() {
  final controller = Get.find<ProfileController>();
  return Obx(() {
    final data = controller.customerData;

    final String name = data['name'] ?? '';
    final String phone = data['phone'] ?? '';

    final String initials = name.isNotEmpty
        ? name.split(' ').take(2).map((e) => e[0].toUpperCase()).join()
        : '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorConstants.themeColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        children: [
          // Avatar with initials
          CircleAvatar(
            radius: 33,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: ColorConstants.themeColor.withValues(alpha:0.2),
              child: CustomText(
                text: initials,
                fontSize: 23,
                weight: FontWeight.bold,
                color: ColorConstants.themeColor,
              ),
            ),
          ),
          const SizedBox(width: 18),

          // Name + Vehicle + Stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontSize: 18,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: phone,
                  fontSize: 14,
                  color: Colors.white.withValues(alpha:0.9),
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}
