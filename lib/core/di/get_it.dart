import 'package:get_it/get_it.dart';

import '../nutrition/nutrition_calculator_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton(() => NutritionCalculatorService());
}
