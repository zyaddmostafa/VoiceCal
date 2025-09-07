import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable unit toggle widget for switching between metric and imperial units
class UnitToggle extends StatelessWidget {
  final bool isMetric;
  final ValueChanged<bool> onToggle;

  const UnitToggle({super.key, required this.isMetric, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleOption(
            text: 'Metric',
            isSelected: isMetric,
            onTap: () => onToggle(true),
          ),
          _ToggleOption(
            text: 'Imperial',
            isSelected: !isMetric,
            onTap: () => onToggle(false),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleOption({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? const Color(0xFF007AFF)
                : const Color(0xFF8E8E93),
          ),
        ),
      ),
    );
  }
}
