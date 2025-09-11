import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';

class RolloverCaloriesExample extends StatelessWidget {
  const RolloverCaloriesExample({
    super.key,
    required this.extraFromRollover,
    required this.calsLeft,
  });

  final int? extraFromRollover;
  final int calsLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Text(
        extraFromRollover == null
            ? 'Cals left \n $calsLeft'
            : 'Cals left \n $calsLeft + $extraFromRollover',
        style: AppTextStyles.font12MediumWhite,
        textAlign: TextAlign.center,
      ),
    );
  }
}
