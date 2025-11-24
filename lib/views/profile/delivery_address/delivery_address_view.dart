import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:aqua_flow/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DeliveryAddressView extends StatelessWidget {
  const DeliveryAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenConstants.horizontalPadding,
            vertical: ScreenConstants.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
             Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(50),
                      child: 
                         SvgPicture.asset('assets/svg/back.svg'),
                      
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Delivery Address',
                        fontSize: 18,
                weight: FontWeight.w500,
                        ),
                         const CustomText(
                text: 'Manage your delivery addresses',
                fontSize: 13,
                color: Color(0xff4A4A4A),
                weight: FontWeight.w500,
              ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: Color(0xffD1D4D9)),

                const SizedBox(height: 20),

              /// Address Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Color(0xffE5E5E5)),
               boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: const Offset(0, 3),
                                      blurRadius: 2,
                                      spreadRadius: 0.6,
                                    ),
                                
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: const Offset(-3, 0),
                                      blurRadius: 2,
                                      spreadRadius: 0.6,
                                    ),
                                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Current Address',
                      fontSize: 15,
                      weight: FontWeight.w500,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      hintText: "Enter your delivery address",
                      lines: 3,
                      borderRadius: 8,
                      leftPadding: 12,

                      borderColor: ColorConstants.lightGrey,
                    ),

                    const SizedBox(height: 20),

                    CommonButton(
                      title: "Update Address",
                      onPressed: () {
                         Get.dialog(
  Center(
    child: Material(
      color: Colors.transparent,  // IMPORTANT FIX
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Update Address',
                  fontSize: 23,
                  weight: FontWeight.w600,
                  color: Colors.black,
                ),
              ],
            ),

            SizedBox(height: 30),

            /// YOUR TEXTFIELD NOW WORKS
            // CustomTextField(
            //   hintText: "Enter new address",
            //   labelText: 'Delivery Address',
            //   lines: 3,
            // ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 110,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ColorConstants.themeColor),
                    ),
                    child: Center(
                      child: CustomText(
                        text: 'Cancel',
                        color: ColorConstants.themeColor,
                        fontSize: 12,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 110,
                    height: 28,
                    decoration: BoxDecoration(
                      color: ColorConstants.themeColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ColorConstants.themeColor),
                    ),
                    child: Center(
                      child: CustomText(
                        text: 'Update',
                        color: Colors.white,
                        fontSize: 12,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
);

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
