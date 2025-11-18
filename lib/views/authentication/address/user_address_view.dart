import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:aqua_flow/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressView extends StatelessWidget {
  const UserAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConstants.gradientColor1, ColorConstants.gradientColor2,],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenConstants.horizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// App Icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.water_drop, size: 30, color: Colors.blue),
                  ),

                  const SizedBox(height: 15),

                  /// App Title
                  const CustomText(
                    text: "AquaFlow",
                    fontSize: 30,
                    weight: FontWeight.w500,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 5),

                  /// Subtitle
                  const CustomText(
                    text: "Pure Water, Delivered Fresh",
                    fontSize: 15,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 35),

                  /// White Card Container
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Delivery Address",
                          fontSize: 22,
                          weight: FontWeight.w500,
                          letterSpacing: -1,
                        ),
                        const SizedBox(height: 8),
                        const CustomText(
                          text: "Where should we deliver your \nwater?",
                          fontSize: 15,
                          color: Color(0xff6A7282),
                          weight: FontWeight.w500,
                        ),
                        const SizedBox(height: 20),
                        CustomText(
                          text: 'Address',
                          weight: FontWeight.w500,
                        ),
                        SizedBox(height: 10),

                        /// Phone TextField
                        CustomTextField(
                          hintText: "Enter your delivery address",
                          lines: 3,
                        ),

                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.location_pin,
                                color: ColorConstants.themeColor),
                            SizedBox(width: 5),
                            CustomText(
                              text: 'Use current location',
                              weight: FontWeight.w500,
                              color: ColorConstants.themeColor,
                            )
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Send OTP Button
                        CommonButton(
                          onPressed: () {Get.to(BottomNavigation(index: 0,));},
                          title: "Continue",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Terms Text
                  const Center(
                    child: CustomText(
                      text:
                          "By continuing, you agree to our Terms & Privacy Policy",
                      fontSize: 14,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
