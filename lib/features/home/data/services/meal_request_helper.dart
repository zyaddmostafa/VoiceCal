import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/meal_data_request.dart';

class MealRequestHelper {
  static MealDataRequest? createRequest(String mealText) {
    final user = Supabase.instance.client.auth.currentUser;

    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm');

    return MealDataRequest(
      userId: user?.id ?? '',
      mealText: mealText,
      mealDate: dateFormat.format(now),
      mealTime: timeFormat.format(now),
    );
  }
}
