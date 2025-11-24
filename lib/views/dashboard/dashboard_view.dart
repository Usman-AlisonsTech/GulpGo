import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                        ColorConstants.gradientColor1,
                        ColorConstants.gradientColor2
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Good Morning',
                                    color: Colors.white,
                                    fontSize: 15,
                                    weight: FontWeight.w400,
                                  ),
                                    CustomText(
                            text: 'Muhammad Usman',
                            color: Colors.white,
                            fontSize: 20,
                            weight: FontWeight.w600,
                          ),
                                ],
                              ),
                              Spacer(),
                               Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                                     gradient: LinearGradient(
      colors: [ColorConstants.lightGrey.withOpacity(0.2),ColorConstants.darkGreyColor.withOpacity(0.2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
                           ),
                                child: Center(
                                  child: CustomText(
                                    text: '👋',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5)
                            ],
                          ),
                        
                       SizedBox(height: 20),
                         Container(
  padding: const EdgeInsets.symmetric(horizontal:  20, vertical: 15),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [ColorConstants.lightGrey.withOpacity(0.2),ColorConstants.darkGreyColor.withOpacity(0.2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    // color: ColorConstants.lightGrey.withOpacity(0.),
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
          valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.themeColor),
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
                bottom: -95,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      infoContainer('Request Water','Order bottles now ',Icons.shopping_cart_outlined, ontap: ()=> Get.offAll(BottomNavigation(index: 1))),
                      SizedBox(width: 15),
                      infoContainer('Call Support','Call your driver       ',Icons.call_outlined, isCallSupport: true),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 100),
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
                  color: Colors.white,
                  boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 3),
            blurRadius: 2,
            spreadRadius: 0.2,
          ),
        ],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                   Row(
            children: [
              CustomText(
                text: 'Order #1234',
                fontSize: 16,
                weight: FontWeight.w500,
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomText(
                  text: 'In Progress',
                  fontSize: 11,
                  color: const Color(0xFFB45309),
                  weight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              CustomText(
                text: 'Pkr 24.00',
                fontSize: 18,
                weight: FontWeight.w500,
              ),
            ],
          ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                     
                  //     Row(
                  //       children: [
                  //         CustomText(
                  //           text: 'Order #1234',
                  //           fontSize: 16,
                  //           weight: FontWeight.w500
                  //         ),
                  //         const SizedBox(width: 12),
                  //         Container(
                  //           padding: const EdgeInsets.symmetric(
                  //             horizontal: 12,
                  //             vertical: 3,
                  //           ),
                  //           decoration: BoxDecoration(
                  //             color: const Color(0xFFFEF3C7),
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //           child: CustomText(
                  //             text: 'In Progress',
                  //             fontSize: 12,
                  //             weight: FontWeight.w500,
                  //             color: const Color(0xFFB45309),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     CustomText(
                  //       text: 'Pkr 24.00',
                  //       fontSize: 16,
                  //       weight: FontWeight.w500,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 4),
                  
                  // Order Details
              CustomText(
                text: '2x 20L Bottles',
                fontSize: 13,
                color: ColorConstants.darkGreyColor,
                weight: FontWeight.w500,
              ),
                  // CustomText(
                  //   text: '2x 20L Bottles',
                  //   fontSize: 14,
                  //   color:ColorConstants.darkGreyColor,
                  // ),
                  const SizedBox(height: 25),
                  
                  // Schedule Section
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color :ColorConstants.darkGreyColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomText(
                          text: 'Scheduled: Today, 2:00 PM - 4:00 PM',
                          fontSize: 13,
                          color: ColorConstants.darkGreyColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  
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
              GestureDetector(
                onTap: ()=> Get.offAll(BottomNavigation(index: 2)),
                child: Container(
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
                                   text: "Pkr 48.50",
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
                      text: "Pkr 36.00",
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
                        onPressed: () {Get.offAll(BottomNavigation(index: 2));},
                        verticalPadding: 8,
                        bgColor: Colors.white,
                        textColor: ColorConstants.themeColor,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              ],
              ),),
            ),
          ),
        ],
      ),
    );
  }

 Widget infoContainer(
  String title,
  String subtitle,
  IconData icon, {
  bool isIcon = false,
  void Function()? ontap,
  bool isCallSupport = false,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: isCallSupport
          ? () {
              Get.dialog(
                Center(
                  child: Material( // IMPORTANT: fixes TextField error
                    color: Colors.transparent,
                    child: Container(
                      width: 300,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Call Support',
                            fontSize: 22,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(height: 10),

                          CustomText(
                            text: 'Do you want to call your driver?',
                            fontSize: 15,
                            color: Color(0xff6C6D6E),
                            weight: FontWeight.w500,
                          ),

                          SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // CANCEL
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                  width: 110,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: ColorConstants.themeColor,
                                    ),
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

                              // CALL
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  // your call logic here
                                  // launchUrl(...) etc
                                },
                                child: Container(
                                  width: 110,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.themeColor,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: ColorConstants.themeColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: 'Call',
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
            }
          : ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0, 3),
              blurRadius: 2,
              spreadRadius: 0.2,
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(3, 0),
              blurRadius: 2,
              spreadRadius: 0.2,
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(-3, 0),
              blurRadius: 2,
              spreadRadius: 0.2,
            ),
          ],
        ),
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            iconContainer(icon),

            SizedBox(height: isIcon ? 20 : 10),

            CustomText(
              text: title,
              fontSize: 15,
              weight: FontWeight.w500,
            ),

            SizedBox(height: isIcon ? 15 : 3),

            CustomText(
              text: subtitle,
              fontSize: 13,
              color: ColorConstants.darkGreyColor,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget iconContainer(IconData icon, {Color? iconColor, Color? backgroundColor}) {
    return Container(
      width: 45,
      height: 45,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: backgroundColor?? ColorConstants.themeColor.withOpacity(0.1)),
      child: Icon(icon, color: iconColor?? ColorConstants.themeColor, size: 20)
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
