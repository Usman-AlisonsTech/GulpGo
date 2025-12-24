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

        // Delivery Date
        CustomText(
          text: "Delivery Date*",
          fontSize: 14,
          weight: FontWeight.w500,
          color: ColorConstants.darkGreyColor,
        ),
        SizedBox(height: 10),
        CustomTextField(
          readOnly: true,
          controller: controller.dateController,
          borderColor: ColorConstants.lightGrey,
          suffixIcon: GestureDetector(
            onTap: () => controller.pickDate(context),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.calendar_month),
            ),
          ),
        ),

        const SizedBox(height: 15),

        Obx(() {
          if (controller.totalDeposit.value > 0) {
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

        if (controller.withBottles.value)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Deposit Amount Taking (PKR)*",
                fontSize: 14,
                weight: FontWeight.w500,
                color: ColorConstants.darkGreyColor,
              ),
              SizedBox(height: 10),
              CustomTextField(
                borderColor: ColorConstants.lightGrey,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  print('usman');
                  final depositTaking = int.tryParse(value) ?? 0;
                  controller.depositAmountTaking.value = depositTaking;
                  controller.updateGrandTotal();
                },
              ),
              const SizedBox(height: 15),
            ],
          ),

        // Delivery Address
        CustomText(
          text: "Delivery Address*",
          fontSize: 14,
          weight: FontWeight.w500,
          color: ColorConstants.darkGreyColor,
        ),
        SizedBox(height: 10),
        CustomTextField(
          borderColor: ColorConstants.lightGrey,
          controller: controller.addressController,
        ),
      ],
    );
  }
}