import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/common/styles/global_text_style.dart';
import 'package:situ_talk/core/utils/constants/colors.dart';
import 'package:situ_talk/features/home/screen/home_screen.dart';
import 'package:situ_talk/features/progress/screen/progress_screen.dart';
import '../controller/nav_controller.dart';

class MainNavScreen extends StatelessWidget {
  final controller = Get.put(NavController());

  final List<Widget> screens = [
    Center(child: HomeScreen()),
    Center(child: Text("Profile")),
    Center(child: ProgressScreen()),
    const Center(child: Text("Profile")),
  ];

  MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Keep your app background as needed
      backgroundColor: const Color(0xFFF5F7F9),
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) => controller.selectedIndex.value = index,
            physics: const NeverScrollableScrollPhysics(),
            children: screens,
          ),

          // The Floating White Elevated Bar
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: _buildElevatedNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white, // Solid white background
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 10), // Elevation effect
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(0, Icons.home_filled, "Home"),
            _navItem(1, Icons.playlist_play_rounded, "Practice"),
            // _navItem(1, Icons.spatial_audio_rounded, "Practice"),
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
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.w : 12.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          // In the image, the selected item has a light blue or subtle grey tint
          // to distinguish it from the white bar, or stays white if preferred.
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.cardBackgroundColor,
              size: 24.sp,
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: getTextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
