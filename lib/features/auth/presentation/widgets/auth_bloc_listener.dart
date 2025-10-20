import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/config/config_constants.dart';
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
      listener: (context, state) async {
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

            final box = Hive.box(ConfigConstants.userProfileBox);
            box.put('userProfile', state.userProfile);

            UserLocalService.addUserInfo(userInfo!);
            context.pushNamedAndRemoveUntil(
              Routes.mainNavigation,
              predicate: (Route<dynamic> route) => false,
            );

            break;

          case AuthSignOutSuccess():
            _dismissLoadingDialog(context);

            final box = Hive.box(ConfigConstants.userProfileBox);
            await box.delete('userProfile');

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
