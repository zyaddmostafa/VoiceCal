import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';
import '../theme/app_design_system.dart';

class CustomAppButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final String text;

  const CustomAppButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.text = 'Continue',
  });

  @override
  State<CustomAppButton> createState() => _CustomAppButtonState();
}

class _CustomAppButtonState extends State<CustomAppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppDesignSystem.animationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppDesignSystem.curveSmooth,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.isEnabled) {
      setState(() => _isPressed = true);
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _resetButton();
  }

  void _handleTapCancel() {
    _resetButton();
  }

  void _resetButton() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedOpacity(
            duration: AppDesignSystem.animationNormal,
            opacity: widget.isEnabled ? 1.0 : 0.5,
            child: GestureDetector(
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              onTap: widget.isEnabled ? widget.onPressed : null,
              child: Container(
                width: double.infinity,
                height: 56.h,
                decoration: widget.isEnabled
                    ? AppDesignSystem.primaryButton
                    : AppDesignSystem.tertiaryButton.copyWith(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.backgroundTertiary,
                            AppColors.borderSecondary,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowLight,
                            blurRadius: 8,
                            offset: Offset(0, 2.h),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: widget.isEnabled
                          ? Colors.white
                          : AppColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
