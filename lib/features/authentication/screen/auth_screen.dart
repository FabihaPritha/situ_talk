import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/common/styles/global_text_style.dart';
import 'package:situ_talk/core/common/widgets/custom_button.dart';
import 'package:situ_talk/core/utils/constants/colors.dart';
import 'package:situ_talk/core/utils/constants/icon_path.dart';
import 'package:situ_talk/features/authentication/controller/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  final controller = Get.put(AuthController());

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Spacer(),
              // App Logo or Illustration
              // const Icon(Icons.language_rounded, size: 80, color: Color(0xFF337AB7)),
              SizedBox(height: 24),
              Text(
                "Welcome to",
                style: getTextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  lineHeight: 22.sp,
                ),
              ),
              7.h.verticalSpace,
              Image.asset(IconPath.apptext),
              10.h.verticalSpace,
              Text(
                "Choose your preferred way to continue",
                textAlign: TextAlign.center,
                style: getTextStyle(
                  color: const Color.fromARGB(255, 158, 158, 158),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  lineHeight: 15.sp,
                ),
              ),

              Spacer(),
              // 70.h.verticalSpace,
              CustomButton(
                imageAsset: IconPath.googleLogo,
                text: 'Continue with Google',
                textColor: Colors.black,
                backgroundColor: Colors.white,
                borderColor: const Color.fromARGB(255, 179, 179, 179),
                onPressed: controller.isLoading.value
                    ? null
                    : controller.loginWithGoogle,
              ),
              10.h.verticalSpace,
              CustomButton(
                iconData: Icons.apple,
                text: 'Continue with Apple',
                textColor: Colors.white,
                backgroundColor: Colors.black,
                onPressed: controller.isLoading.value
                    ? null
                    : controller.loginWithApple,
              ),
              10.h.verticalSpace,
              CustomButton(
                iconData: Icons.facebook,
                text: 'Continue with Facebook',
                textColor: Colors.white,
                backgroundColor: const Color(0xFF1877F2),
                onPressed: controller.isLoading.value
                    ? null
                    : controller.loginWithFacebook,
              ),

              // Social Buttons Container
              SizedBox(height: 40),
              // Privacy Policy Text
              Text(
                "By continuing, you agree to our Terms and Privacy Policy",
                textAlign: TextAlign.center,
                style: getTextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  lineHeight: 8.sp,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
