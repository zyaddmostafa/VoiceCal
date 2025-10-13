import 'package:flutter/cupertino.dart';
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

    return showCupertinoDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          'Edit Quantity',
          style: AppTextStyles.font20SemiBoldPrimary,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(8),
            Text(
              'Enter the number of servings',
              style: AppTextStyles.font14RegularSecondary,
            ),
            verticalSpace(12),
            CupertinoTextField(
              controller: quantityController,
              style: AppTextStyles.font16MediumBlack,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              autofocus: true,
              placeholder: '1',
              placeholderStyle: AppTextStyles.font14RegularSecondary,
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              padding: EdgeInsets.all(12.r),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            isDefaultAction: false,
            child: Text(
              'Cancel',
              style: AppTextStyles.font16MediumBlack.copyWith(
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              final quantity = int.tryParse(quantityController.text.trim());
              if (quantity != null && quantity > 0) {
                Navigator.of(context).pop(quantity);
              }
            },
            isDefaultAction: true,
            child: Text(
              'Save',
              style: AppTextStyles.font16MediumBlack.copyWith(
                color: CupertinoColors.activeBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
