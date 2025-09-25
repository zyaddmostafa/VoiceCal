import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/helpers/spacing.dart';
import '../widgets/today_info_card.dart';
import '../widgets/calories_card.dart';
import '../widgets/macronutrients_card.dart';
import '../widgets/meals_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    verticalSpace(20),
                    const TodayInfoCard(),
                    verticalSpace(16),
                    const CaloriesCard(consumed: 1450, goal: 2000),
                    verticalSpace(16),
                    const MacronutrientsCard(),
                    verticalSpace(16),
                    const Expanded(child: MealsSection()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
