import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String svgAsset;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    required this.svgAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: SvgPicture.asset(
            svgAsset,
            width: 14.w,
            height: 14.h,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
        horizontalSpace(8),
        Text(label, style: AppTextStyles.font12MediumGrey600),
      ],
    );
  }
}
