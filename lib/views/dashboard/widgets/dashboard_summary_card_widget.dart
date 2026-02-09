import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/utils/helper_methods.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget dashboardSummaryCard(
    {required String title,
    required String value,
    required Color color,
    bool isStatCard = false,
    void Function()? ontap,
    String? phoneNumber,
    bool isCallSupport = false}) {
  return GestureDetector(
    onTap: isCallSupport
        ? () {
            Get.dialog(
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
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
                                print(phoneNumber);
                                HelperMethods()
                                    .makePhoneCall(phoneNumber ?? '');
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
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        gradient: isStatCard
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha:0.25),
                  Colors.white.withValues(alpha:0.08),
                ],
              )
            : null,
        color: isStatCard ? null : Colors.white.withValues(alpha:0.2),
        borderRadius: BorderRadius.circular(16),
        border: isStatCard
            ? Border.all(
                color: color.withValues(alpha:0.4),
                width: 1.2,
              )
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // small top indicator
          if (isStatCard)
            Container(
              height: 4,
              width: 28,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          if (isStatCard) const SizedBox(height: 8),

          CustomText(
            text: title,
            fontSize: 11,
            color: Colors.white70,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          CustomText(
            text: value,
            fontSize: 20,
            weight: FontWeight.w700,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}


 Widget summaryCardShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.white.withValues(alpha:0.15),
    highlightColor: Colors.white.withValues(alpha:0.35),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha:0.3),
          width: 1.2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 28,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 10,
            width: 70,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Container(
            height: 18,
            width: 50,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}