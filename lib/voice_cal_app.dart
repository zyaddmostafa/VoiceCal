import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/onboarding/presentation/screens/welcome_screen.dart';

class VoiceCalApp extends StatelessWidget {
  const VoiceCalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'VoiceCal',
        theme: ThemeData(
          fontFamily: 'SF Pro Text', // iOS font family
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
