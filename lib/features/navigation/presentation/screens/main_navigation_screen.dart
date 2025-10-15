import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/helpers/app_icons.dart';
import '../../../analytics/data/repo/analytics_repo.dart';
import '../../../analytics/presentation/cubit/analytics_cubit.dart';
import '../../../analytics/presentation/screens/analytics_screen.dart';
import '../../../auth/data/repo/auth_repo.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../home/data/repo/home_repo.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/screens/settings_screen.dart';

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
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;

    _pages = [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(homeRepo: getIt<HomeRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                AuthCubit(authRepo: getIt<AuthRepo>())
                  ..getUserProfile(userId: currentUserId!),
          ),
        ],
        child: const HomeScreen(),
      ),
      BlocProvider(
        create: (context) =>
            AnalyticsCubit(analyticsRepo: getIt<AnalyticsRepo>()),
        child: const AnalyticsScreen(),
      ),
      BlocProvider(
        create: (context) =>
            getIt<SettingsCubit>()..getUserProfile(currentUserId!),
        child: const SettingsScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        activeColor: CupertinoColors.black,
        inactiveColor: CupertinoColors.systemGrey,
        backgroundColor: CupertinoColors.systemBackground,
        border: const Border(
          top: BorderSide(color: CupertinoColors.systemGrey4, width: 0.5),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(AppIcons.home),
            activeIcon: Icon(AppIcons.homeFilled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.stats),
            activeIcon: Icon(AppIcons.statsFilled),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.settings),
            activeIcon: Icon(AppIcons.settingsFilled),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        if (!_hasBeenBuilt[index] && index == _currentIndex) {
          _hasBeenBuilt[index] = true;
        }

        return _hasBeenBuilt[index] ? _pages[index] : const SizedBox.shrink();
      },
    );
  }
}
