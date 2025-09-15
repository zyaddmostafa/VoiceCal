import 'package:flutter/material.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/nutrition/nutrition_calculator_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../../data/models/calories_and_Macros_model.dart';
import '../../data/models/original_nutrition_values_model.dart';
import '../widgets/edit_goal/edit_goal_args.dart';
import '../widgets/edit_goal/goal_preview_card.dart';
import '../widgets/edit_goal/goal_input_field.dart';
import '../widgets/edit_goal/edit_goal_action_buttons.dart';
import '../widgets/edit_goal/number_formatter.dart';
import '../widgets/edit_goal/keyboard_aware_spacer.dart';

class EditGoalScreen extends StatefulWidget {
  final EditGoalArgs? editRecommendedPlan;
  final CaloriesAndMacrosModel? caloriesAndMacros;

  const EditGoalScreen({
    super.key,
    this.editRecommendedPlan,
    this.caloriesAndMacros,
  });

  @override
  State<EditGoalScreen> createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  // Constants
  static const int _defaultCalorieValue = 2000;
  static const double _defaultProgress = 0.6;
  static const String _defaultCalorieLabel = 'Calories';
  static const String _caloriesLabel = 'Calories';

  // Controllers and state
  late final TextEditingController _controller;
  late final EditGoalArgs _args;
  late final int _initialValue;

  @override
  void initState() {
    super.initState();
    _initializeEditGoal();
  }

  void _initializeEditGoal() {
    _args = _getEditGoalArgs();
    _initialValue = _args.value;
    _controller = TextEditingController(
      text: NumberFormatter.format(_args.value),
    );
  }

  EditGoalArgs _getEditGoalArgs() {
    return widget.editRecommendedPlan ?? _createDefaultArgs();
  }

  EditGoalArgs _createDefaultArgs() {
    final defaultCalories =
        widget.caloriesAndMacros?.calories?.toInt() ?? _defaultCalorieValue;

    return EditGoalArgs(
      label: _caloriesLabel,
      unit: '',
      value: defaultCalories,
      progress: _defaultProgress,
      ringColor: AppColors.primaryBlack,
      icon: Icons.local_fire_department,
    );
  }

  void _onRevert() {
    setState(() {
      _controller.text = NumberFormatter.format(_initialValue);
    });
  }

  void _onDone() {
    if (!_isValidData()) return;

    final newValue = _getParsedInputValue();
    final originalValues = _getOriginalNutritionValues();
    final updatedCaloriesAndMacros = _calculateUpdatedNutrition(
      newValue,
      originalValues,
    );

    Navigator.pop(context, updatedCaloriesAndMacros);
  }

  bool _isValidData() {
    return widget.caloriesAndMacros != null;
  }

  double _getParsedInputValue() {
    return NumberFormatter.parse(_controller.text).toDouble();
  }

  OriginalNutritionValuesModel _getOriginalNutritionValues() {
    final original = widget.caloriesAndMacros!;

    return OriginalNutritionValuesModel(
      calories: (original.calories ?? 0).toDouble(),
      protein: (original.protein ?? 0).toDouble(),
      carbs: (original.carbs ?? 0).toDouble(),
      fats: (original.fats ?? 0).toDouble(),
    );
  }

  CaloriesAndMacrosModel _calculateUpdatedNutrition(
    double newValue,
    OriginalNutritionValuesModel originalValues,
  ) {
    final original = widget.caloriesAndMacros!;

    return _isEditingCalories()
        ? _recalculateMacrosFromCalories(newValue, originalValues, original)
        : _recalculateFromMacroChange(newValue, originalValues);
  }

  bool _isEditingCalories() => _args.label == _caloriesLabel;

  CaloriesAndMacrosModel _recalculateMacrosFromCalories(
    double newCalories,
    OriginalNutritionValuesModel originalValues,
    CaloriesAndMacrosModel original,
  ) {
    final newMacros = NutritionCalculatorService.recalculateMacrosFromCalories(
      newCalories: newCalories,
      originalCalories: originalValues.calories,
      originalProtein: originalValues.protein,
      originalCarbs: originalValues.carbs,
      originalFats: originalValues.fats,
    );

    return original.copyWith(
      calories: newCalories,
      protein: newMacros.protein,
      carbs: newMacros.carbs,
      fats: newMacros.fats,
    );
  }

  CaloriesAndMacrosModel _recalculateFromMacroChange(
    double newMacroValue,
    OriginalNutritionValuesModel originalValues,
  ) {
    final recalculated = NutritionCalculatorService.recalculateFromMacroChange(
      changedMacro: _args.label,
      newMacroValue: newMacroValue,
      originalCalories: originalValues.calories,
      originalProtein: originalValues.protein,
      originalCarbs: originalValues.carbs,
      originalFats: originalValues.fats,
    );

    return CaloriesAndMacrosModel(
      calories: recalculated.calories,
      protein: recalculated.protein,
      carbs: recalculated.carbs,
      fats: recalculated.fats,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildHeader(), _buildContent(), _buildActions()],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final label = _args.label;

    return Column(
      children: [
        const AppBackButton(),
        verticalSpace(16),
        Center(
          child: OnboardingHeader(
            title: 'Edit Goal $label',
            subtitle: 'Adjust your daily $label goal',
          ),
        ),
        verticalSpace(24),
      ],
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        children: [
          GoalPreviewCard(args: _args, inputValue: _controller.text),
          verticalSpace(24),
          GoalInputField(
            controller: _controller,
            label: _args.label,
            onChanged: _onInputChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        EditGoalActionButtons(onRevert: _onRevert, onDone: _onDone),
        const KeyboardAwareSpacer(),
      ],
    );
  }

  void _onInputChanged() {
    setState(() {
      // Trigger rebuild to update preview card with new input value
    });
  }
}
