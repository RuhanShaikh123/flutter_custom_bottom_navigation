import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_navigation/flutter_custom_bottom_navigation.dart';

void main() {
  runApp(const CustomBottomNavigationDemo());
}

class CustomBottomNavigationDemo extends StatefulWidget {
  const CustomBottomNavigationDemo({super.key});

  @override
  State<CustomBottomNavigationDemo> createState() =>
      CustomBottomNavigationDemoState();
}

class CustomBottomNavigationDemoState
    extends State<CustomBottomNavigationDemo> {
  int currentIndex = 0;

  // Outline icons at rest, filled once a tab is active — small touch but
  // it's the difference between "fine" and "polished".
  final items = const [
    BottomNavigationItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: 'Home',
    ),
    BottomNavigationItem(
      icon: Icons.search_outlined,
      selectedIcon: Icons.search_rounded,
      label: 'Search',
    ),
    BottomNavigationItem(
      icon: Icons.favorite_border_rounded,
      selectedIcon: Icons.favorite_rounded,
      label: 'Favorite',
    ),
    BottomNavigationItem(
      icon: Icons.notifications_outlined,
      selectedIcon: Icons.notifications_rounded,
      label: 'Alerts',
    ),
    BottomNavigationItem(
      icon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart_rounded,
      label: 'Cart',
    ),
    BottomNavigationItem(
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  final pageNames = const [
    'Home',
    'Search',
    'Favorites',
    'Notifications',
    'Cart',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Bottom Navigation',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        colorSchemeSeed: const Color(0xFF3D5CFF),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Bottom Navigation'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Text(
            pageNames[currentIndex],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigation(
          items: items,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          fontFamily: 'Roboto',
          selectedColor: const Color(0xFF3D5CFF),
          unselectedColor: const Color(0xFF9AA0A6),
        ),
      ),
    );
  }
}