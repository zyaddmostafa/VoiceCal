import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeedMarkersRow extends StatelessWidget {
  final String left;
  final String middle;
  final String right;
  const SpeedMarkersRow({
    super.key,
    this.left = '0.2 lbs',
    this.middle = '1.5 lbs',
    this.right = '3.0 lbs',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_label(left), _label(middle), _label(right)],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        color: const Color(0xFF2C2C2E),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
