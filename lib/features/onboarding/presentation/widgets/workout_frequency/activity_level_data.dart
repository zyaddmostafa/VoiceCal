/// Activity level data for workout frequency selection
class ActivityLevelData {
  static const List<Map<String, String>> levels = [
    {
      'id': 'sedentary',
      'emoji': '🛋️',
      'title': 'Sedentary',
      'description': 'Little to no exercise',
    },
    {
      'id': 'lightly_active',
      'emoji': '🚶',
      'title': 'Lightly Active',
      'description': '1–3 workouts per week',
    },
    {
      'id': 'moderately_active',
      'emoji': '🏃',
      'title': 'Moderately Active',
      'description': '3–5 workouts per week',
    },

    {
      'id': 'athlete',
      'emoji': '🔥',
      'title': 'Athlete',
      'description': 'Intense daily training',
    },
  ];
}
