import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingProgressBar extends StatelessWidget {
  final double progress;

  const LoadingProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E5EA),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF3B30), Color(0xFF007AFF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}
