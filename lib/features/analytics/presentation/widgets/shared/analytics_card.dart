import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';

/// Reusable card component for analytics widgets
class AnalyticsCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? borderRadius;

  const AnalyticsCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 4),
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Reusable section header component
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? action;
  final double? fontSize;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: fontSize != null
              ? TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                )
              : AppTextStyles.font16SemiBoldBlack87,
        ),
        if (action != null) action!,
      ],
    );
  }
}
