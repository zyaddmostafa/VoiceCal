import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/data/models/meal_data.dart';
import '../cubit/edit_meal_cubit.dart';
import '../widgets/bottom_actions.dart';
import '../widgets/calories_card.dart';
import '../widgets/ingredients_section.dart';
import '../widgets/macros_row.dart';
import '../widgets/meal_header.dart';
import '../widgets/regenerate_bottom_sheet.dart';

class EditMealScreen extends StatefulWidget {
  final String? mealId; // Optional meal ID to edit existing meal

  const EditMealScreen({super.key, this.mealId});

  @override
  State<EditMealScreen> createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  late String _mealName;
  late int _mealQuantity;
  late List<Ingredient> _ingredients;

  // Base values (for quantity = 1)
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
    // Dummy data for demonstration (will be replaced by actual data from cubit)
    _mealName = 'Chicken and Egg Fried Rice Plate';
    _mealQuantity = 1;

    // Base values for 1 serving
    _baseCalories = 618;
    _baseProtein = 51;
    _baseCarbs = 55;
    _baseFats = 18;

    // Dummy ingredients
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

  void _updateFromMealData(MealData mealData) {
    setState(() {
      _mealName = mealData.mealName;
      _mealQuantity = 1; // Reset to 1 when loading new data

      // Set base values from the loaded meal data
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

  void _showRegenerateDialog() {
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

  void _showQuantityDialog() {
    final TextEditingController quantityController = TextEditingController(
      text: _mealQuantity.toString(),
    );

    showDialog(
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
                      setState(() {
                        _mealQuantity = quantity;
                      });
                      Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditMealCubit, EditMealState>(
      listener: (context, state) {
        if (state is EditMealSuccess) {
          _updateFromMealData(state.mealData);
        } else if (state is EditMealError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.apiErrorModel.message ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundSecondary,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: AppColors.textPrimary,
            ),
          ),
          title: Text(
            TimeOfDay.now().format(context),
            style: AppTextStyles.font14RegularSecondary,
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<EditMealCubit, EditMealState>(
          builder: (context, state) {
            if (state is EditMealLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 0,
                      bottom: 100.h, // Space for bottom buttons
                    ),
                    children: [
                      MealHeader(
                        mealName: _mealName,
                        mealQuantity: _mealQuantity.toString(),
                        onQuantityTap: _showQuantityDialog,
                        onRemove: () {
                          // TODO: Implement meal deletion
                          Navigator.of(context).pop();
                        },
                      ),
                      verticalSpace(24),
                      CaloriesCard(calories: _calories),
                      verticalSpace(16),
                      MacrosRow(protein: _protein, carbs: _carbs, fats: _fats),
                      verticalSpace(24),
                      IngredientsSection(ingredients: _ingredients),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomActions(
                    onFixResults: _showRegenerateDialog,
                    onDone: _saveChanges,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
