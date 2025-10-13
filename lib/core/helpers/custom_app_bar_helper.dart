import 'package:flutter/material.dart';

class CustomAppBarHelper {
  static PreferredSizeWidget build({
    required BuildContext context,
    required Widget child,
    VoidCallback? onBackPressed,
    bool centerTitle = false,
  }) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: const BackButton(),
      ),
      title: child,
      centerTitle: centerTitle,
    );
  }
}
