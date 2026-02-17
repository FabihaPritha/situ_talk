import 'package:get/get.dart';
import 'package:situ_talk/features/splash_screen/screen/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splashScreen";

  static String getSplashScreen() => splashScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
  ];
}
