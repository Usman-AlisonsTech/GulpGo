import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/authentication/authentication_controller.dart';
import 'package:aqua_flow/views/profile/profile_controller.dart';
import 'package:aqua_flow/views/profile/widgets/profile_header_widget.dart';
import 'package:aqua_flow/views/profile/widgets/sections_card_widget.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());
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
              // Title
              const CustomText(
                text: 'Profile & Settings',
                fontSize: 18,
                weight: FontWeight.w500,
              ),
              const CustomText(
                text: 'Manage your account',
                fontSize: 13,
                color: Color(0xff4A4A4A),
                weight: FontWeight.w500,
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Divider(color: Color(0xffD1D4D9)),
              ),
              const SizedBox(height: 20),

              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 180),
                          child: CircularProgressIndicator()));
                }
                return Column(
                  children: [
                    // Profile Header
                    buildProfileHeader(),
                    const SizedBox(height: 30),

                    buildSectionCard(
                      title: "Personal Information",
                      children: [
                        buildInfoRow(Icons.person, "Name",
                            controller.customerData['name'] ?? "-"),
                        buildInfoRow(
                            Icons.location_on,
                            "Address",
                            controller.customerData['address'] ??
                                "North Nazimabad Zone"),
                        buildInfoRow(
                            Icons.email,
                            "Email",
                            controller.customerData['email'] ??
                                '' ??
                                "Minhaj First Company"),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: CustomText(
                          text: 'GulpGo v1.0.0',
                          fontSize: 14,
                          color: ColorConstants.darkGreyColor),
                    ),
                    const SizedBox(height: 24),
                    CommonButton(
                      title: 'Logout',
                      textColor: ColorConstants.redColor,
                      bgColor: Colors.white,
                      borderColor: ColorConstants.redColor,
                      icon: Icon(Icons.logout,
                          size: 20, color: ColorConstants.redColor),
                      onPressed: () => AuthenticationController().logout(),
                    ),
                    SizedBox(height: 24),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
