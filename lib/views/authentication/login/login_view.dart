import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/authentication/authentication_controller.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:aqua_flow/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/png/app_logo.png',width: 30,),
                  ),

                  
          
                  const SizedBox(height: 10),
          
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
                            text: "Welcome Back",
                            fontSize: 20,
                            weight: FontWeight.w500,
                            letterSpacing: -1,
                                                   ),
                         ),
                        const SizedBox(height: 8),
                         Center(
                           child: CustomText(
                            text: "Enter your phone number to continue",
                            fontSize: 13,
                            color: Color(0xff6A7282),
                            weight: FontWeight.w500,
                            textAlign: TextAlign.center,
                                                   ),
                         ),
                        const SizedBox(height: 20),
                        Form(
                          key: controller.userNameformKey,
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hintText: "+1 (555) 000-0000",
                            controller: controller.numberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your number';
                              }
                              return null;
                            },
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Icon(Icons.phone_outlined, color: ColorConstants.greyColor,size: 20),
                          ),
                          ),
                        ),
                      
                        const SizedBox(height: 25),
                        
                        /// Send OTP Button
                        Obx(()=>
                          CommonButton(
                            isLoading: controller.isLoading.value,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              controller.login(context);
                            },
                            title: "Send OTP",
                            
                          ),),
          
                        const SizedBox(height: 15),
          
                        /// Info Text
                       Center(
                          child: CustomText(
                            fontSize: 13,
                            text: "We'll send you a one-time password",
                            color: ColorConstants.darkGreyColor,
                          ),
                        ),
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
