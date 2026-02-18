import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:situ_talk/core/common/styles/global_text_style.dart';
import 'package:situ_talk/core/utils/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);
    
    // The back button only shows if the user wants it AND there's a page to go back to.
    final bool isBackVisible = showBackButton && canPop;

    return AppBar(
      // Logic: If there's no back button, we force centerTitle to true.
      centerTitle: !isBackVisible ? true : centerTitle,
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      leading: isBackVisible
          ? IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
              onPressed: onBackPressed ?? () => Get.back(),
            )
          : null,
      title: Text(
        title,
        style: getTextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0.h),
        child: Divider(
          color: AppColors.textSecondary.withOpacity(0.2),
          height: 1.0.h,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}




// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:situ_talk/core/common/styles/global_text_style.dart';
// import 'package:situ_talk/core/utils/constants/colors.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final VoidCallback? onBackPressed;
//   final List<Widget>? actions;
//   final bool showBackButton;
//   final bool centerTitle;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.onBackPressed,
//     this.actions,
//     this.showBackButton = true,
//     this.centerTitle = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Check if the current navigator can pop
//     final bool canPop = Navigator.canPop(context);

//     return AppBar(
//       centerTitle: centerTitle,
//       backgroundColor: Colors.white,
//       elevation: 0,
//       surfaceTintColor: Colors.white,
//       // Only show the button if explicitly requested AND the navigator has a page to go back to
//       leading: (showBackButton && canPop)
//           ? IconButton(
//               icon: Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.black,
//                   size: 20.sp,
//                 ),
//               ),
//               onPressed: onBackPressed ?? () => Get.back(),
//             )
//           : null,
//       title: Text(
//         title,
//         style: getTextStyle(
//           fontSize: 16.sp,
//           fontWeight: FontWeight.w600,
//           color: Colors.black,
//         ),
//       ),
//       actions: actions,
//       bottom: PreferredSize(
//         preferredSize: Size.fromHeight(1.0.h),
//         child: Divider(
//           color: AppColors.textSecondary.withValues(alpha: 0.2),
//           height: 1.0.h,
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
