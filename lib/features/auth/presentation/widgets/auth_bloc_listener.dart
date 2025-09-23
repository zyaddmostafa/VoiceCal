import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/service/user_local_service.dart';
import '../../../onboarding/data/models/user_informations_model.dart';
import '../cubit/auth_cubit.dart';

class AuthBlocListener extends StatelessWidget {
  final UserInformationsModel? userInfo;
  const AuthBlocListener({super.key, this.userInfo});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLoading():
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CupertinoActivityIndicator()),
            );
            break;

          case AuthSuccess():
            _dismissLoadingDialog(context);
            UserLocalService.addUserInfo(userInfo!);
            context.pushNamedAndRemoveUntil(
              Routes.homeScreen,
              predicate: (Route<dynamic> route) => false,
            );

            break;

          case AuthError():
            _dismissLoadingDialog(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
            break;
          default:
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _dismissLoadingDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
