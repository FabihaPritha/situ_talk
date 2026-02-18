import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:situ_talk/core/common/styles/global_text_style.dart';
import 'package:situ_talk/core/utils/constants/colors.dart';

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String userName;
  final VoidCallback onSettings;
  final VoidCallback onNotifications;
  final int notificationCount;

  HomeAppBarDelegate({
    required this.expandedHeight,
    required this.userName,
    required this.onSettings,
    required this.onNotifications,
    required this.notificationCount,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // 0.0 at expanded, 1.0 at fully collapsed
    final percent = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    // Smoothly interpolate sizes
    final avatarSize = (28.r) * (1 - percent * 0.4); // Shrinks slightly
    final titleSize = (20.sp) * (1 - percent * 0.15); // Text gets smaller
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: maxExtent - shrinkOffset,
      color: AppColors.primary,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background/Flexible Space
          Positioned(
            left: 20.w,
            top: topPadding + 8.h,
            right: 120.w, // Space for action buttons
            child: Row(
              children: [
                // Animated Avatar
                CircleAvatar(
                  radius: avatarSize,
                  backgroundImage: const NetworkImage(
                    'https://i.pravatar.cc/150?u=john',
                  ),
                ),
                SizedBox(width: 12.w),
                // Animated Text Column
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        percent > 0.5 ? "Good morning," : "Welcome back,",
                        style: getTextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "$userName!",
                        style: getTextStyle(
                          color: Colors.white,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                          lineHeight: 18.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Actions (Always pinned at top right)
          Positioned(
            top: topPadding + 5.h,
            right: 4.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                  onPressed: onSettings,
                ),
                _buildNotificationIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
          ),
          onPressed: onNotifications,
        ),
        if (notificationCount > 0)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
            ),
          ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent {
    // Use a safe minimum height that accommodates status bar + content
    return kToolbarHeight + 30.h;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
