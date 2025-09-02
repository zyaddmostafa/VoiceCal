import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceCalApp extends StatelessWidget {
  const VoiceCalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('VoiceCal')),
          body: const Center(child: Text('Welcome to VoiceCal!')),
        ),
      ),
    );
  }
}
