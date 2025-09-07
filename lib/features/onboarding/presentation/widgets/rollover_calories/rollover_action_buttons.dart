import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'action_button.dart';

class RolloverActionButtons extends StatelessWidget {
  final VoidCallback onNoPressed;
  final VoidCallback onYesPressed;

  const RolloverActionButtons({
    super.key,
    required this.onNoPressed,
    required this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(label: 'No', onPressed: onNoPressed),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ActionButton(label: 'Yes', onPressed: onYesPressed),
        ),
      ],
    );
  }
}
