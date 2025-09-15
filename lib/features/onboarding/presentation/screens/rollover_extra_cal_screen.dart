import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/rollover/rollover_info_badge.dart';
import '../widgets/rollover/rollover_day_card.dart';
import '../widgets/rollover/rollover_action_buttons.dart';
import '../../data/models/user_informations_model.dart';

class RolloverExtraCalScreen extends StatelessWidget {
  const RolloverExtraCalScreen({super.key, this.userInfo});

  final UserInformationsModel? userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgressHeader(progress: 9 / 13),
              verticalSpace(24),

              const OnboardingHeader(
                title: 'Rollover Extra Calories',
                subtitle:
                    'Would you like to rollover your extra calories to the next day?',
              ),

              verticalSpace(12),
              const RolloverInfoBadge(limitCals: 200),

              const Spacer(),

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
                  final userInfo = this.userInfo?.copyWith(
                    rolloverCalories: false,
                  );
                  log('Rollover Calories: ${userInfo?.rolloverCalories}');
                  context.pushNamed(
                    Routes.resultLoadingScreen,
                    arguments: userInfo,
                  );
                },
                onYesPressed: () {
                  final userInfo = this.userInfo?.copyWith(
                    rolloverCalories: true,
                  );
                  log('Rollover Calories: ${userInfo?.rolloverCalories}');
                  context.pushNamed(
                    Routes.generatePlanScreen,
                    arguments: userInfo,
                  );
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
