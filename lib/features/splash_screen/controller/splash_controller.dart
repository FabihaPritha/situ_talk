import 'package:get/get.dart';
import 'package:situ_talk/routes.dart/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // Add navigation logic here, e.g., Get.offNamed(Routes.HOME);
    Get.offAllNamed(AppRoutes.getAuthScreen());
  }
}
