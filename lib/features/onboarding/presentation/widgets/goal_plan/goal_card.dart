import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/helpers/spacing.dart';

/// Goal selection card with icon, title and description
class GoalCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard>
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
    final borderRadius = BorderRadius.circular(18.r);
    final iconSize = 28.sp;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          border: Border.all(
            color: widget.isSelected
                ? AppColors.primaryBlack
                : const Color(0xFFE5E5E7),
            width: widget.isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSelected
                  ? AppColors.primaryBlack.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.08),
              blurRadius: widget.isSelected ? 15 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {
              HapticFeedback.lightImpact();
              widget.onTap();
            },
            onTapDown: (_) => _scaleController.forward(),
            onTapUp: (_) => _scaleController.reverse(),
            onTapCancel: () => _scaleController.reverse(),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: widget.isSelected
                          ? AppColors.primaryBlack
                          : const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      widget.icon,
                      size: iconSize,
                      color: widget.isSelected
                          ? Colors.white
                          : const Color(0xFF8E8E93),
                    ),
                  ),
                  horizontalSpace(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: widget.isSelected
                                ? AppColors.primaryBlack
                                : const Color(0xFF1D1D1F),
                          ),
                        ),
                        verticalSpace(6),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF86868B),
                          ),
                        ),
                      ],
                    ),
                  ),
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
