import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PersonalInformationView extends StatelessWidget {
  const PersonalInformationView({super.key});

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
                              text: 'Personal Information',
                              fontSize: 18,
                weight: FontWeight.w500,
                            ),
                             const CustomText(
                    text: 'Manage your personal details',
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
                     CustomText(
      text: "Name",
      fontSize: 14,
      weight: FontWeight.w500,
      color: ColorConstants.darkGreyColor,
    ),
    const SizedBox(height: 6),

    Container(
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: CustomText(
        text: "Muhammad Usman",
        fontSize: 15,
      ),
    ),

    const SizedBox(height: 20),

    /// PHONE NUMBER
    CustomText(
      text: "Phone Number",
      fontSize: 14,
      weight: FontWeight.w500,
      color: ColorConstants.darkGreyColor,
    ),
    const SizedBox(height: 6),

    Container(
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: CustomText(
        text: "+92 300 1234567",
        fontSize: 15,
      ),
    ),

    const SizedBox(height: 20),

    /// DELIVERY ADDRESS
    CustomText(
      text: "Delivery Address",
      fontSize: 14,
      weight: FontWeight.w500,
      color: ColorConstants.darkGreyColor,
    ),
    const SizedBox(height: 6),

    Container(
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color:  ColorConstants.lightGrey),
      ),
      child: CustomText(
        text: "House #12, Street 5, Lahore, Pakistan",
        fontSize: 15,
      ),
    ),


            ],
          ),
        ),
      ),
    );
  }
}