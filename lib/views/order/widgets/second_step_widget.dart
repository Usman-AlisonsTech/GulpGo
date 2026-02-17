import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/order/order_controller.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:aqua_flow/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondStepWidget extends StatefulWidget {
  const SecondStepWidget({super.key});

  @override
  State<SecondStepWidget> createState() => _SecondStepWidgetState();
}

class _SecondStepWidgetState extends State<SecondStepWidget> {
  final controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    if (controller.customerData.isNotEmpty &&
        controller.customerData['address'] != null) {
      controller.addressController.text =
          controller.customerData['address'] ?? '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        const CustomText(
          text: "Enter Delivery Details",
          fontSize: 17,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 15),

        /// DELIVERY DATE
        CustomText(text: "Delivery Date*"),
        const SizedBox(height: 10),

        CustomTextField(
          readOnly: true,
          controller: controller.dateController,
          borderColor: ColorConstants.lightGrey,
          suffixIcon: GestureDetector(
            onTap: () => controller.pickDate(context),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.calendar_month),
            ),
          ),
        ),

        const SizedBox(height: 25),
        Obx(() {
          if (controller.totalDeposit.value > 0) {
            controller.depositAmountTaking.value =
                controller.totalDeposit.value.toInt();
            controller.updateGrandTotal();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Total Deposit Amount (PKR)",
                  fontSize: 14,
                  weight: FontWeight.w500,
                  color: ColorConstants.darkGreyColor,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  borderColor: ColorConstants.lightGrey,
                  controller: TextEditingController(
                    text: controller.totalDeposit.value.toStringAsFixed(0),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 15),
              ],
            );
          }
          return const SizedBox();
        }),

        // Obx(() {
        //   if (!(controller.withBottles.value || controller.isRecurring.value)) {
        //     return const SizedBox();
        //   }

        //   return Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const SizedBox(height: 25),
        //       Transform.scale(
        //         scale: 0.85,
        //         child: SwitchListTile(
        //           contentPadding: EdgeInsets.zero,
        //           title: const CustomText(
        //             text: "Sirf brand new bottles chahiye?",
        //             fontSize: 15,
        //           ),
        //           value: controller.bottlePreference.value == "new_only",
        //           activeThumbColor: ColorConstants.themeColor,
        //           activeTrackColor:
        //               ColorConstants.themeColor.withValues(alpha: 0.4),
        //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //           onChanged: (value) {
        //             controller.bottlePreference.value =
        //                 value ? "new_only" : "auto";
        //             controller.applyBottlePreferenceLogic();
        //           },
        //         ),
        //       ),
        //       const SizedBox(height: 10),
        //       if (controller.bottlePreference.value == "new_only")
        //         CustomText(
        //           text:
        //               "Sirf naye bottles → Deposit Rs ${controller.depositAmountTaking.value}",
        //         ),
        //       const SizedBox(height: 10),
        //       TextButton(
        //         onPressed: () {
        //           showModalBottomSheet(
        //             context: context,
        //             builder: (_) => _advancedSheet(),
        //           );
        //         },
        //         child: const CustomText(
        //           text: "Custom Bottle Choice",
        //           fontSize: 13,
        //         ),
        //       ),
        //       const SizedBox(height: 10),
        //     ],
        //   );
        // }),

        /// RETURN EMPTIES
        // CustomText(text: "Return Empty Bottles (Optional)"),
        // const SizedBox(height: 10),

        // CustomTextField(
        //   keyboardType: TextInputType.number,
        //   onChanged: (v) {
        //     controller.returnEmpties.value = int.tryParse(v) ?? 0;
        //   },
        // ),

        const SizedBox(height: 10),

        /// ADDRESS
        CustomText(text: "Delivery Address*"),
        const SizedBox(height: 10),

        CustomTextField(
            borderColor: ColorConstants.lightGrey,
            controller: controller.addressController),
      ],
    );
  }

  // /// ⭐ ADVANCED SHEET
  // Widget _advancedSheet() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
  //     child: Obx(() {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           CustomText(text: "Custom Bottle Choice", weight: FontWeight.bold),

  //           const SizedBox(height: 20),

  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const CustomText(text: "New Bottles"),
  //               Row(
  //                 children: [
  //                   IconButton(
  //                     icon: const Icon(Icons.remove),
  //                     onPressed: () {
  //                       if (controller.customNewBottles.value > 0) {
  //                         controller.customNewBottles.value--;
  //                         controller.bottlePreference.value = "custom";
  //                         controller.applyBottlePreferenceLogic();
  //                       }
  //                     },
  //                   ),
  //                   CustomText(text: "${controller.customNewBottles.value}"),
  //                   IconButton(
  //                     icon: const Icon(Icons.add),
  //                     onPressed: () {
  //                       controller.customNewBottles.value++;
  //                       controller.bottlePreference.value = "custom";
  //                       controller.applyBottlePreferenceLogic();
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),

  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const CustomText(text: "Refill Bottles"),
  //               Row(
  //                 children: [
  //                   IconButton(
  //                     icon: const Icon(Icons.remove),
  //                     onPressed: () {
  //                       if (controller.customRefillBottles.value > 0) {
  //                         controller.customRefillBottles.value--;
  //                         controller.bottlePreference.value = "custom";
  //                         controller.applyBottlePreferenceLogic();
  //                       }
  //                     },
  //                   ),
  //                   CustomText(text: "${controller.customRefillBottles.value}"),
  //                   IconButton(
  //                     icon: const Icon(Icons.add),
  //                     onPressed: () {
  //                       controller.customRefillBottles.value++;
  //                       controller.bottlePreference.value = "custom";
  //                       controller.applyBottlePreferenceLogic();
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),

  //           const SizedBox(height: 10),

  //           /// VALIDATION
  //           if (controller.customNewBottles.value +
  //                   controller.customRefillBottles.value !=
  //               controller.totalItems)
  //             const CustomText(
  //                 text: "Total bottles must match quantity", color: Colors.red),
  //         ],
  //       );
  //     }),
  //   );
  // }
}
