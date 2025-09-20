import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_bloc_observer.dart';
import 'core/di/get_it.dart';
import 'core/service/hive_service.dart';
import 'core/service/supabase_service.dart';
import 'firebase_options.dart';
import 'voice_cal_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await dotenv.load(fileName: '.env');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SupabaseService.supabaseInit();

  await HiveService.hiveInit();
  await setupGetIt();
  Bloc.observer = AppBlocObserver();
  runApp(const VoiceCalApp());
}
