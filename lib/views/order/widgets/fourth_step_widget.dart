import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FourthStepWidget extends StatelessWidget {
  const FourthStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Color(0xffDBFCE7),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Color(0xff00C951),
            size: 40,
          ),
        ),
        const SizedBox(height: 20),

        // Title
        CustomText(
          text: "Order Placed Successfully!",
          fontSize: 18,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),

        // Subtitle
        CustomText(
          text: "Your order has been confirmed",
          fontSize: 14,
          color: ColorConstants.darkGreyColor,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        CommonButton(
          title: 'Back to Home',
          onPressed: () {
            Get.offAll(BottomNavigation(index: 0));
          },
          textColor: Colors.white,
          verticalPadding: 8,
        ),
      ],
    );
  }
}

// // Reusable row for summary
// class _SummaryRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const _SummaryRow({
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CustomText(
//             text: label,
//             fontSize: 13,
//             color: ColorConstants.darkGreyColor,
//           ),
//           CustomText(
//             text: value,
//             fontSize: 13,
//           ),
//         ],
//       ),
//     );
//   }
// }