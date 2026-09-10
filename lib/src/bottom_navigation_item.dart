import 'package:flutter/material.dart';

class BottomNavigationItem {
  final IconData icon;

  /// Swapped in when the tab is active — handy for outline vs. filled
  /// icon pairs (e.g. Icons.home_outlined -> Icons.home). Falls back to
  /// [icon] if you don't need the distinction.
  final IconData? selectedIcon;

  final String label;

  const BottomNavigationItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}