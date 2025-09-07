import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/rollover_calories/rollover_content.dart';

class RolloverExtraCalScreen extends StatefulWidget {
  const RolloverExtraCalScreen({super.key});

  @override
  State<RolloverExtraCalScreen> createState() => _RolloverExtraCalScreenState();
}

class _RolloverExtraCalScreenState extends State<RolloverExtraCalScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundPrimary,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: RolloverContent(
                onNoPressed: _handleNoPressed,
                onYesPressed: _handleYesPressed,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleNoPressed() {
    // Handle no rollover selection
    Navigator.of(context).pop();
  }

  void _handleYesPressed() {
    // Handle yes rollover selection
    Navigator.of(context).pop();
  }
}
