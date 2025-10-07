import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class MicButtonWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isRecording;

  const MicButtonWidget({super.key, this.onPressed, this.isRecording = false});

  @override
  State<MicButtonWidget> createState() => _MicButtonWidgetState();
}

class _MicButtonWidgetState extends State<MicButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.isRecording) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(MicButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording && !oldWidget.isRecording) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isRecording && oldWidget.isRecording) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isRecording
                  ? AppColors.error
                  : AppColors.primaryBlack,
              boxShadow: [
                BoxShadow(
                  color: widget.isRecording
                      ? AppColors.error.withValues(alpha: 0.3)
                      : AppColors.primaryBlack.withValues(alpha: 0.2),
                  blurRadius: widget.isRecording ? 16 : 10,
                  spreadRadius: widget.isRecording
                      ? (_pulseAnimation.value - 1) * 6
                      : 0,
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: widget.isRecording
                    ? Container(
                        key: const ValueKey('stop'),
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      )
                    : Icon(
                        key: const ValueKey('mic'),
                        Icons.mic,
                        color: Colors.white,
                        size: 26.sp,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
