import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

/// Editable text field for goal value input
class EditableValueField extends StatelessWidget {
  const EditableValueField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.progressColor,
    required this.valueStyle,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Color progressColor;
  final TextStyle valueStyle;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      style: valueStyle,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.fromBorderSide(
          BorderSide(color: progressColor.withOpacity(0.3), width: 2),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      onSubmitted: (_) => onSubmitted(),
    );
  }
}
