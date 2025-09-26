import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NutritionLegendWidget extends StatelessWidget {
  const NutritionLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LegendItemWidget(
          color: Color(0xFFFF6B6B),
          label: 'Protein',
          icon: Icons.fitness_center,
        ),
        LegendItemWidget(
          color: Color(0xFF4ECDC4),
          label: 'Carbs',
          icon: Icons.grain,
        ),
        LegendItemWidget(
          color: Color(0xFFFFBE0B),
          label: 'Fats',
          icon: Icons.water_drop,
        ),
      ],
    );
  }
}

class LegendItemWidget extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  const LegendItemWidget({
    super.key,
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: color, size: 14.sp),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
