import 'package:supabase_flutter/supabase_flutter.dart';

/// Service for managing weight entries in Supabase
/// Used across Auth, Settings, and Analytics features
class WeightEntryApiService {
  final SupabaseClient _supabase;

  WeightEntryApiService(this._supabase);

  /// Add a weight entry
  Future<void> addWeightEntry({
    required String userId,
    required double weight,
    required String entryDate,
  }) async {
    await _supabase.from('weight_entries').insert({
      'user_id': userId,
      'weight': weight,
      'entry_date': entryDate,
    });
  }

  /// Update a weight entry
  Future<void> updateWeightEntry({
    required String userId,
    required String entryDate,
    required double weight,
  }) async {
    await _supabase.from('weight_entries').update({'weight': weight}).match({
      'user_id': userId,
      'entry_date': entryDate,
    });
  }

  /// Delete a weight entry
  Future<void> deleteWeightEntry({
    required String userId,
    required String entryDate,
  }) async {
    await _supabase.from('weight_entries').delete().match({
      'user_id': userId,
      'entry_date': entryDate,
    });
  }
}
