import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/helpers/spacing.dart';
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
        horizontalSpace(16),
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
