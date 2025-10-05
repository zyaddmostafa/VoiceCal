import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'features/auth/data/services/supabase_auth_service.dart';

class VoiceCalApp extends StatelessWidget {
  const VoiceCalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SupabaseAuthService.isAuthenticated
            ? Routes.homeScreen
            : Routes.welcomeScreen,
        // initialRoute: Routes.homeScreen,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
