import 'package:get/get.dart';
import 'package:situ_talk/features/authentication/screen/auth_screen.dart';
import 'package:situ_talk/features/home/screen/home_screen.dart';
import 'package:situ_talk/features/navbar/screen/main_nav_screen.dart';
import 'package:situ_talk/features/onboarding/screen/onboarding_screen.dart';
import 'package:situ_talk/features/progress/screen/progress_screen.dart';
import 'package:situ_talk/features/splash_screen/screen/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String authScreen = "/authScreen";
  static String mainNavScreen = "/mainNavScreen";
  static String homeScreen = "/homeScreen";
  static String progressScreen = "/progressScreen";

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getAuthScreen() => authScreen;
  static String getMainNavScreen() => mainNavScreen;
  static String getHomeScreen() => homeScreen;
  static String getProgressScreen() => progressScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: authScreen, page: () => AuthScreen()),
    GetPage(name: mainNavScreen, page: () => MainNavScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: progressScreen, page: () => ProgressScreen()),
  ];
}
