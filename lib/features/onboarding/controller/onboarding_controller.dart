import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/utils/constants/image_path.dart';
import 'package:situ_talk/features/onboarding/model/onboarding_model.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs;

  List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: "Master English Through ",
      highlightText: "Real Situations",
      description:
          "Don't just listen—speak. SituTalk helps you bridge the gap between understanding and communicating fluently.",
      imagePath: ImagePath.onboarding1,
    ),
    OnboardingModel(
      title: "Watch, Record, Speak Up",
      description:
          "Watch a short real-life scenario, then record yourself describing it in English. It's safe, private, and effective practice.",
      imagePath: ImagePath.onboarding2,
    ),
  ];

  bool get isLastPage => currentPage.value == onboardingPages.length - 1;

  void nextPage() {
    if (isLastPage) {
      // Navigate to Home or Login
      Get.offNamed('/home');
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }
}
