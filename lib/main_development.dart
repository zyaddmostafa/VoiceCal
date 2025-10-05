import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_bloc_observer.dart';
import 'core/config/speech_to_text_service.dart';
import 'core/di/get_it.dart';
import 'core/config/hive_service.dart';
import 'core/service/supabase_service.dart';
import 'firebase_options.dart';
import 'voice_cal_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  // Load .env file if it exists (for local development)
  // In production/CI, environment variables will be used instead
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // .env file not found, using system environment variables
    log('No .env file found, using system environment variables');
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SupabaseService.supabaseInit();

  await HiveService.hiveInit();
  await setupGetIt();

  await getIt<SpeechToTextService>().speechToTextInit();

  Bloc.observer = AppBlocObserver();

  runApp(const VoiceCalApp());
}
