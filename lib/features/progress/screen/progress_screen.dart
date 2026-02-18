import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/common/styles/global_text_style.dart';
import 'package:situ_talk/core/common/widgets/custom_app_bar.dart'; // Adjust path as needed
import 'package:situ_talk/core/utils/constants/colors.dart';
import 'package:situ_talk/features/progress/controller/progress_controller.dart';

class ProgressScreen extends StatelessWidget {
  final controller = Get.put(ProgressController());

  ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: "Your Progress",
        showBackButton: false, // Automatically centers title per your logic
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Mastery Overview Card
            _buildMasteryCard(),
            SizedBox(height: 20.h),

            // 2. Level and XP Row
            Row(
              children: [
                _buildInfoCard(
                  "CURRENT LEVEL",
                  "Level ${controller.currentLevel}",
                  Icons.emoji_events_outlined,
                  Colors.orange,
                ),
                SizedBox(width: 12.w),
                _buildXPProgressCard(),
              ],
            ),
            SizedBox(height: 30.h),

            // 3. Situations Breakdown Grid
            _buildSectionHeader("SITUATIONS BREAKDOWN"),
            SizedBox(height: 16.h),
            _buildBreakdownGrid(),
            SizedBox(height: 30.h),

            // 4. Recent Activity List
            _buildSectionHeader("RECENT ACTIVITY"),
            SizedBox(height: 16.h),
            _buildActivityList(),

            SizedBox(height: 100.h), // Space for Nav Bar
          ],
        ),
      ),
    );
  }

  Widget _buildMasteryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 120.r,
                width: 120.r,
                child: CircularProgressIndicator(
                  value: controller.masteryPercentage.value / 100,
                  strokeWidth: 20,
                  backgroundColor: Colors.blue.shade50,
                  strokeCap: StrokeCap.round,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              Column(
                children: [
                  Text(
                    "${controller.masteryPercentage}%",
                    style: getTextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    "MASTERY",
                    style: getTextStyle(fontSize: 10.sp, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            "Great job, Alex!",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            "You're in the top 15% of learners this week.",
            style: TextStyle(fontSize: 13.sp, color: Colors.blueGrey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildXPProgressCard() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NEXT LEVEL",
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
            ),
            SizedBox(height: 4.h),
            Text(
              "${controller.nextLevelXP} XP",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value: controller.currentXPProgress.value,
              backgroundColor: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: [
        _buildStatTile(
          "40",
          "Total",
          Icons.list_alt_rounded,
          Colors.grey.shade100,
        ),
        _buildStatTile(
          "25",
          "Completed",
          Icons.check_circle_rounded,
          Colors.green.shade50,
        ),
        _buildStatTile(
          "05",
          "In Progress",
          Icons.more_horiz_rounded,
          Colors.blue.shade50,
        ),
        _buildStatTile(
          "10",
          "Not Started",
          Icons.hourglass_empty_rounded,
          Colors.orange.shade50,
        ),
      ],
    );
  }

  Widget _buildActivityList() {
    return Column(
      children: controller.recentActivities.map((activity) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.airplanemode_active,
                  color: Colors.blue,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      activity['time'],
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  activity['score'],
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Common UI Helpers
  Widget _buildSectionHeader(String title) => Text(
    title,
    style: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
      letterSpacing: 0.5,
    ),
  );

  Widget _buildInfoCard(String label, String val, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(icon, color: color, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  val,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String count, String label, IconData icon, Color bg) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 18.sp, color: Colors.blueGrey),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              Text(
                label,
                style: TextStyle(color: Colors.grey, fontSize: 11.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
