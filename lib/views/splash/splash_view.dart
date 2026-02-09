import 'package:aqua_flow/views/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.find<SplashController>();
    Future.delayed(Duration(seconds: 2), (){
      splashController.checkFirstTime();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/png/app_icon.png', width: 170),
              ],
            ),
          ),
        ],
      ),
    );
  }
}