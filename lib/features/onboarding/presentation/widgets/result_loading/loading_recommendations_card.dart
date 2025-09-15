import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class LoadingRecommendationsCard extends StatelessWidget {
  final List<String> items;
  final List<bool> completedItems;

  const LoadingRecommendationsCard({
    super.key,
    required this.items,
    required this.completedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily recommendation for',
            style: AppTextStyles.font18BoldPrimary,
          ),
          verticalSpace(16),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isCompleted =
                index < completedItems.length && completedItems[index];

            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Text('• $item', style: AppTextStyles.font16MediumBlack),
                  const Spacer(),
                  if (isCompleted)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.textPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
