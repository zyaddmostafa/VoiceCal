class UserSettings {
  final String email;
  final String plan;
  final int voiceRecordsLeft;
  final String language;
  final bool dailyRemindersEnabled;

  const UserSettings({
    required this.email,
    required this.plan,
    required this.voiceRecordsLeft,
    required this.language,
    required this.dailyRemindersEnabled,
  });

  UserSettings copyWith({
    String? email,
    String? plan,
    int? voiceRecordsLeft,
    String? language,
    bool? dailyRemindersEnabled,
  }) {
    return UserSettings(
      email: email ?? this.email,
      plan: plan ?? this.plan,
      voiceRecordsLeft: voiceRecordsLeft ?? this.voiceRecordsLeft,
      language: language ?? this.language,
      dailyRemindersEnabled:
          dailyRemindersEnabled ?? this.dailyRemindersEnabled,
    );
  }
}
