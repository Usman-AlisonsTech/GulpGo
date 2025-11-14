import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.themeColor,
                        Color(0xff4BBFF8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                text: 'Good Morning',
                                color: Colors.white,
                                fontSize: 18,
                                weight: FontWeight.w400,
                              ),
                              Spacer(),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff6CC9F9)),
                                child: Center(
                                  child: CustomText(
                                    text: '👋',
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          CustomText(
                            text: 'Muhammad Usman',
                            color: Colors.white,
                            fontSize: 20,
                            weight: FontWeight.w600,
                          ),
                       SizedBox(height: 10),
                         Container(
  padding: const EdgeInsets.symmetric(horizontal:  20, vertical: 15),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF40C4FF), Color(0xFF0099CC)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withOpacity(0.3)),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          const CustomText(
            text: "Water Level",
            fontSize: 14,
            color: Colors.white,
            weight: FontWeight.w500,
          ),
          const Spacer(),

          const CustomText(
            text: "25% remaining",
            fontSize: 14,
            color: Colors.white,
            weight: FontWeight.w500,
          ),
        ],
      ),

      const SizedBox(height: 15),

      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(
          value: 0.25, // 25%
          backgroundColor: Colors.white.withOpacity(0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
          minHeight: 8,
        ),
      ),

      const SizedBox(height: 15),

      const CustomText(
        text: "Next delivery: Tomorrow, 2:00 PM",
        fontSize: 14,
        color: Colors.white,
        weight: FontWeight.w500,
      ),
    ],
  ),
)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -90,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      infoContainer('Request Water','Order bottles now',Icons.shopping_cart),
                      SizedBox(width: 10),
                      infoContainer('Track Delivery','Live GPS Tracking',Icons.location_pin),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 120),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(padding: EdgeInsets.symmetric(horizontal: ScreenConstants.horizontalPadding, vertical: ScreenConstants.verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 CustomText(text: 'Active Orders', weight: FontWeight.w500,),
                 CustomText(text: 'View All', color: ColorConstants.themeColor,weight: FontWeight.w500,),
                ],
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border(
                  left: BorderSide(color: ColorConstants.themeColor, width: 4),
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: 'Order #1234',
                            fontSize: 16,
                            weight: FontWeight.w500
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomText(
                              text: 'In Progress',
                              fontSize: 12,
                              weight: FontWeight.w500,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        text: '\$24.00',
                        fontSize: 16,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  
                  // Order Details
                  CustomText(
                    text: '2x 20L Bottles',
                    fontSize: 14,
                    color:ColorConstants.darkGreyColor,
                  ),
                  const SizedBox(height: 20),
                  
                  // Schedule Section
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color :ColorConstants.darkGreyColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomText(
                          text: 'Scheduled: Today, 2:00 PM - 4:00 PM',
                          fontSize: 14,
                          color: ColorConstants.darkGreyColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Track Button
                  CommonButton(
                    title: 'Track on Map',
                    icon: Icon(Icons.location_pin, color: Colors.white,size: 18,),
                    verticalPadding: 8,
                  ),
                ],
              ),
              ),
              SizedBox(height: 20),
              CustomText(text: 'Billing Summary', weight: FontWeight.w500),
              SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffEDFCFF)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Balance
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Current Balance",
                              fontSize: 14,
                            color:ColorConstants.darkGreyColor,
                            ),
                            SizedBox(height: 4),
                             CustomText(
                                 text: "\$48.50",
                                    fontSize: 25,
                                    weight: FontWeight.w500,
                                  ),
                          ],
                        ),
                        Spacer(),
                        iconContainer(Icons.trending_down,backgroundColor: Colors.white, iconColor: Colors.green),
                      ],
                    ),
                    const SizedBox(height: 20),
              
                    // Last Payment and Due Date Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
              // Last Payment
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Last Payment",
                    fontSize: 12,
                    weight: FontWeight.w500,
                    color:ColorConstants.darkGreyColor,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: "\$36.00",
                    fontSize: 16,
                    weight: FontWeight.w500,
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    text: "Oct 28, 2025",
                    fontSize: 12,
                    color:ColorConstants.darkGreyColor,
                  ),
                ],
              ),
              
              // Due Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: "Due Date",
                    fontSize: 12,
                    weight: FontWeight.w500,
                    color:ColorConstants.darkGreyColor,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: "Nov 15, 2025",
                    fontSize: 16,
                    weight: FontWeight.w500,
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    text: "11 days left",
                   fontSize: 12,
                    color:ColorConstants.darkGreyColor,
                  ),
                ],
              ),
                      ],
                    ),
              
                    const SizedBox(height: 30),
              
                    // Pay Now button
                    CommonButton(
                      title: "Pay Now",
                      onPressed: () {},
                      verticalPadding: 8,
                      bgColor: Colors.white,
                      textColor: ColorConstants.themeColor,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              CustomText(text: 'Need Help?', weight: FontWeight.w500),
              SizedBox(height: 15),
              
              infoContainer('Call Support', 'Available 24/7', Icons.call, isIcon: true),
                ],
              ),),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoContainer(String title , String subtitle, IconData icon, {bool isIcon = false}){
    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(0, 3),
                            blurRadius: 2,
                            spreadRadius: 0.2,
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(3, 0),
                            blurRadius: 2,
                            spreadRadius: 0.2,
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(-3, 0),
                            blurRadius: 2,
                            spreadRadius: 0.2,
                          ),
                        ],
                      ),
                      padding:
                          EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         isIcon? Icon(Icons.phone, color: ColorConstants.themeColor,size: 25,) : iconContainer(icon),
                          SizedBox(height: isIcon? 20: 10),
                          CustomText(text: title, fontSize: 15, weight: FontWeight.w500,),
                          SizedBox(height:isIcon? 15: 3),
                          CustomText(text: subtitle, fontSize: 13, color: ColorConstants.darkGreyColor,weight: FontWeight.w500),
                        ],
                      ),
                    );
  }

  Widget iconContainer(IconData icon, {Color? iconColor, Color? backgroundColor}) {
    return Container(
      width: 40,
      height: 40,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: backgroundColor?? ColorConstants.themeColor),
      child: Center(
        child: Icon(icon, color: iconColor?? Colors.white,)
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 30);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 30,
      size.width,
      size.height - 30,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
