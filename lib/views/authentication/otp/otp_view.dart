import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/authentication/address/user_address_view.dart';
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

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D7FE8), Color(0xFF52B6FF)],
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
                          text: "Verify Otp",
                          fontSize: 22,
                          weight: FontWeight.w500,
                          letterSpacing: -1,
                        ),
                        const SizedBox(height: 8),
                        const CustomText(
                          text: "Enter your code sent to \n0310129301",
                          fontSize: 15,
                          color: Color(0xff6A7282),
                          weight: FontWeight.w500,
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
                    // controller.otp = value;
                    // controller.isOtpValid.value = value.length == 6;
                  });
                },
                onCompleted: (pin) {
                  setState(() {
                //     controller.otp = pin;
                //     controller.isOtpValid.value = pin.length == 6;
                //      if (!controller.isVerifyLoading.value) {
                //     controller.verifyOtp(context);
                //  }
                  });
                },
              )
              ),
          
          
                        const SizedBox(height: 25),
          
                        /// Send OTP Button
                        CommonButton(
                          onPressed: () {Get.to(UserAddressView());},
                          title: "Verify OTP",
                          
                        ),
          
                        const SizedBox(height: 15),
          
                        /// Info Text
                         Center(
                          child: CustomText(
                            fontSize: 13,
                            weight: FontWeight.w500,
                            text: "Resent OTP",
                            color: ColorConstants.themeColor,
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
