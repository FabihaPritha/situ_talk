import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/utils/constants/image_path.dart';
import 'package:situ_talk/features/splash_screen/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Get.put(SplashController());
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          //
          // child: Image.asset(ImagePath.splashLogo),
          child: Image(image: AssetImage(ImagePath.splashImage)),
        ),
      ),
    );
  }
}
