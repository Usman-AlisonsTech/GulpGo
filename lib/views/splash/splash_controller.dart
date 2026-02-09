import 'package:aqua_flow/views/authentication/login/login_view.dart';
import 'package:aqua_flow/views/bottombar/bottom_navigation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getString('token') != null;

    navigateBasedOnState();
  }

  void navigateBasedOnState() {
    if (isLoggedIn.value) {
      Get.offAll(BottomNavigation()); 
    }else {
      Get.offAll(LoginView()); 
    }
  }
}