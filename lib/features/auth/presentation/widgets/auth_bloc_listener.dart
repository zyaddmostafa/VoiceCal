import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';

class AuthBlocListener extends StatelessWidget {
  const AuthBlocListener({super.key});

  void _dismissLoadingDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLoading():
            // Show loading dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CupertinoActivityIndicator()),
            );
            break;

          case AuthSuccess():
            // Dismiss loading dialog and navigate
            _dismissLoadingDialog(context);
            Navigator.pushReplacementNamed(context, '/home');
            break;

          case AuthError():
            // Dismiss loading dialog and show error
            _dismissLoadingDialog(context);

            // Show user-friendly error message
            String userMessage = _getUserFriendlyMessage(state.error);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(userMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
            break;

          case AuthInitial():
            // Initial state - do nothing
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  String _getUserFriendlyMessage(String error) {
    if (error.contains('canceled by user')) {
      return 'Sign-in cancelled. Please try again.';
    } else if (error.contains('configuration error')) {
      return 'Sign-in setup issue. Please contact support.';
    } else if (error.contains('interrupted')) {
      return 'Sign-in was interrupted. Please try again.';
    } else {
      return 'Sign-in failed. Please try again.';
    }
  }
}
