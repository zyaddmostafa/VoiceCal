import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'spacing.dart';

class QuantityDialogHelper {
  static Future<int?> show(
    BuildContext context, {
    required int currentQuantity,
  }) async {
    final TextEditingController quantityController = TextEditingController(
      text: currentQuantity.toString(),
    );

    return showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Edit Quantity',
          style: AppTextStyles.font20SemiBoldPrimary,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter the number of servings',
              style: AppTextStyles.font14RegularSecondary,
            ),
            verticalSpace(16),
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: TextFormField(
                controller: quantityController,
                style: AppTextStyles.font16MediumBlack,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '1',
                  hintStyle: AppTextStyles.font14RegularSecondary,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
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
                      border: Border.all(color: AppColors.border, width: 1.5),
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
                child: InkWell(
                  onTap: () {
                    final quantity = int.tryParse(
                      quantityController.text.trim(),
                    );
                    if (quantity != null && quantity > 0) {
                      Navigator.of(context).pop(quantity);
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
                          color: AppColors.primaryBlack.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: AppTextStyles.font14SemiBoldWhite.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
