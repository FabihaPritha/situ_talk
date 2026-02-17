import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/common/styles/global_text_style.dart';
import 'package:situ_talk/core/utils/constants/colors.dart';
import 'package:situ_talk/features/onboarding/controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  final controller = Get.put(OnboardingController());

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Page Content
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.currentPage.call,
                itemCount: controller.onboardingPages.length,
                itemBuilder: (context, index) {
                  final data = controller.onboardingPages[index];
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(data.imagePath, height: 250.h),
                        // const SizedBox(height: 40),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: getTextStyle(
                              fontSize: 18.h,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              lineHeight: 15.sp,
                            ),
                            children: [
                              TextSpan(text: data.title),
                              if (data.highlightText != null)
                                TextSpan(
                                  text: data.highlightText,
                                  style: getTextStyle(
                                    color: AppColors.primary,
                                    lineHeight: 15.sp,
                                    fontSize: 18.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          data.description,
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                            lineHeight: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom UI: Indicator + Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  // Page Indicator (Smooth dots)
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.onboardingPages.length,
                        (index) => AnimatedContainer(
                          duration: 300.milliseconds,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: controller.currentPage.value == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? AppColors.primary
                                : const Color.fromARGB(255, 219, 214, 214),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Custom Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        onPressed: controller.nextPage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.isLastPage ? "Get Started" : "Next",
                              style: getTextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                lineHeight: 20.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
