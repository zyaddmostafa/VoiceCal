import 'package:flutter/cupertino.dart';
import '../../../../../core/theme/app_colors.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 0.5, color: AppColors.border);
  }
}
