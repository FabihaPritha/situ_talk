import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/utils/constants/colors.dart';
import '../controller/nav_controller.dart';

class MainNavScreen extends StatelessWidget {
  final controller = Get.put(NavController());

  final List<Widget> screens = [
    const Center(
      child: Text("Home", style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text("History", style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text("Profile", style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text("Settings", style: TextStyle(color: Colors.white)),
    ),
  ];

  MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF001F3F,
      ), // Dark background to show the glass effect
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) => controller.selectedIndex.value = index,
            physics: const NeverScrollableScrollPhysics(),
            children: screens,
          ),

          // The Floating Bar
          Positioned(
            bottom: 30.h,
            left: 15.w,
            right: 15.w,
            child: _buildGooeyNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildGooeyNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1), // Translucent border/bg
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(0, Icons.home_filled, "Home"),
            _navItem(1, Icons.translate_rounded, "Practice"),
            _navItem(2, Icons.bar_chart_rounded, "Progress"),
            _navItem(3, Icons.account_circle_outlined, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20.w : 15.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          // Only the selected item gets the white solid background
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.white,
              size: 24.sp,
            ),
            // The label only renders and animates in if selected
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
