part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}

final class AuthProfileLoading extends AuthState {}

final class AuthProfileSuccess extends AuthState {}

final class AuthProfileError extends AuthState {
  final ApiErrorModel error;
  AuthProfileError({required this.error});
}
