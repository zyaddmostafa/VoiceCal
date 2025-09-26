import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/weight_entry.dart';

class WeightSummaryCardWidget extends StatelessWidget {
  final List<WeightEntry> weightData;

  const WeightSummaryCardWidget({super.key, required this.weightData});

  @override
  Widget build(BuildContext context) {
    if (weightData.isEmpty) return const SizedBox.shrink();

    final currentWeight = weightData.last.weight;
    final startWeight = weightData.first.weight;
    final goalWeight = startWeight - 5; // Example goal
    final progressPercentage =
        ((startWeight - currentWeight) / (startWeight - goalWeight) * 100)
            .clamp(0, 100);

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _WeightMetricColumn(
            label: 'Current',
            value: '${currentWeight.toStringAsFixed(1)} kg',
            isProgress: false,
          ),
          const _MetricDivider(),
          _WeightMetricColumn(
            label: 'Goal',
            value: '${goalWeight.toStringAsFixed(1)} kg',
            isProgress: false,
          ),
          const _MetricDivider(),
          _WeightMetricColumn(
            label: 'Progress',
            value: '${progressPercentage.toInt()}%',
            isProgress: true,
          ),
        ],
      ),
    );
  }
}

class _WeightMetricColumn extends StatelessWidget {
  final String label;
  final String value;
  final bool isProgress;

  const _WeightMetricColumn({
    required this.label,
    required this.value,
    required this.isProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isProgress ? const Color(0xFF6366F1) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricDivider extends StatelessWidget {
  const _MetricDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40.h, color: Colors.grey[300]);
  }
}
