import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/get_it.dart';
import '../../../analytics/presentation/screens/analytics_screen.dart';
import '../../../auth/data/repo/auth_repo.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  @override
  MainNavigationScreenState createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<bool> _hasBeenBuilt = [false, false, false, false];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const AnalyticsScreen(),
      BlocProvider(
        create: (context) =>
            SettingsCubit(authRepo: getIt<AuthRepo>())
              ..getUserProfile(Supabase.instance.client.auth.currentUser!.id),
        child: const SettingsScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.asMap().entries.map((entry) {
          final index = entry.key;
          final page = entry.value;

          if (!_hasBeenBuilt[index] && index == _currentIndex) {
            _hasBeenBuilt[index] = true;
          }

          return _hasBeenBuilt[index] ? page : const SizedBox.shrink();
        }).toList(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
