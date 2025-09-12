/// Activity level model for workout frequency selection
class ActivityLevelModel {
  final String id;
  final String emoji;
  final String title;
  final String description;

  const ActivityLevelModel({
    required this.id,
    required this.emoji,
    required this.title,
    required this.description,
  });

  /// Static list of all activity levels
  static const List<ActivityLevelModel> levels = [
    ActivityLevelModel(
      id: 'sedentary',
      emoji: '🛋️',
      title: 'Sedentary',
      description: 'Little to no exercise',
    ),
    ActivityLevelModel(
      id: 'lightly_active',
      emoji: '🚶',
      title: 'Lightly Active',
      description: '1–3 workouts per week',
    ),
    ActivityLevelModel(
      id: 'moderately_active',
      emoji: '🏃',
      title: 'Moderately Active',
      description: '3–5 workouts per week',
    ),
    ActivityLevelModel(
      id: 'athlete',
      emoji: '🔥',
      title: 'Athlete',
      description: 'Intense daily training',
    ),
  ];
}
