import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/authentication/authentication_controller.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     final controller = Get.find<AuthenticationController>();

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
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/png/app_logo.png',width: 50,),
                  ),
          
                  const SizedBox(height: 10),
          
                  /// App Title
                  const CustomText(
                    text: "GulpGo",
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
          
                  const SizedBox(height: 25),
          
                  /// White Card Container
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Center(
                           child: CustomText(
                            text: "Verify Otp",
                            fontSize: 20,
                            weight: FontWeight.w500,
                            letterSpacing: -1,
                                                   ),
                         ),
                        const SizedBox(height: 8),
                         Center(
                           child: CustomText(
                            text: "Enter your code sent to ${controller.numberController.text}",
                            fontSize: 13,
                            color: Color(0xff6A7282),
                            weight: FontWeight.w500,
                                                   ),
                         ),
                        const SizedBox(height: 20),

          Center(
                child:
                Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 55,
                  height: 50,
                  textStyle: const TextStyle(
                    fontSize: 27,
                    color: Color(0xff424243),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    border: Border.all(color: Color(0xffDEDEDE), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                focusedPinTheme: PinTheme(
                  width: 55,
                  height: 50,
                  textStyle: const TextStyle(
                    fontSize: 27,
                    color: Color(0xff424243),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    border: Border.all(color: Color(0xffDEDEDE), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                submittedPinTheme: PinTheme(
                  width: 55,
                  height: 50,
                  textStyle: const TextStyle(
                    fontSize: 27,
                    color: Color(0xff424243),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    border: Border.all(color: ColorConstants.themeColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    controller.otp = value;
                    controller.isOtpValid.value = value.length == 6;
                  });
                },
                onCompleted: (pin) {
                  setState(() {
                    controller.otp = pin;
                    controller.isOtpValid.value = pin.length == 6;
                     if (!controller.isVerifyLoading.value) {
                    controller.verifyOtp(context);
                 }
                  });
                },
              )
              ),
          
          
                        const SizedBox(height: 25),
          
                        /// Send OTP Button
            
                        const SizedBox(height: 15),
          
                       Obx(
              () =>  CommonButton(
                  title: "Verify OTP",
                  isLoading: controller.isVerifyLoading.value,
                  bgColor: controller.isOtpValid.value
                      ? ColorConstants.buttoncolor
                      : Color(0xff8692B4),
                  borderColor: controller.isOtpValid.value
                      ? ColorConstants.buttoncolor
                      : Color(0xff8692B4),
                  fontSize: 14,
                  textWeight: FontWeight.w500,
                  buttonShade: const Color(0xffFFFFFF),
                  borderRadius: 10,
                  onPressed: controller.isOtpValid.value
                      ? () {
                          controller.verifyOtp(context);
                        }
                      : null,
                ),
              ),
          
             const SizedBox(height: 15),
            Obx(() {
              return Center(
                child: GestureDetector(
                  onTap: controller.canResend.value
                      ? () {
                          controller.startResendTimer();
                          controller.resendOTP(context);
                        }
                      : null,
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(
                         fontSize: 13,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xff1E3064),
                        decorationThickness: 1.5,
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        TextSpan(
                          text: 'Resend OTP ',
                          style: TextStyle(
                           color: ColorConstants.themeColor,
                          ),
                        ),
                        if (!controller.canResend.value)
                          TextSpan(
                            text:
                                '(00:${controller.remainingSeconds.value.toString().padLeft(2, '0')})',
                            style: TextStyle(
                               color: ColorConstants.themeColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
                      ],
                    ),
                  ),
          
                  const SizedBox(height: 25),
          
                  /// Terms Text
                  const Center(
                    child: CustomText(
                      text: "By continuing, you agree to our Terms & \nPrivacy Policy",
                      fontSize: 12,
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
