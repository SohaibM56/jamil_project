import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_assets.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

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
