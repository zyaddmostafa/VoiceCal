import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';

class SummaryItemWidget extends StatelessWidget {
  final String value;
  final String label;

  const SummaryItemWidget({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTextStyles.font18SemiBoldBlack87),
        Text(label, style: AppTextStyles.font12RegularGrey600),
      ],
    );
  }
}
