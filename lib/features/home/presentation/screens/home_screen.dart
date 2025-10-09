import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../data/repo/home_repo.dart';
import '../cubit/home_cubit.dart';
import '../widgets/home_screen_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(homeRepo: getIt<HomeRepo>()),
      child: const HomeScreenContent(),
    );
  }
}
