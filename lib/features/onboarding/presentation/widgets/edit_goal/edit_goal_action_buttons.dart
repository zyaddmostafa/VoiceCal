import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_outlined_button.dart';
import 'custom_filled_button.dart';

class EditGoalActionButtons extends StatelessWidget {
  final VoidCallback onRevert;
  final VoidCallback onDone;

  const EditGoalActionButtons({
    super.key,
    required this.onRevert,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedButton(
            text: 'Revert',
            onTap: () {
              HapticFeedback.lightImpact();
              onRevert();
            },
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomFilledButton(
            text: 'Done',
            onTap: () {
              HapticFeedback.lightImpact();
              onDone();
            },
          ),
        ),
      ],
    );
  }
}
