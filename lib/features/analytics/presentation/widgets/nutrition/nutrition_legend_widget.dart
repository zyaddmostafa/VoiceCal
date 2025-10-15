import 'package:flutter/material.dart';
import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import 'legend_item.dart';

class NutritionLegendWidget extends StatelessWidget {
  const NutritionLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LegendItem(
          color: AppColors.macroProtein,
          label: 'Protein',
          svgAsset: AppAssets.protein,
        ),
        LegendItem(
          color: AppColors.macroCarbs,
          label: 'Carbs',
          svgAsset: AppAssets.carbs,
        ),
        LegendItem(
          color: AppColors.macroFats,
          label: 'Fats',
          svgAsset: AppAssets.fats,
        ),
      ],
    );
  }
}
