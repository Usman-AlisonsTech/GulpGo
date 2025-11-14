import 'package:aqua_flow/views/alerts/alerts_view.dart';
import 'package:aqua_flow/views/bills/bills_view.dart';
import 'package:aqua_flow/views/dashboard/dashboard_view.dart';
import 'package:aqua_flow/views/order/order_view.dart';
import 'package:aqua_flow/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  static BottomNavbarController get to => Get.find<BottomNavbarController>();
  var currentIndex = 0.obs;
  var isMenuOpen = false.obs;
  var isAnimating = false.obs;
  RxBool isLoading = false.obs;

  final List<NavScreen> listOfScreens = [
    NavScreen(index: 0, widget: DashboardView(), icon: Icons.home_outlined, width: 25,height: 16),
    NavScreen(index: 1, widget: OrderView(),icon: Icons.shopping_cart_outlined, width: 25,height: 18),
    NavScreen(index: 2, widget:BillsView(),icon: Icons.credit_card_outlined, width: 25,height: 18),
    NavScreen(index: 3, widget:AlertsView(),icon: Icons.notifications_none, width: 25,height: 18),
    NavScreen(index: 4, widget:ProfileView(),icon: Icons.person_outline, width: 25,height: 18),
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
    update(['main']);
  }

}


class NavScreen {
  final int index;
  final Widget widget;
  final IconData icon;
  final double width;
  final double height;

  NavScreen({required this.index, required this.widget, required this.icon, required this.width, required this.height});
}