import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../widgets/rollover/calorie_card.dart';
import '../widgets/rollover/rollover_progress_bar.dart';

class RolloverExtraCalScreen extends StatefulWidget {
  const RolloverExtraCalScreen({super.key});

  @override
  State<RolloverExtraCalScreen> createState() => _RolloverExtraCalScreenState();
}

class _RolloverExtraCalScreenState extends State<RolloverExtraCalScreen> {
  bool? rolloverChoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1D1D1F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // Progress bar
              const RolloverProgressBar(progress: 0.8),

              SizedBox(height: 40.h),

              // Main question
              Text(
                'Rollover extra calories to the next day?',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1D1D1F),
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16.h),

              // Rollover limit badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Rollover up to 200 cals',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF86868B),
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // Calorie cards
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: const CalorieCard(
                        day: 'Yesterday',
                        consumed: 350,
                        goal: 500,
                        caloriesLeft: 150,
                        isToday: false,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: const CalorieCard(
                        day: 'Today',
                        consumed: 350,
                        goal: 650,
                        caloriesLeft: 300,
                        rolloverAmount: 150,
                        isToday: true,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      text: 'No',
                      onPressed: () => _handleChoice(false),
                      isSelected: rolloverChoice == false,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildActionButton(
                      text: 'Yes',
                      onPressed: () => _handleChoice(true),
                      isSelected: rolloverChoice == true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required bool isSelected,
  }) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1D1D1F) : const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28.r),
          onTap: () {
            HapticFeedback.lightImpact();
            onPressed();
          },
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF1D1D1F),
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleChoice(bool choice) {
    setState(() {
      rolloverChoice = choice;
    });

    // Navigate to next screen after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      // TODO: Navigate to results screen
      context.pushNamed(Routes.recommendedDailyCalAndMacrosScreen);
    });
  }
}
