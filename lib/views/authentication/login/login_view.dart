import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/authentication/otp/otp_view.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:aqua_flow/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[ SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenConstants.horizontalPadding),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Welcome Back",
                          fontSize: 22,
                          weight: FontWeight.w500,
                          letterSpacing: -1,
                        ),
                        const SizedBox(height: 8),
                        const CustomText(
                          text: "Enter your phone number to continue",
                          fontSize: 15,
                          color: Color(0xff6A7282),
                          weight: FontWeight.w500,
                        ),
                        const SizedBox(height: 20),
          
                        /// Phone TextField
                        CustomTextField(
                          hintText: "+1 (555) 000-0000",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.phone_outlined, color: ColorConstants.greyColor,),
                          ),
                        ),
          
                        const SizedBox(height: 25),
          
                        /// Send OTP Button
                        CommonButton(
                          onPressed: () {Get.to(OtpView());},
                          title: "Send OTP",
                          
                        ),
          
                        const SizedBox(height: 15),
          
                        /// Info Text
                        const Center(
                          child: CustomText(
                            fontSize: 13,
                            text: "We'll send you a one-time password",
                            color: Color(0xff6A7282),
                          ),
                        ),
                      ],
                    ),
                  ),
          
                  const SizedBox(height: 25),
          
                  /// Terms Text
                  const Center(
                    child: CustomText(
                      text: "By continuing, you agree to our Terms & Privacy Policy",
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
          ]
        ),
      ),
    );
  }
}
