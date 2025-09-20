import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  googleSignIn() async {
    emit(AuthLoading());
    try {
      log('AuthCubit: Initiating Google Sign-In');
      await authRepo.googleSignIn();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  signOut() async {
    emit(AuthLoading());
    try {
      await authRepo.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
