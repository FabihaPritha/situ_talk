import 'package:get/get.dart';
import 'package:situ_talk/routes.dart/app_routes.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  void loginWithGoogle() async {
    isLoading.value = true;
    await Future.delayed(0.seconds); // Simulating network call
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.getOnboardingScreen());
  }

  void loginWithApple() async {
    isLoading.value = true;
    await Future.delayed(0.seconds);
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.getOnboardingScreen());
  }

  void loginWithFacebook() async {
    isLoading.value = true;
    await Future.delayed(0.seconds);
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.getOnboardingScreen());
  }
}
