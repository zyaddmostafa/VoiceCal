import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_text_styles.dart';

/// Reusable unit toggle widget for switching between metric and imperial units
class UnitToggle extends StatelessWidget {
  final bool isMetric;
  final ValueChanged<bool> onToggle;

  const UnitToggle({super.key, required this.isMetric, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F7),
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          text,
          style: AppTextStyles.font16MediumConditional(isSelected: isSelected),
        ),
      ),
    );
  }
}
