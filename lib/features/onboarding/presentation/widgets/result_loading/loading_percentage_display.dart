import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';

class LoadingPercentageDisplay extends StatelessWidget {
  final int percentage;

  const LoadingPercentageDisplay({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Text('$percentage%', style: AppTextStyles.font48ExtraBoldPrimary);
  }
}
