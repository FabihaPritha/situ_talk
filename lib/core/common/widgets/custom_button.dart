import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:situ_talk/core/common/styles/global_text_style.dart';
import 'package:situ_talk/core/utils/constants/colors.dart';


class CustomButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double? height;
  final IconData? iconData; // Optional IconData
  final String? assetIcon; // Optional asset icon (SVG)
  final String? imageAsset; // Optional image asset (PNG/JPG)

  // Constructor to make the button reusable with optional parameters
  const CustomButton({
    super.key,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.onPressed,
    this.borderRadius = 10.0, // Default border radius is 12
    this.height, // Optional height
    this.iconData, // Optional IconData
    this.assetIcon, // Optional asset icon (SVG)
    this.imageAsset, // Optional image asset (PNG/JPG)
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 60.0, // Default height if not provided
        width: double.infinity, // Make the width infinity (full width)
        decoration: BoxDecoration(
          color:
              backgroundColor ?? AppColors.primary, // Default background color
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1.0) // Optional border
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display IconData if provided
              if (iconData != null) ...[
                Icon(iconData, color: textColor ?? Colors.white, size: 20.sp),
                SizedBox(width: 8.w), // Add space between icon and text
              ],
              // Display SVG asset icon if provided
              if (assetIcon != null) ...[
                SvgPicture.asset(
                  assetIcon!, // SVG asset
                  height: 20.h,
                  width: 20.w,
                  colorFilter: textColor != null
                      ? ColorFilter.mode(textColor!, BlendMode.srcIn)
                      : null,
                ),
                SizedBox(width: 8.w), // Add space between icon and text
              ],
              // Display Image asset if provided
              if (imageAsset != null) ...[
                Image.asset(
                  imageAsset!, // Image asset (PNG/JPG)
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(width: 8.w), // Add space between image and text
              ],
              // Display text if provided
              if (text != null) ...[
                Text(
                  text!,
                  style: getTextStyle(
                    color: textColor ?? Colors.black, // Default text color
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    // lineHeight: 11.sp,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
