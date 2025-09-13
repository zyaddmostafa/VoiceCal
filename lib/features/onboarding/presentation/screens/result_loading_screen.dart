import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/routes.dart';
import '../../data/models/user_informations_model.dart';
import '../widgets/result_loading/loading_progress_bar.dart';
import '../widgets/result_loading/loading_percentage_display.dart';
import '../widgets/result_loading/loading_task_display.dart';
import '../widgets/result_loading/loading_recommendations_card.dart';

class ResultLoadingScreen extends StatefulWidget {
  final UserInformationsModel? userInfo;
  const ResultLoadingScreen({super.key, this.userInfo});

  @override
  State<ResultLoadingScreen> createState() => _ResultLoadingScreenState();
}

class _ResultLoadingScreenState extends State<ResultLoadingScreen> {
  Timer? _timer;
  int _currentProgress = 0;
  int _currentTaskIndex = 0;
  final List<bool> _completedItems = [false, false, false, false];

  final List<String> _tasks = [
    'Applying BMR formula...',
    'Calculating daily calories...',
    'Estimating your metabolic rate...',
    'Computing macro ratios...',
    'Finalizing your plan...',
  ];

  final List<String> _recommendationItems = [
    'Calories',
    'Carbs',
    'Protein',
    'Fats',
  ];

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLoading() {
    _animateToProgress(25, 0); // Start with first item
  }

  void _animateToProgress(int targetProgress, int itemIndex) {
    if (targetProgress > 100) {
      // Navigate to result plan screen when complete
      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            Routes.resultPlan,
            arguments: widget.userInfo,
          );
        }
      });
      return; // Exit the function to avoid starting another timer
    }

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_currentProgress < targetProgress) {
        setState(() {
          _currentProgress += 1;
        });
      } else {
        timer.cancel();
        // Mark current item as completed and move to next
        setState(() {
          if (itemIndex < _completedItems.length) {
            _completedItems[itemIndex] = true;
          }
          if (itemIndex < _tasks.length - 1) {
            _currentTaskIndex = itemIndex + 1;
          }
        });

        // Wait a moment then animate to next 25%
        Future.delayed(const Duration(milliseconds: 200), () {
          _animateToProgress(targetProgress + 25, itemIndex + 1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(),

              // Percentage display
              LoadingPercentageDisplay(percentage: _currentProgress),
              verticalSpace(8),

              // Loading message
              Text(
                "We're setting everything up for you",
                style: AppTextStyles.font30SemiBoldPrimary,
                textAlign: TextAlign.center,
              ),
              verticalSpace(24),

              // Progress bar
              LoadingProgressBar(progress: _currentProgress / 100),
              verticalSpace(16),

              // Current task
              LoadingTaskDisplay(
                task: _tasks[_currentTaskIndex],
                isComplete: _currentProgress >= 100,
              ),
              verticalSpace(40),
              // Recommendations card
              LoadingRecommendationsCard(
                items: _recommendationItems,
                completedItems: _completedItems,
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
