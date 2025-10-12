part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsProfileLoaded extends SettingsState {
  final UserProfile profile;

  SettingsProfileLoaded({required this.profile});
}

final class SettingsProfileUpdated extends SettingsState {
  final String message;

  SettingsProfileUpdated({this.message = 'Profile updated successfully'});
}

final class SettingsError extends SettingsState {
  final ApiErrorModel apiErrorModel;

  SettingsError({required this.apiErrorModel});
}
