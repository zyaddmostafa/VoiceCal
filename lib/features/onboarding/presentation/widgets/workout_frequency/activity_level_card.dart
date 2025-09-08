import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Activity level selection card with icon, title and description
class ActivityLevelCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityLevelCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ActivityLevelCard> createState() => _ActivityLevelCardState();
}

class _ActivityLevelCardState extends State<ActivityLevelCard>
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
    final borderRadius = BorderRadius.circular(20.r);
    final iconSize = 24.sp;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 16.h),
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
                  ? AppColors.primaryBlack.withOpacity(0.15)
                  : Colors.black.withOpacity(0.05),
              blurRadius: widget.isSelected ? 12 : 8,
              offset: const Offset(0, 4),
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
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(widget.emoji, style: TextStyle(fontSize: iconSize)),
                  SizedBox(width: 16.w),
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
                        SizedBox(height: 4.h),
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
