import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../account/presentation/account_screen.dart';
import '../../links/presentation/links_screen.dart';
import '../../qr/presentation/qr_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import 'dashboard_controller.dart';
import 'widgets/dashboard_bottom_nav.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  static const _screens = [
    QRScreen(),
    AccountScreen(),
    LinksScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _screens[controller.currentIndex.value],
        bottomNavigationBar: DashboardBottomNav(
          currentIndex: controller.currentIndex.value,
          onTap: controller.selectTab,
        ),
      ),
    );
  }
}
