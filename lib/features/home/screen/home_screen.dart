import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/common/styles/global_text_style.dart';
import 'package:situ_talk/core/utils/constants/colors.dart';
import 'package:situ_talk/features/home/controller/home_controller.dart';
import 'package:situ_talk/features/home/widget/home_appbar_delegate.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // Collapsible Aesthetic App Bar
          Obx(
            () => SliverPersistentHeader(
              pinned: true,
              delegate: HomeAppBarDelegate(
                expandedHeight: 130.h,
                userName: controller.userName.value,
                notificationCount: controller.notificationCount.value,
                onSettings: controller.openSettings,
                onNotifications: controller.openNotifications,
              ),
            ),
          ),

          // Body Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                children: [
                  // Stats Row
                  Row(
                    children: [
                      _buildMiniStat(
                        "🔥",
                        "${controller.streakCount} days Streak",

                        const Color(0xFFFFEDE0),
                        Colors.orange.shade900,
                      ),
                      SizedBox(width: 12.w),
                      _buildMiniStat(
                        "⭐",
                        "${controller.totalPoints} Points Earned",
                        const Color(0xFFE0F2FE),
                        Colors.blue.shade900,
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),
                  _buildQuoteSection(),

                  SizedBox(height: 30.h),
                  _buildSectionHeader("Continue Practice"),
                  _buildPracticeCard(),

                  SizedBox(height: 30.h),
                  _buildSectionHeader("Your Growth"),
                  _buildGrowthGrid(),

                  SizedBox(height: 120.h), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Build Methods ---

  Widget _buildMiniStat(String text1, String text2, Color bg, Color textCol) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16.r),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              text1,
              style: getTextStyle(
                color: textCol,
                fontWeight: FontWeight.w700,
                fontSize: 30.sp,
                lineHeight: 28.sp,
              ),
            ),
            Text(
              text2,
              style: getTextStyle(
                color: textCol,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ),
          Text(
            "See All",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        // color: Colors.white,
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.01), Colors.white],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote,
            color: AppColors.primary.withOpacity(0.5),
            size: 30,
          ),
          Text(
            "\"The beautiful thing about learning is that no one can take it away from you.\"",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.blueGrey.shade600,
              fontStyle: FontStyle.italic,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.restaurant_menu_rounded,
              color: AppColors.primary,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Restaurant English",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                Text(
                  "Intermediate • 15 mins left",
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.sp,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      padding: EdgeInsets.zero,
      children: [
        _buildSmallCard(
          "75%",
          "Course",
          Icons.menu_book_rounded,
          Colors.indigo,
        ),
        _buildSmallCard(
          "Level 5",
          "Fluency",
          Icons.trending_up_rounded,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildSmallCard(String val, String label, IconData icon, Color col) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        // color: Colors.white,
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 178, 202, 223).withOpacity(0.001),
            Colors.white,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: col, size: 30.sp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                val,
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              Text(
                label,
                style: getTextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  // letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
