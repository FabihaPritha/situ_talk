import 'package:get/get.dart';
import 'package:situ_talk/features/authentication/screen/auth_screen.dart';
import 'package:situ_talk/features/onboarding/screen/onboarding_screen.dart';
import 'package:situ_talk/features/splash_screen/screen/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String authScreen = "/authScreen";

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getAuthScreen() => authScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: authScreen, page: () => AuthScreen()),
  ];
}
