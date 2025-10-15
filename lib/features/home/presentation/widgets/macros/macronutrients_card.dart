import 'package:flutter/cupertino.dart';
import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import 'macro_item.dart';

class MacronutrientsCard extends StatelessWidget {
  final double consumedProtein;
  final double goalProtein;
  final double consumedCarbs;
  final double goalCarbs;
  final double consumedFats;
  final double goalFats;

  const MacronutrientsCard({
    super.key,
    required this.consumedProtein,
    required this.goalProtein,
    required this.consumedCarbs,
    required this.goalCarbs,
    required this.consumedFats,
    required this.goalFats,
  });

  @override
  Widget build(BuildContext context) {
    final proteinProgress = goalProtein > 0
        ? (consumedProtein / goalProtein).clamp(0.0, 1.0)
        : 0.0;
    final carbsProgress = goalCarbs > 0
        ? (consumedCarbs / goalCarbs).clamp(0.0, 1.0)
        : 0.0;
    final fatsProgress = goalFats > 0
        ? (consumedFats / goalFats).clamp(0.0, 1.0)
        : 0.0;

    return Row(
      children: [
        Expanded(
          child: MacroItem(
            label: 'Protein',
            value: '${consumedProtein.toInt()}g',
            sublabel: '${goalProtein.toInt()}g goal',
            color: AppColors.macroProtein,
            svgAsset: AppAssets.protein,
            progress: proteinProgress,
          ),
        ),
        Expanded(
          child: MacroItem(
            label: 'Carbs',
            value: '${consumedCarbs.toInt()}g',
            sublabel: '${goalCarbs.toInt()}g goal',
            color: AppColors.macroCarbs,
            svgAsset: AppAssets.carbs,
            progress: carbsProgress,
          ),
        ),
        Expanded(
          child: MacroItem(
            label: 'Fat',
            value: '${consumedFats.toInt()}g',
            sublabel: '${goalFats.toInt()}g goal',
            color: AppColors.macroFats,
            svgAsset: AppAssets.fats,
            progress: fatsProgress,
          ),
        ),
      ],
    );
  }
}
