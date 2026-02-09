import 'package:aqua_flow/firebase_options.dart';
import 'package:aqua_flow/services/firebase_messaging_service.dart';
import 'package:aqua_flow/services/local_notification_service.dart';
import 'package:aqua_flow/views/authentication/authentication_controller.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation_controller.dart';
import 'package:aqua_flow/views/dashboard/dashboard_controller.dart';
import 'package:aqua_flow/views/splash/splash_controller.dart';
import 'package:aqua_flow/views/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final localNotificationsService = LocalNotificationsService.instance();
  await localNotificationsService.init();

  final firebaseMessagingService = FirebaseMessagingService.instance();
  await firebaseMessagingService.init(localNotificationsService: localNotificationsService);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashView(),
      title: 'Aqua Flow',
    );
  }
}

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController(), permanent: true);
    Get.put(BottomNavbarController(), permanent: true);
    Get.put(SplashController(), permanent: true);
    Get.put(DashboardController(), permanent: true);
  }
}