import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/helpers/spacing.dart';
import '../widgets/edit_goal/edit_goal_args.dart';
import '../widgets/edit_goal/edit_goal_header.dart';
import '../widgets/edit_goal/goal_preview_card.dart';
import '../widgets/edit_goal/goal_input_field.dart';
import '../widgets/edit_goal/edit_goal_action_buttons.dart';
import '../widgets/edit_goal/number_formatter.dart';
import '../widgets/edit_goal/keyboard_aware_spacer.dart';

class EditGoalScreen extends StatefulWidget {
  final EditGoalArgs? editRecommendedPlan;
  const EditGoalScreen({super.key, this.editRecommendedPlan});

  @override
  State<EditGoalScreen> createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  late final TextEditingController _controller;
  late final EditGoalArgs _args;
  late final int _initialValue;

  @override
  void initState() {
    super.initState();
    _args = widget.editRecommendedPlan ?? _getDefaultArgs();
    _initialValue = _args.value;
    _controller = TextEditingController(
      text: NumberFormatter.format(_args.value),
    );
  }

  EditGoalArgs _getDefaultArgs() {
    return const EditGoalArgs(
      label: 'Calories',
      unit: '',
      value: 2000,
      progress: 0.6,
      ringColor: Color(0xFF1D1D1F),
      icon: Icons.local_fire_department,
    );
  }

  void _onRevert() {
    _controller.text = NumberFormatter.format(_initialValue);
    setState(() {
      // Trigger rebuild to update preview card with reverted value
    });
  }

  void _onDone() {
    Navigator.of(context).pop(NumberFormatter.parse(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBackButton(),
                verticalSpace(16),
                EditGoalHeader(label: _args.label),
                verticalSpace(24),
                GoalPreviewCard(args: _args, inputValue: _controller.text),
                verticalSpace(24),
                GoalInputField(
                  controller: _controller,
                  label: _args.label,
                  onChanged: () => setState(() {
                    // Trigger rebuild to update preview card with new input
                  }),
                ),
                EditGoalActionButtons(onRevert: _onRevert, onDone: _onDone),
                const KeyboardAwareSpacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
