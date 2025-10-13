import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/custom_app_bar.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../data/model/nutrition_goal_model.dart';
import '../widgets/goal_item.dart';

class EditNutritionGoalsScreen extends StatefulWidget {
  const EditNutritionGoalsScreen({super.key, this.nutritionGoal});

  final NutritionGoalModel? nutritionGoal;

  @override
  State<EditNutritionGoalsScreen> createState() =>
      _EditNutritionGoalsScreenState();
}

class _EditNutritionGoalsScreenState extends State<EditNutritionGoalsScreen> {
  late List<GoalData> _goals;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _goals = _buildInitialGoals();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 20.w;
    final topPadding = 24.h;
    final itemSpacing = 12.h;

    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar.build(
        context: context,
        child: const Text('Adjust goals', style: AppTextStyles.font28BoldBlack),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          topPadding,
          horizontalPadding,
          40.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adjust goals',
              style: AppTextStyles.headingLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            verticalSpace(24),
            ...List.generate(_goals.length, (index) {
              final goal = _goals[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == _goals.length - 1 ? 0 : itemSpacing,
                ),
                child: GoalItem(
                  title: goal.title,
                  value: goal.value,
                  progressColor: goal.progressColor,
                  icon: goal.icon,
                  progressPercentage: goal.progressPercentage,
                  onValueChanged: (newValue) =>
                      _updateGoalValue(index, newValue),
                ),
              );
            }),
            verticalSpace(32),
            _isSaving
                ? const Center(child: CupertinoActivityIndicator())
                : CustomAppButton(text: 'Save Goals', onPressed: _saveGoals),
          ],
        ),
      ),
    );
  }

  List<GoalData> _buildInitialGoals() {
    final data = widget.nutritionGoal;
    if (data == null) {
      return [
        GoalData(
          title: 'Calorie goal',
          value: '1595',
          progressColor: const Color(0xFF111827),
          icon: Icons.local_fire_department,
          progressPercentage: 75,
        ),
        GoalData(
          title: 'Protein goal',
          value: '87',
          progressColor: const Color(0xFFFF453A),
          icon: Icons.flash_on,
          progressPercentage: 60,
        ),
        GoalData(
          title: 'Carb goal',
          value: '211',
          progressColor: const Color(0xFFFF9F0A),
          icon: Icons.local_florist,
          progressPercentage: 45,
        ),
        GoalData(
          title: 'Fat goal',
          value: '44',
          progressColor: const Color(0xFF0A84FF),
          icon: Icons.water_drop,
          progressPercentage: 30,
        ),
      ];
    }

    return [
      GoalData(
        title: 'Calorie goal',
        value: data.calorieGoal,
        progressColor: const Color(0xFF111827),
        icon: Icons.local_fire_department,
        progressPercentage: 75,
      ),
      GoalData(
        title: 'Protein goal',
        value: data.proteinGoal,
        progressColor: const Color(0xFFFF453A),
        icon: Icons.flash_on,
        progressPercentage: 60,
      ),
      GoalData(
        title: 'Carb goal',
        value: data.carbGoal,
        progressColor: const Color(0xFFFF9F0A),
        icon: Icons.local_florist,
        progressPercentage: 45,
      ),
      GoalData(
        title: 'Fat goal',
        value: data.fatGoal,
        progressColor: const Color(0xFF0A84FF),
        icon: Icons.water_drop,
        progressPercentage: 30,
      ),
    ];
  }

  void _updateGoalValue(int index, String newValue) {
    setState(() {
      _goals[index] = _goals[index].copyWith(value: newValue);
    });
    // TODO: Save to backend/cubit
  }

  Future<void> _saveGoals() async {
    setState(() => _isSaving = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isSaving = false);

    // Show success snackbar
    CustomSnackbar.showSuccess(context, 'Goals saved successfully!');

    // Wait a bit for snackbar to show, then pop
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}

class GoalData {
  final String title;
  final String value;
  final Color progressColor;
  final IconData icon;
  final double progressPercentage;

  const GoalData({
    required this.title,
    required this.value,
    required this.progressColor,
    required this.icon,
    required this.progressPercentage,
  });

  GoalData copyWith({
    String? title,
    String? value,
    Color? progressColor,
    IconData? icon,
    double? progressPercentage,
  }) {
    return GoalData(
      title: title ?? this.title,
      value: value ?? this.value,
      progressColor: progressColor ?? this.progressColor,
      icon: icon ?? this.icon,
      progressPercentage: progressPercentage ?? this.progressPercentage,
    );
  }
}
