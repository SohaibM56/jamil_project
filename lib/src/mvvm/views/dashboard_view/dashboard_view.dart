import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/padding_extensions.dart';

import 'package:jamil_project/src/mvvm/views/dashboard_views/account_view/account_view.dart';
import 'package:jamil_project/src/mvvm/views/dashboard_views/links_view/links_view.dart';
import 'package:jamil_project/src/mvvm/views/dashboard_views/qr_view/qr_view.dart';
import 'package:jamil_project/src/mvvm/views/dashboard_views/settings_view/settings_view.dart';
import 'package:jamil_project/src/mvvm/viewModels/dashboard_controller/dashboard_controller.dart';
import 'package:jamil_project/src/widgets/dashboard_bottom_nav.dart';

import '../../../config/app_assets.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  static const _screens = [
    QRView(),
    AccountView(),
    LinksView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.homeBg,
                alignment: Alignment.topCenter,
                width: Get.width,
              ).paddingTop(50.h),
            ),
            _screens[controller.currentIndex.value],
          ],
        ),
        bottomNavigationBar: DashboardBottomNav(
          currentIndex: controller.currentIndex.value,
          onTap: controller.selectTab,
        ),
      ),
    );
  }
}
