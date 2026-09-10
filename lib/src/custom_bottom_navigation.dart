import 'package:flutter/material.dart';

import 'bottom_navigation_item.dart';


class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.height = 72,
    this.iconSize = 23,
    this.fontSize = 11.5,
    this.fontFamily,
    this.backgroundColor = Colors.white,
    this.selectedColor = const Color(0xFF3D5CFF),
    this.unselectedColor = const Color(0xFF9AA0A6),
    this.margin = const EdgeInsets.fromLTRB(12, 0, 12, 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
  }) : assert(
  items.length >= 2 && items.length <= 6,
  'CustomBottomNavigation works best with 2 to 6 items.',
  );

  final List<BottomNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  final double height;
  final double iconSize;
  final double fontSize;
  final String? fontFamily;

  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;

  final EdgeInsetsGeometry margin;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    if (currentIndex < 0 || currentIndex >= items.length) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      top: false,
      child: Padding(
        padding: margin,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            boxShadow: [
              // Two stacked shadows read softer / more "premium" than one
              // hard one — a tight close shadow plus a broad, faint one
              // for ambient depth.
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: List.generate(items.length, (index) {
              return Expanded(
                child: _NavTile(
                  item: items[index],
                  selected: index == currentIndex,
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  iconSize: iconSize,
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                  onTap: () => onTap(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.iconSize,
    required this.fontSize,
    required this.fontFamily,
    required this.onTap,
  });

  final BottomNavigationItem item;
  final bool selected;
  final Color selectedColor;
  final Color unselectedColor;
  final double iconSize;
  final double fontSize;
  final String? fontFamily;
  final VoidCallback onTap;

  // Keep this in sync with the InkWell's radius below — a mismatch here
  // is exactly what made the pill look like a lopsided blob before.
  static const _pillRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    final color = selected ? selectedColor : unselectedColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_pillRadius),
        splashColor: selectedColor.withValues(alpha: 0.15),
        highlightColor: selectedColor.withValues(alpha: 0.08),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: selected
                ? selectedColor.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(_pillRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 1, end: selected ? 1.1 : 1.0),
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: Icon(
                  selected && item.selectedIcon != null
                      ? item.selectedIcon
                      : item.icon,
                  size: iconSize,
                  color: color,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                  height: 1.1,
                ),
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}