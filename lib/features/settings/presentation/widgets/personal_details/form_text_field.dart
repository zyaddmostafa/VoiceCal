import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final String? suffix;
  final String? Function(String?)? validator;
  final bool enabled;

  const FormTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          horizontalSpace(16),
          Expanded(
            flex: 3,
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              enabled: enabled,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              placeholder: hint,
              placeholderStyle: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
              suffix: suffix != null
                  ? Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Text(
                        suffix!,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : null,
              decoration: null,
              padding: EdgeInsets.zero,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
