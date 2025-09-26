import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chart_toggle_widget.dart';
import 'nutrition_bar_chart_widget.dart';
import 'nutrition_pie_chart_widget.dart';
import 'nutrition_totals_widget.dart';
import 'nutrition_legend_widget.dart';
import '../../data/models/daily_nutrition.dart';

class NutritionChartWidget extends StatefulWidget {
  final List<DailyNutrition> nutritionData;

  const NutritionChartWidget({super.key, required this.nutritionData});

  @override
  State<NutritionChartWidget> createState() => _NutritionChartWidgetState();
}

class _NutritionChartWidgetState extends State<NutritionChartWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showBarChart = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.pie_chart,
                  color: const Color(0xFF8B5CF6),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Nutrition Breakdown',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              ChartToggleWidget(
                showBarChart: _showBarChart,
                onToggleChart: _toggleChart,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return SizedBox(
                height: 280.h,
                child: _showBarChart
                    ? NutritionBarChartWidget(
                        nutritionData: widget.nutritionData,
                      )
                    : NutritionPieChartWidget(
                        nutritionData: widget.nutritionData,
                      ),
              );
            },
          ),
          SizedBox(height: 20.h),
          NutritionLegendWidget(showBarChart: _showBarChart),
          SizedBox(height: 16.h),
          NutritionTotalsWidget(nutritionData: widget.nutritionData),
        ],
      ),
    );
  }

  void _toggleChart(bool showBarChart) {
    setState(() {
      _showBarChart = showBarChart;
    });
    _animationController.reset();
    _animationController.forward();
  }
}
