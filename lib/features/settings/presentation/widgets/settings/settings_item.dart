import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailing;
  final bool hasArrow;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? iconColor;
  final bool isDestructive;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.hasArrow = false,
    this.onTap,
    this.titleColor,
    this.iconColor,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = isDestructive
        ? const Color(0xFFFF5555)
        : iconColor ?? const Color(0xFF666666);

    final effectiveTitleColor = isDestructive
        ? const Color(0xFFFF5555)
        : titleColor ?? Colors.black;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE5E5E5), width: 0.5),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20.sp, color: effectiveIconColor),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: effectiveTitleColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      verticalSpace(2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                Text(
                  trailing!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
                horizontalSpace(8),
              ],
              if (hasArrow)
                Icon(
                  Icons.chevron_right,
                  size: 20.sp,
                  color: const Color(0xFF666666),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
