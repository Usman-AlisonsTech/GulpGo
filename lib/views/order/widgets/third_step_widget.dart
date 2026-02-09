import 'package:aqua_flow/views/order/order_controller.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdStepWidget extends StatefulWidget {
  const ThirdStepWidget({super.key});

  @override
  State<ThirdStepWidget> createState() => _ThirdStepWidgetState();
}

class _ThirdStepWidgetState extends State<ThirdStepWidget> {
  // int? selectedPaymentMethod;

  final controller = Get.find<OrderController>();

  // final List<Map<String, dynamic>> paymentMethods = [
  //   {
  //     'method': 'Cash on Delivery',
  //     'description': 'Pay when you recieve',
  //   },
  //   {
  //     'method': 'Credit/Debit Card',
  //     'description': 'Vise/ Mastercard',
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        const CustomText(
          text: "Confirm Order",
          fontSize: 17,
          weight: FontWeight.w500,
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffEFF6FF),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Obx(() {
            return Column(
              children: [
                // Title
                _buildPriceRow("Order Summary", ""),

                const SizedBox(height: 20),

                // Total Items
                _buildPriceRow(
                  "Total Items",
                  controller.totalItems.toString(),
                  isOrderedList: true,
                ),

                // Subtotal
                _buildPriceRow(
                  "Subtotal",
                  "PKR ${controller.totalAmount.value}",
                  isOrderedList: true,
                ),

                // Deposit Available (only if bottles)
                if (controller.withBottles.value &&
                    controller.totalDeposit.value > 0)
                  _buildPriceRow(
                    "Total Deposit Taking",
                    "PKR ${controller.totalDeposit.value}",
                    isOrderedList: true,
                  ),

                const SizedBox(height: 20),
                const Divider(height: 1, thickness: 1),
                const SizedBox(height: 20),

                // Grand Total
                _buildPriceRow(
                  "Total Amount",
                  "PKR ${controller.grandTotal.value}",
                  isTotal: true,
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  // Widget _buildPaymentMethods({
  //   required String method,
  //   required String description,
  //   required bool isSelected,
  //   required IconData icon,
  //   required VoidCallback? onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(12),
  //         border: Border.all(
  //           color: isSelected ? Colors.blue : const Color(0xffE0E0E0),
  //           width: 1.5,
  //         ),
  //       ),
  //       child: Row(
  //         children: [
  //           // Radio dot
  //           Container(
  //             width: 18,
  //             height: 18,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               border: Border.all(
  //                 color: isSelected ? Colors.blue : Colors.grey[400]!,
  //                 width: 2,
  //               ),
  //               color: isSelected ? Colors.blue : Colors.transparent,
  //             ),
  //             child: isSelected
  //                 ? const Icon(Icons.circle, size: 12, color: Colors.white)
  //                 : null,
  //           ),
  //           const SizedBox(width: 10),

  //           // Money icon
  //           Icon(icon, size: 18, color: Colors.blue),
  //           const SizedBox(width: 12),

  //           // Method name
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 CustomText(
  //                   text: method,
  //                   fontSize: 15,
  //                   color: Colors.black,
  //                 ),
  //                 CustomText(
  //                   text: description,
  //                   color: ColorConstants.darkGreyColor,
  //                   fontSize: 12,
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPriceRow(String label, String amount,
      {bool isTotal = false, bool isOrderedList = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          fontSize: isTotal
              ? 15
              : isOrderedList
                  ? 13
                  : 16,
        ),
        CustomText(
          text: amount,
          fontSize: isTotal
              ? 18
              : isOrderedList
                  ? 13
                  : 15,
          weight: FontWeight.w500,
        ),
      ],
    );
  }
}
