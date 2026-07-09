import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jamil_project/src/config/app_assets.dart';
import 'package:jamil_project/src/mvvm/viewModels/splash_controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final imageCacheHeight =
        (MediaQuery.sizeOf(context).height *
                MediaQuery.devicePixelRatioOf(context))
            .ceil();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: Image.asset(
          AppAssets.splashGif,
          fit: BoxFit.cover,
          cacheHeight: imageCacheHeight,
        ),
      ),
    );
  }
}
