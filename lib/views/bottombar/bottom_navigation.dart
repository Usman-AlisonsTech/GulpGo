import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation_controller.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  final int? index;
  BottomNavigation({super.key, this.index});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final BottomNavbarController controller = Get.find<BottomNavbarController>();

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.index != null) {
      controller.changeIndex(widget.index!);
    }
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final bool isLargeScreen = screenHeight > 750;
    return GetBuilder<BottomNavbarController>(
      id: 'main',
      builder: (c) => PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (c.currentIndex.value == 0) {
            Get.dialog(
              Center(
                child: Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(width: 10),
                           CustomText(
                            text: 'Exit ',
                            fontSize: 24,
                            weight: FontWeight.w600,
                            color: Colors.black,
                                                 ),
                         ],
                       ),
                       SizedBox(height: 10),
                       CustomText(text: 'Are you sure you want to exit?', weight: FontWeight.w500,fontSize: 16,color: Color(0xff6C6D6E)),
                       SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: ()=>Get.back(),
                            child: Container(
                              width: 110,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Center(child: CustomText(text: 'Cancel', color: ColorConstants.themeColor,fontSize: 12,weight: FontWeight.w500)),
                            ),
                          ),
                           GestureDetector(
                            onTap:  SystemNavigator.pop,
                            child: Container(
                              width: 110,
                              height: 28,
                              decoration: BoxDecoration(
                                color: ColorConstants.themeColor,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color:ColorConstants.themeColor)
                              ),
                              child: Center(child: CustomText(text: 'Yes', color: Colors.white,fontSize: 12,weight: FontWeight.w500)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            c.changeIndex(0);
          }
        },
        child: Scaffold(
          body: Obx(() {
            final screen =
                controller.listOfScreens[controller.currentIndex.value].widget;

            return screen;
          }),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
               border: Border(
                top: BorderSide(
                  color: Colors.grey[200]!, 
                  width: 1, 
                ),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 30,
                  spreadRadius: 10,
                  offset: const Offset(0, -20),
                ),
              ],
            ),
            child: BottomAppBar(
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: controller.listOfScreens.asMap().entries.map((entry) {
                  final index = entry.key;
                  final screen = entry.value;
                  return Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => controller.changeIndex(screen.index),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 2),
                          // SvgPicture.asset(
                          //   screen.icon,
                          //   height: screen.height,
                          //   width: screen.width,
                          //   color: Colors.white,
                          // ),
                          Icon(screen.icon,color: controller.currentIndex.value == screen.index? ColorConstants.themeColor : ColorConstants.darkGreyColor, size: screen.width,),
                          const SizedBox(height: 6),
                          controller.currentIndex.value == screen.index
                              ? indicator
                              : const SizedBox(height: 3),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Bottom indicator
  Widget get indicator => Container(
        width: 28,
        height: 3,
        decoration: BoxDecoration(
          color: ColorConstants.themeColor,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
      );
}