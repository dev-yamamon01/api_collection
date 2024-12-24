import 'package:flutter/material.dart';
import 'screens/post_api.dart';
import 'screens/weather_api.dart';
import 'screens/poke_api.dart';
import 'screens/account.dart';
import 'widgets/custom_bottom_nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Example',
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _Main createState() => _Main();
}

class _Main extends State<Main> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    PostAPI(),
    WeatherAPI(),
    PokeAPI(),
    Account(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: _onTabSelected,
      ),
    );
  }
}