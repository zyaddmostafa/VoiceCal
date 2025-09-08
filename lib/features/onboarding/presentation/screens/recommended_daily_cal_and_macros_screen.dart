import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../widgets/daily_recommendation/goal_bubble.dart';
import '../widgets/daily_recommendation/macro_card.dart';
import '../widgets/onboarding_progress_header.dart';

class RecommendedDailyCalAndMacrosScreen extends StatefulWidget {
  const RecommendedDailyCalAndMacrosScreen({super.key});

  @override
  State<RecommendedDailyCalAndMacrosScreen> createState() =>
      _RecommendedDailyCalAndMacrosScreenState();
}

class _RecommendedDailyCalAndMacrosScreenState
    extends State<RecommendedDailyCalAndMacrosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 1),
              verticalSpace(12),
              // Goal bubble
              const GoalBubble(goal: '15 lbs by March 27, 2026'),

              verticalSpace(24),
              // Main title
              Text(
                'Your Custom Daily\nCalories & Macros Plan',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1D1D1F),
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Text(
                'You can edit this anytime',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF86868B),
                  height: 1.4,
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40.h),

              // Macro cards grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: const [
                    MacroCard(
                      icon: Icons.local_fire_department,
                      label: 'Calories',
                      value: '1712',
                      progress: 0.6,
                      progressColor: Color(0xFF1D1D1F),
                    ),
                    MacroCard(
                      icon: Icons.grain,
                      label: 'Carbs',
                      value: '212g',
                      progress: 0.7,
                      progressColor: Color(0xFFFF9500),
                    ),
                    MacroCard(
                      icon: Icons.restaurant,
                      label: 'Protein',
                      value: '108g',
                      progress: 0.5,
                      progressColor: Color(0xFFFF3B30),
                    ),
                    MacroCard(
                      icon: Icons.opacity,
                      label: 'Fats',
                      value: '47g',
                      progress: 0.4,
                      progressColor: Color(0xFF007AFF),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Let's get started button
              Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1D1F),
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28.r),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _handleGetStarted();
                    },
                    child: Center(
                      child: Text(
                        'Let\'s get started!',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  void _handleGetStarted() {
    // TODO: Navigate to home screen or next flow
    context.pushNamed(Routes.editGoalScreen);
    print('Let\'s get started tapped');
  }
}
