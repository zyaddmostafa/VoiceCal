import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import 'edit_goal_args.dart';
import 'progress_ring.dart';
import 'value_display.dart';

class GoalPreviewCard extends StatelessWidget {
  final EditGoalArgs args;
  final String inputValue;

  const GoalPreviewCard({
    super.key,
    required this.args,
    required this.inputValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: const Border.fromBorderSide(
          BorderSide(color: Color(0xFFE5E5E7)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ProgressRing(
            progress: args.progress.clamp(0.0, 1.0),
            color: args.ringColor,
            icon: args.icon,
          ),
          horizontalSpace(16),
          ValueDisplay(inputValue: inputValue, unit: args.unit),
        ],
      ),
    );
  }
}
