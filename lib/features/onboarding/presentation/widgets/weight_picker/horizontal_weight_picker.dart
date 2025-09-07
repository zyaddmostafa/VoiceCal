import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Horizontal weight picker with ruler-style scrolling
class HorizontalWeightPicker extends StatefulWidget {
  final int initialWeight;
  final int minWeight;
  final int maxWeight;
  final String unit;
  final ValueChanged<int> onWeightChanged;

  const HorizontalWeightPicker({
    super.key,
    required this.initialWeight,
    required this.minWeight,
    required this.maxWeight,
    required this.unit,
    required this.onWeightChanged,
  });

  @override
  State<HorizontalWeightPicker> createState() => _HorizontalWeightPickerState();
}

class _HorizontalWeightPickerState extends State<HorizontalWeightPicker> {
  late ScrollController _scrollController;
  late int _selectedWeight;

  @override
  void initState() {
    super.initState();
    _selectedWeight = widget.initialWeight;

    // Initialize scroll position to show the initial weight
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Position scroll to center the initial weight
      final position =
          (_selectedWeight - widget.minWeight) * 10.0; // 10 pixels per kg
      _scrollController.jumpTo(position);
    });

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final rulerHeight = 60.h;
    final markSpacing = 10.w;

    return Container(
      height: 80.h,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background
          Container(
            height: rulerHeight,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),

          // Ruler marks
          SizedBox(
            height: rulerHeight,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  final offset = _scrollController.offset;
                  final newWeight =
                      widget.minWeight +
                      (offset / 10).round(); // 10 pixels per kg

                  if (newWeight != _selectedWeight &&
                      newWeight >= widget.minWeight &&
                      newWeight <= widget.maxWeight) {
                    setState(() {
                      _selectedWeight = newWeight;
                    });
                    HapticFeedback.lightImpact();
                    widget.onWeightChanged(newWeight);
                  }
                }
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 2 - 1),
                itemCount:
                    (widget.maxWeight - widget.minWeight) * 10 +
                    1, // 0.1 kg increments
                itemBuilder: (context, index) {
                  final weight = widget.minWeight + (index * 0.1);
                  final isMainMark = weight % 5 == 0; // Every 5 kg
                  final isSubMark = weight % 1 == 0; // Every 1 kg

                  final double markHeight;
                  final double markWidth;
                  final Color markColor;

                  if (isMainMark) {
                    markHeight = 30.h;
                    markWidth = 2.w;
                    markColor = AppColors.textSecondary;
                  } else if (isSubMark) {
                    markHeight = 20.h;
                    markWidth = 1.5.w;
                    markColor = AppColors.divider;
                  } else {
                    markHeight = 12.h;
                    markWidth = 1.w;
                    markColor = AppColors.divider.withValues(alpha: 0.6);
                  }

                  return SizedBox(
                    width: markSpacing, // 10 pixels spacing
                    height: rulerHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: markWidth,
                          height: markHeight,
                          decoration: BoxDecoration(
                            color: markColor,
                            borderRadius: BorderRadius.circular(markWidth / 2),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Center red indicator line
          Container(
            width: 3.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(1.5.r),
            ),
          ),
        ],
      ),
    );
  }
}
