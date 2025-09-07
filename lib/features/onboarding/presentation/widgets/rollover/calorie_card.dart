import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Calorie tracking card widget for yesterday/today display
class CalorieCard extends StatelessWidget {
  final String day;
  final int consumed;
  final int goal;
  final int caloriesLeft;
  final int? rolloverAmount;
  final bool isToday;

  const CalorieCard({
    super.key,
    required this.day,
    required this.consumed,
    required this.goal,
    required this.caloriesLeft,
    this.rolloverAmount,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final progress = consumed / goal;

    return SizedBox(
      height: 300.h,
      child: Container(
        padding: EdgeInsets.all(20.w),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day header with flame icon
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  size: 16.sp,
                  color: const Color(0xFF1D1D1F),
                ),
                SizedBox(width: 6.w),
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Main calorie display
            Text(
              '$consumed/$goal',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1D1D1F),
                letterSpacing: -0.5,
              ),
            ),

            // Rollover indicator for today
            if (rolloverAmount != null) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh,
                      size: 12.sp,
                      color: const Color(0xFF007AFF),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '+$rolloverAmount',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF007AFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const Spacer(),

            // Calories left label
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1D1F),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                isToday && rolloverAmount != null
                    ? 'Cals left ${caloriesLeft - rolloverAmount!}+$rolloverAmount'
                    : 'Cals left $caloriesLeft',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Circular progress indicator
            Center(
              child: SizedBox(
                width: 60.w,
                height: 60.h,
                child: Stack(
                  children: [
                    // Background circle
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF2F2F7),
                      ),
                    ),
                    // Progress circle
                    SizedBox(
                      width: 60.w,
                      height: 60.h,
                      child: CircularProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        strokeWidth: 4.w,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isToday
                              ? const Color(0xFF007AFF)
                              : const Color(0xFFFF3B30),
                        ),
                      ),
                    ),
                    // Center flame icon
                    const Center(
                      child: Icon(
                        Icons.local_fire_department,
                        size: 20,
                        color: Color(0xFF1D1D1F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
