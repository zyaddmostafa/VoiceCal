import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_constants.dart';

class SupabaseService {
  static Future<void> supabaseInit() async {
    await Supabase.initialize(
      url: SupabaseConstants.supabaseUrl,
      anonKey: SupabaseConstants.supabaseAnonKey,
    );
  }
}
