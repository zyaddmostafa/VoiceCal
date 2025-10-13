import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomSnackbar {
  CustomSnackbar._();

  static void showSuccess(BuildContext context, String message) {
    _showCupertinoBanner(
      context: context,
      message: message,
      icon: CupertinoIcons.check_mark_circled_solid,
      iconColor: CupertinoColors.systemGreen,
      duration: const Duration(seconds: 2),
    );
  }

  static void showError(BuildContext context, String message) {
    _showCupertinoBanner(
      context: context,
      message: message,
      icon: CupertinoIcons.exclamationmark_circle_fill,
      iconColor: CupertinoColors.systemRed,
      duration: const Duration(seconds: 3),
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showCupertinoBanner(
      context: context,
      message: message,
      icon: CupertinoIcons.info_circle_fill,
      iconColor: CupertinoColors.systemBlue,
      duration: const Duration(seconds: 2),
    );
  }

  static void showWarning(BuildContext context, String message) {
    _showCupertinoBanner(
      context: context,
      message: message,
      icon: CupertinoIcons.exclamationmark_triangle_fill,
      iconColor: CupertinoColors.systemOrange,
      duration: const Duration(seconds: 2),
    );
  }

  static void _showCupertinoBanner({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color iconColor,
    required Duration duration,
  }) {
    if (!context.mounted) return;

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _CupertinoToastBanner(
        message: message,
        icon: icon,
        iconColor: iconColor,
        duration: duration,
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration + const Duration(milliseconds: 300), () {
      overlayEntry.remove();
    });
  }
}

class _CupertinoToastBanner extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color iconColor;
  final Duration duration;

  const _CupertinoToastBanner({
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.duration,
  });

  @override
  State<_CupertinoToastBanner> createState() => _CupertinoToastBannerState();
}

class _CupertinoToastBannerState extends State<_CupertinoToastBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 20.w,
      right: 20.w,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.backgroundPrimary,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border, width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: widget.iconColor, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: AppTextStyles.font14MediumPrimary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
