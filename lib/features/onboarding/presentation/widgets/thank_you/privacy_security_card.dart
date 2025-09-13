import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class PrivacySecurityCard extends StatelessWidget {
  const PrivacySecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none, // Allow overflow for positioned elements
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              margin: EdgeInsets.only(
                top: 30.h,
              ), // Add top margin for the icon space
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Text(
                    'Your privacy and security matter to us.',
                    style: AppTextStyles.font16MediumBlack,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(8),
                  Text(
                    'We promise to always keep your personal information private and secure.',
                    style: AppTextStyles.font14RegularSecondary,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0, // Position at the top edge of the container
              left: MediaQuery.of(context).size.width / 2 - 20.w - 24.w,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lock_outline,
                  size: 25,
                  color: Color(0xFFF4C430),
                ),
              ),
            ),
          ],
        ),
        verticalSpace(8),
      ],
    );
  }
}
