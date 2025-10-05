import 'package:flutter/material.dart';

class CustomSnackbar {
  CustomSnackbar._();

  static void showSuccess(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    );
  }

  static void showError(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    );
  }

  static void showInfo(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 2),
    );
  }

  static void showWarning(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 2),
    );
  }

  static void _show({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Duration duration,
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }
}
