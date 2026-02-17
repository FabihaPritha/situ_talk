import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  void changePage(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}