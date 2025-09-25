import 'package:flutter/material.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../../../stats/presentation/screens/stats_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  @override
  MainNavigationScreenState createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<bool> _hasBeenBuilt = [false, false, false, false];

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const StatsScreen(),
    const ProfileScreen(),
  ];

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
