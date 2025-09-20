import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  googleSignIn() async {
    emit(AuthLoading());
    final result = await authRepo.googleSignIn();
    result.when(
      onSuccess: (_) {
        emit(AuthSuccess());
      },
      onError: (error) {
        emit(AuthError(error: error.message));
      },
    );
  }

  signOut() async {
    emit(AuthLoading());
    final result = await authRepo.signOut();
    result.when(
      onSuccess: (_) {
        emit(AuthSuccess());
      },
      onError: (error) {
        emit(AuthError(error: error.message));
      },
    );
  }
}
