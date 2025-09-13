import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';

class LoadingTaskDisplay extends StatelessWidget {
  final String task;
  final bool isComplete;

  const LoadingTaskDisplay({
    super.key,
    required this.task,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      task,
      style: AppTextStyles.font16MediumSuccess(isComplete: isComplete),
      textAlign: TextAlign.center,
    );
  }
}
