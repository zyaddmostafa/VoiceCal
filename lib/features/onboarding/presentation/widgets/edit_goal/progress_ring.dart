import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final Color color;
  final IconData icon;

  const ProgressRing({
    super.key,
    required this.progress,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const ringSize = 64.0;

    return SizedBox(
      width: ringSize.w,
      height: ringSize.h,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF2F2F7),
            ),
          ),
          SizedBox(
            width: ringSize.w,
            height: ringSize.h,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 6.w,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Center(child: Icon(icon, size: 20, color: const Color(0xFF1D1D1F))),
        ],
      ),
    );
  }
}
