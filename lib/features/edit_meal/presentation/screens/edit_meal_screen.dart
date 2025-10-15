import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/custom_snackbar.dart';
import '../../../../core/helpers/quantity_dialog_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/data/models/meal_data.dart';
import '../cubit/edit_meal_cubit.dart';
import '../widgets/edit_meal_bloc_builder.dart';
import '../widgets/regenerate_bottom_sheet.dart';

class EditMealScreen extends StatefulWidget {
  final String? mealId;

  const EditMealScreen({super.key, this.mealId});

  @override
  State<EditMealScreen> createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  late String _mealName;
  late int _mealQuantity;
  late List<Ingredient> _ingredients;

  late double _baseCalories;
  late double _baseProtein;
  late double _baseCarbs;
  late double _baseFats;

  // Calculated values based on quantity
  String get _calories => (_baseCalories * _mealQuantity).toStringAsFixed(0);
  String get _protein => (_baseProtein * _mealQuantity).toStringAsFixed(0);
  String get _carbs => (_baseCarbs * _mealQuantity).toStringAsFixed(0);
  String get _fats => (_baseFats * _mealQuantity).toStringAsFixed(0);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _mealName = 'Chicken and Egg Fried Rice Plate';
    _mealQuantity = 1;

    _baseCalories = 618;
    _baseProtein = 51;
    _baseCarbs = 55;
    _baseFats = 18;

    _ingredients = [
      Ingredient(
        name: 'Chicken Breast',
        quantity: '150g',
        calories: 292,
        protein: 30,
        carbs: 0,
        fats: 5,
      ),
      Ingredient(
        name: 'Egg Fried Rice',
        quantity: '1 cup',
        calories: 270,
        protein: 8,
        carbs: 40,
        fats: 10,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditMealCubit, EditMealState>(
      listener: (context, state) {
        if (state is EditMealSuccess) {
          _updateFromMealData(state.mealData);
        } else if (state is EditMealError) {
          CustomSnackbar.showError(
            context,
            state.apiErrorModel.message ?? 'An error occurred',
          );
        }
      },
      child: CupertinoPageScaffold(
        backgroundColor: AppColors.backgroundSecondary,
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            TimeOfDay.now().format(context),
            style: AppTextStyles.font14RegularSecondary,
          ),
          backgroundColor: AppColors.backgroundSecondary,
          border: null,
        ),
        child: SafeArea(
          child: EditMealBlocBuilder(
            formKey: _formKey,
            mealName: _mealName,
            mealQuantity: _mealQuantity.toString(),
            calories: _calories,
            protein: _protein,
            carbs: _carbs,
            fats: _fats,
            ingredients: _ingredients,
            onQuantityTap: _showQuantityDialog,
            onRemove: () {
              Navigator.of(context).pop();
            },
            onFixResults: _showRegenerateBottomSheet,
            onDone: _saveChanges,
          ),
        ),
      ),
    );
  }

  void _updateFromMealData(MealData mealData) {
    setState(() {
      _mealName = mealData.mealName;
      _mealQuantity = 1;

      _baseCalories = mealData.totalCalories;
      _baseProtein = mealData.totalProtein;
      _baseCarbs = mealData.totalCarbs;
      _baseFats = mealData.totalFats;
      _ingredients = mealData.ingredients;
    });
  }

  void _saveChanges() {
    Navigator.of(context).pop();
  }

  void _showRegenerateBottomSheet() {
    RegenerateBottomSheet.show(
      context,
      onRegenerate: (description) {
        if (widget.mealId != null && description.isNotEmpty) {
          context.read<EditMealCubit>().editMeal(
            mealId: widget.mealId!,
            mealText: description,
          );
        }
      },
    );
  }

  void _showQuantityDialog() async {
    final quantity = await QuantityDialogHelper.show(
      context,
      currentQuantity: _mealQuantity,
    );

    if (quantity != null) {
      setState(() {
        _mealQuantity = quantity;
      });
    }
  }
}
