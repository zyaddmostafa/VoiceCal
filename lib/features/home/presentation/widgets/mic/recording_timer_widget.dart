import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class RecordingTimerWidget extends StatefulWidget {
  final bool isRecording;
  final int maxDuration; // in seconds

  const RecordingTimerWidget({
    super.key,
    required this.isRecording,
    this.maxDuration = 30,
  });

  @override
  State<RecordingTimerWidget> createState() => _RecordingTimerWidgetState();
}

class _RecordingTimerWidgetState extends State<RecordingTimerWidget> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isRecording) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(RecordingTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording && !oldWidget.isRecording) {
      _startTimer();
    } else if (!widget.isRecording && oldWidget.isRecording) {
      _stopTimer();
    }
  }

  void _startTimer() {
    _seconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _seconds = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;

    return '${minutes.toString().padLeft(1, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _formatMaxTime() {
    final minutes = widget.maxDuration ~/ 60;
    final secs = widget.maxDuration % 60;

    return '${minutes.toString().padLeft(1, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isRecording) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlack.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Recording indicator dot
          Container(
            width: 6.w,
            height: 6.w,
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10.w),
          // Timer text
          Text(
            '${_formatTime(_seconds)} / ${_formatMaxTime()}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(width: 10.w),
          // "FREE" or status text (optional)
          Text(
            'FREE',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
