import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import 'goal_content.dart';
import 'progress_circle.dart';

class GoalItem extends StatefulWidget {
  const GoalItem({
    super.key,
    required this.title,
    required this.value,
    required this.progressColor,
    required this.icon,
    required this.progressPercentage,
    this.onValueChanged,
  });

  final String title;
  final String value;
  final Color progressColor;
  final IconData icon;
  final double progressPercentage;
  final ValueChanged<String>? onValueChanged;

  @override
  State<GoalItem> createState() => _GoalItemState();
}

class _GoalItemState extends State<GoalItem> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode()..addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(GoalItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update controller only if value changed and we're not currently editing
    if (widget.value != oldWidget.value && !_isEditing) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    // Save value when focus is lost during editing
    if (!_focusNode.hasFocus && _isEditing) {
      _saveAndFinishEditing();
    }
  }

  void _saveAndFinishEditing() {
    final newValue = _controller.text.trim();

    setState(() => _isEditing = false);

    // Validate and notify parent or revert to original value
    if (newValue.isEmpty || newValue == widget.value) {
      _controller.text = widget.value; // Revert to original
    } else {
      widget.onValueChanged?.call(newValue); // Save new value
    }
  }

  void _startEditing() {
    setState(() => _isEditing = true);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isEditing ? null : _startEditing,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(18.r),
          border: const Border.fromBorderSide(
            BorderSide(color: AppColors.borderLight, width: 1),
          ),
        ),
        child: Row(
          children: [
            ProgressCircle(
              diameter: 56.w,
              icon: widget.icon,
              color: widget.progressColor,
              percentage: widget.progressPercentage,
            ),
            horizontalSpace(16),
            Expanded(
              child: GoalContent(
                title: widget.title,
                value: widget.value,
                isEditing: _isEditing,
                controller: _controller,
                focusNode: _focusNode,
                progressColor: widget.progressColor,
                labelSpacing: 6.h,
                onSubmitted: _saveAndFinishEditing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
