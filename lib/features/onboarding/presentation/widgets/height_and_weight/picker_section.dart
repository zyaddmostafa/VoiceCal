import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1D1D1F),
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 16.h),
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
