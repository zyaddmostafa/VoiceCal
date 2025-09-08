import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';

class RolloverDayCard extends StatelessWidget {
  final String dayLabel;
  final int consumed;
  final int goal;
  final int calsLeft;
  final int? extraFromRollover;
  final Color headerColor;

  const RolloverDayCard({
    super.key,
    required this.dayLabel,
    required this.consumed,
    required this.goal,
    required this.calsLeft,
    this.extraFromRollover,
    required this.headerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 36.h,
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            alignment: Alignment.center,
            child: Text(
              dayLabel,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C2C2E),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$consumed',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      '/$goal',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0xFF8E8E93),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                verticalSpace(12),
              ],
            ),
          ),
          Stack(
            children: [
              // Cals left tag
              const RolloverCardCaloriesRing(),
              Positioned(
                left: 8,
                top: 0,
                child: RolloverCaloriesExample(
                  extraFromRollover: extraFromRollover,
                  calsLeft: calsLeft,
                ),
              ),

              // Minimal ring visual (static placeholder)
            ],
          ),
        ],
      ),
    );
  }
}

class RolloverCaloriesExample extends StatelessWidget {
  const RolloverCaloriesExample({
    super.key,
    required this.extraFromRollover,
    required this.calsLeft,
  });

  final int? extraFromRollover;
  final int calsLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        extraFromRollover == null
            ? 'Cals left \n $calsLeft'
            : 'Cals left \n $calsLeft + $extraFromRollover',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class RolloverCardCaloriesRing extends StatelessWidget {
  const RolloverCardCaloriesRing({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 72.w,
        width: 72.w,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(color: Colors.black, width: 4.w),
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.local_fire_department,
                size: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
