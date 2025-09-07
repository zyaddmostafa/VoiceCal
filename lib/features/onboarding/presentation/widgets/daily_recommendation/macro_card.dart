import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../screens/edit_goal_screen.dart';
import '../edit_goal/edit_goal_args.dart';

/// Macro card widget displaying nutrition information with circular progress
class MacroCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double progress;
  final Color progressColor;

  const MacroCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE5E5E7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20.sp, color: const Color(0xFF1D1D1F)),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1D1D1F),
                ),
              ),
            ],
          ),
          verticalSpace(12),
          // Circular progress indicator with value
          Center(
            child: SizedBox(
              width: 65.w,
              height: 65.h,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  // Background circle
                  Container(
                    width: 65.w,
                    height: 65.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF2F2F7),
                    ),
                  ),
                  // Progress circle
                  SizedBox(
                    width: 65.w,
                    height: 65.h,
                    child: CircularProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      strokeWidth: 6.w,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),
                  ),
                  // Center value text
                  Center(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1D1D1F),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Edit icon
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                _navigateToEdit(context);
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Color(0xFF86868B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEdit(BuildContext context) {
    final args = EditGoalArgs(
      label: label,
      unit: label == 'Calories' ? '' : 'g',
      value: int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
      progress: progress,
      ringColor: progressColor,
      icon: icon,
    );
    Navigator.of(context).pushNamed(Routes.editGoalScreen, arguments: args);
  }
}
