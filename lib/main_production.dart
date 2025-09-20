import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/get_it.dart';
import 'core/service/hive_service.dart';
import 'core/service/supabase_service.dart';

import 'firebase_options.dart';
import 'voice_cal_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //to fix test in release mode
  await ScreenUtil.ensureScreenSize();

  // Load environment variables first
  await dotenv.load(fileName: '.env');

  // Initialize Firebase (for app distribution)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Supabase (for authentication)
  await SupabaseService.supabaseInit();
  await HiveService.hiveInit();
  await setupGetIt(); // Initialize dependency injection
  runApp(const VoiceCalApp());
}
