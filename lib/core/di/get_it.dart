import 'package:get_it/get_it.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/services/supabase_auth_service.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/services/home_api_service.dart';
import '../networking/dio_factory.dart';
import '../nutrition/nutrition_calculator_service.dart';
import '../config/hive_service.dart';
import '../config/speech_to_text_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final dio = DioFactory.getDio();
  // Register services
  getIt.registerLazySingleton(() => NutritionCalculatorService());
  getIt.registerLazySingleton(() => HiveService());
  getIt.registerLazySingleton(() => SpeechToTextService());
  getIt.registerLazySingleton(() => HomeApiService(dio));

  getIt.registerLazySingleton<SupabaseAuthService>(() => SupabaseAuthService());

  // Register repository with initialized service
  getIt.registerLazySingleton(
    () => AuthRepo(supabaseAuthService: getIt<SupabaseAuthService>()),
  );

  getIt.registerLazySingleton(
    () => HomeRepo(homeApiService: getIt<HomeApiService>()),
  );
}
