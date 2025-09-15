import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../data/models/user_informations_model.dart';
import '../widgets/onboarding_progress_header.dart';

class GeneratePlanScreen extends StatelessWidget {
  final UserInformationsModel? userInfo;

  const GeneratePlanScreen({super.key, this.userInfo});

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
            children: [
              const OnboardingProgressHeader(progress: 10 / 13),
              verticalSpace(40),

              const Spacer(),

              // Finger heart Lottie animation
              Container(
                padding: EdgeInsets.all(40.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFE5F1), Color(0xFFE5F1FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/Love hands.json',

                    fit: BoxFit.fill,
                    repeat: true,
                    animate: true,
                  ),
                ),
              ),

              verticalSpace(24),

              // "All done!" message with checkmark
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF9500),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 12.w),
                  ),
                  horizontalSpace(8),
                  Text('All done!', style: AppTextStyles.font16MediumBlack),
                ],
              ),

              verticalSpace(24),

              // Main title
              Text(
                'Time to generate your\ncustom plan!',
                style: AppTextStyles.font32ExtraBold.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              CustomAppButton(
                text: 'Continue',
                onPressed: () {
                  context.pushNamed(
                    Routes.resultLoadingScreen,
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
