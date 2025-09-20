import 'package:get_it/get_it.dart';

import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/services/supabase_auth_service.dart';
import '../nutrition/nutrition_calculator_service.dart';
import '../service/hive_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Register services
  getIt.registerLazySingleton(() => NutritionCalculatorService());
  getIt.registerLazySingleton(() => HiveService());

  getIt.registerLazySingleton<SupabaseAuthService>(() => SupabaseAuthService());

  // Register repository with initialized service
  getIt.registerLazySingleton(
    () => AuthRepo(supabaseAuthService: getIt<SupabaseAuthService>()),
  );
}
