import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartToggleWidget extends StatelessWidget {
  final bool showBarChart;
  final Function(bool) onToggleChart;

  const ChartToggleWidget({
    super.key,
    required this.showBarChart,
    required this.onToggleChart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleButton(
            icon: Icons.bar_chart,
            isSelected: showBarChart,
            onTap: () => onToggleChart(true),
          ),
          SizedBox(width: 4.w),
          _ToggleButton(
            icon: Icons.pie_chart,
            isSelected: !showBarChart,
            onTap: () => onToggleChart(false),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  static final _padding = EdgeInsets.all(8.r);
  static final _borderRadius = BorderRadius.circular(8.r);

  const _ToggleButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: _padding,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: _borderRadius,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey[600],
        ),
      ),
    );
  }
}
