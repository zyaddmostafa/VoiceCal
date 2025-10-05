import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';

/// Empty state widget when no meals are logged
class EmptyMealsState extends StatelessWidget {
  const EmptyMealsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu_rounded,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          verticalSpace(16),
          Text(
            'No meals logged yet',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
          ),
          verticalSpace(8),
          Text(
            'Tap the microphone to log your first meal',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
