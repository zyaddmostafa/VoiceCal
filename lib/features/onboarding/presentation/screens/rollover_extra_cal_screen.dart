import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/rollover/rollover_info_badge.dart';
import '../widgets/rollover/rollover_day_card.dart';
import '../widgets/rollover/rollover_action_buttons.dart';

class RolloverExtraCalScreen extends StatelessWidget {
  const RolloverExtraCalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgressHeader(progress: 9 / 10),
              verticalSpace(24),

              Text(
                'Rollover extra\ncalories to the next\nday?',
                style: TextStyle(
                  fontSize: 34.sp,
                  height: 1.12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),

              verticalSpace(12),
              const RolloverInfoBadge(limitCals: 200),

              const Spacer(),

              // Cards row
              Row(
                children: [
                  const Expanded(
                    child: RolloverDayCard(
                      dayLabel: 'Yesterday',
                      headerColor: Color(0xFFFFE9E9),
                      consumed: 350,
                      goal: 500,
                      calsLeft: 150,
                    ),
                  ),
                  horizontalSpace(16),
                  const Expanded(
                    child: RolloverDayCard(
                      dayLabel: 'Today',
                      headerColor: Color(0xFFEDEDEF),
                      consumed: 350,
                      goal: 650,
                      calsLeft: 300,
                      extraFromRollover: 150,
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 2),

              RolloverActionButtons(
                onNoPressed: () {
                  // Handle "No" - don't rollover calories
                  context.pushNamed(Routes.recommendedDailyCalAndMacrosScreen);
                },
                onYesPressed: () {
                  // Handle "Yes" - rollover calories
                  context.pushNamed(Routes.recommendedDailyCalAndMacrosScreen);
                },
              ),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
