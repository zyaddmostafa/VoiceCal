import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeyboardAwareSpacer extends StatelessWidget {
  final double baseHeight;

  const KeyboardAwareSpacer({super.key, this.baseHeight = 16.0});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;

    return SizedBox(
      height: isKeyboardVisible ? keyboardHeight + baseHeight.h : baseHeight.h,
    );
  }
}
