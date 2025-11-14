import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/authentication/login/login_view.dart';
import 'package:aqua_flow/views/profile/faqs/faqs_view.dart';
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
  bool pushEnabled = true;
  bool smsEnabled = true;
  bool promoEnabled = false;

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

              // Profile Header
              _buildProfileHeader(),
              const SizedBox(height: 30),

              // ACCOUNT Section
              _buildSectionTitle("ACCOUNT"),
              _buildMenuItem(
                icon: Icons.person_outline,
                iconColor: Colors.blue[300]!,
                title: "Personal Information",
                subtitle: "Update your details",
              ),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                iconColor: Colors.green[400]!,
                title: "Delivery Addresses",
                subtitle: "Manage saved addresses",
              ),

              const SizedBox(height: 24),

              // PREFERENCES Section
              _buildSectionTitle("PREFERENCES"),
              _buildToggleItem(
                icon: Icons.notifications_outlined,
                iconColor: Colors.orange[400]!,
                title: "Push Notifications",
                subtitle: "Delivery updates & offers",
                value: pushEnabled,
                onChanged: (v) => setState(() => pushEnabled = v),
              ),
              const SizedBox(height: 24),

              // SUPPORT Section
              _buildSectionTitle("SUPPORT"),
              _buildMenuItem(
                icon: Icons.help_outline,
                iconColor: Colors.orange[600]!,
                title: "Help Center",
                subtitle: "FAQs and support",
                onpressed: ()=> Get.to(FaqsView()),
              ),
              const SizedBox(height: 24),
              Center(
                child: CustomText(text: 'AquaFlow v1.0.0', fontSize: 14,color: ColorConstants.darkGreyColor),
              ),
              const SizedBox(height: 24),
              CommonButton(title: 'Logout',textColor: ColorConstants.redColor ,bgColor: Colors.white,borderColor: ColorConstants.redColor,icon: Icon(Icons.logout, size: 20,color: ColorConstants.redColor), onPressed: ()=> Get.offAll(LoginView()),),
               SizedBox(height: 24),

            ],
          ),
        ),
      ),
    );
  }

  // Profile Header
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorConstants.themeColor, const Color(0xff4BBFF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: CustomText(
                    text: "JD",
                    fontSize: 18,
                    weight: FontWeight.w500,
                    color: ColorConstants.themeColor,
                  ),
                ),
              ),
               const SizedBox(width: 16),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: "John Doe",
                      fontSize: 18,
                      color: Colors.white,
                      weight: FontWeight.w500,
                    ),
                    CustomText(
                      text: "Customer ID: #CUS-12345",
                      fontSize: 13,
                      color: Colors.white,
                      weight: FontWeight.w500,
                    ),
                ],
               )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: Colors.white70),
                        SizedBox(width: 6),
                        CustomText(
                          text: "+1 (555) 123-4567",
                          fontSize: 13,
                          color: Colors.white,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.email, size: 16, color: Colors.white70),
                        SizedBox(width: 6),
                        CustomText(
                          text: "john.doe@email.com",
                          fontSize: 13,
                          color: Colors.white,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CustomText(
        text: title,
        fontSize: 14,
        color: ColorConstants.darkGreyColor,
      ),
    );
  }

  // Menu Item (with arrow)
  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    void Function()? onpressed,
  }) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorConstants.lightGrey),
        ),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 14,
                  ),
                  CustomText(
                    text: subtitle,
                    fontSize: 12,
                    color: ColorConstants.greyColor,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: ColorConstants.darkGreyColor),
          ],
        ),
      ),
    );
  }

  // Toggle Item
  Widget _buildToggleItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 14,
                ),
                CustomText(
                  text: subtitle,
                  fontSize: 12,
                  color: ColorConstants.greyColor,
                  weight: FontWeight.w400,
                ),
              ],
            ),
          ),
         Transform.scale(
            scale: 0.8, 
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: ColorConstants.themeColor,
            ),
          ),

        ],
      ),
    );
  }
}