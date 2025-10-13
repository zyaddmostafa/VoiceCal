import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class RegenerateBottomSheet {
  static void show(
    BuildContext context, {
    required Function(String) onRegenerate,
  }) {
    final TextEditingController descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.auto_fix_high,
                              color: AppColors.textPrimary,
                              size: 24.sp,
                            ),
                            horizontalSpace(8),
                            Text(
                              'Fix Results',
                              style: AppTextStyles.font20SemiBoldPrimary,
                            ),
                          ],
                        ),
                        verticalSpace(8),
                        Text(
                          'Describe your meal to regenerate',
                          style: AppTextStyles.font14RegularSecondary,
                        ),
                      ],
                    ),

                    verticalSpace(24),

                    // Input field
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.border, width: 1.5),
                      ),
                      child: TextFormField(
                        controller: descriptionController,
                        style: AppTextStyles.font14MediumPrimary,
                        maxLines: 4,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText:
                              'e.g., Grilled chicken with rice and broccoli',
                          hintStyle: AppTextStyles.font14RegularSecondary,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.r),
                        ),
                      ),
                    ),

                    verticalSpace(24),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            borderRadius: BorderRadius.circular(22.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundPrimary,
                                border: Border.all(
                                  color: AppColors.border,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(22.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: AppTextStyles.font14MediumPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(12),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              final description = descriptionController.text
                                  .trim();
                              if (description.isNotEmpty) {
                                Navigator.of(context).pop();
                                onRegenerate(description);
                              }
                            },
                            borderRadius: BorderRadius.circular(22.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlack,
                                borderRadius: BorderRadius.circular(22.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryBlack.withValues(
                                      alpha: 0.2,
                                    ),
                                    blurRadius: 8,
                                    offset: Offset(0, 2.h),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Regenerate',
                                  style: AppTextStyles.font14SemiBoldWhite
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    verticalSpace(8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
