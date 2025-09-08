import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Reusable gender selection card widget with iOS-style animation
class GenderCard extends StatefulWidget {
  final String gender;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.gender,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<GenderCard> createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius = BorderRadius.circular(20.r);
    final iconSize = 24.sp;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: cardBorderRadius,
          border: Border.all(
            color: widget.isSelected
                ? AppColors.primaryBlack
                : const Color(0xFFE5E5E7),
            width: widget.isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSelected
                  ? AppColors.primaryBlack.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: widget.isSelected ? 15 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: cardBorderRadius,
            onTap: () {
              HapticFeedback.lightImpact();
              widget.onTap();
            },
            onTapDown: (_) => _scaleController.forward(),
            onTapUp: (_) => _scaleController.reverse(),
            onTapCancel: () => _scaleController.reverse(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: widget.isSelected
                          ? AppColors.primaryBlack
                          : const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      widget.icon,
                      size: iconSize,
                      color: widget.isSelected
                          ? Colors.white
                          : const Color(0xFF8E8E93),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    widget.gender,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: widget.isSelected
                          ? AppColors.primaryBlack
                          : const Color(0xFF1D1D1F),
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Spacer(),
                  if (widget.isSelected)
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primaryBlack,
                      size: iconSize,
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
