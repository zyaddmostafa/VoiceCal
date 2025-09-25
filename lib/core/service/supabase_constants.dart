import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConstants {
  static String get supabaseUrl => 'https://bhugjlibipzjcwgdpolt.supabase.co';

  static String get supabaseAnonKey {
    // Step 1: Check if running in CI/CD with environment variable
    final envVar = Platform.environment['SUPABASE_ANON_KEY'];
    if (envVar != null && envVar.isNotEmpty) {
      return envVar; //  GitHub Actions uses this path
    }
    // Step 2: Fallback to local .env file

    return dotenv.env['SUPABASE_ANON_KEY'] ?? ''; //  Local dev uses this path
  }
}
