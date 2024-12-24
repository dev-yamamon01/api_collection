import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined), label: '郵便番号'),
        BottomNavigationBarItem(icon: Icon(Icons.sunny), label: '天気'),
        BottomNavigationBarItem(
            icon: Icon(Icons.circle), label: 'ポケモン'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
