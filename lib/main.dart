import 'package:aqua_flow/views/authentication/authentication_controller.dart';
import 'package:aqua_flow/views/authentication/login/login_view.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
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
      home: LoginView(),
      title: 'Aqua Flow',
    );
  }
}

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController(), permanent: true);
    Get.put(BottomNavbarController(), permanent: true);
  }
}