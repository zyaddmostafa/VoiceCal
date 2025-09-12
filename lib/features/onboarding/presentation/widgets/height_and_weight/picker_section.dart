import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

/// Reusable picker section widget with title and container styling
class PickerSection extends StatelessWidget {
  final String title;
  final Widget child;

  const PickerSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.r);

    return Column(
      children: [
        Text(title, style: AppTextStyles.font18MediumBlack),
        verticalSpace(16),
        Container(
          height: 200.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(borderRadius: borderRadius, child: child),
        ),
      ],
    );
  }
}
