import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/utils/color_utils.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final double bottomInset;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.bottomInset,
  });

  @override
  Widget build(BuildContext context) {
    final adjusted = adjustColorBrightness(
      Theme.of(context).scaffoldBackgroundColor,
    );
    print(bottomInset);
    return SafeArea(
      top: false,
      bottom: bottomInset > 30 ? true : false,
      child: Platform.isIOS
          ? ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(
                  height: 70 + 14,
                  padding: EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: adjusted.withOpacity(0.5), // Figma color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(LucideIcons.phone, "Wicitaano", 0, context),
                      _buildNavItem(LucideIcons.messageCircle, "Dhambaalo", 1, context),
                      _buildNavItem(LucideIcons.cog, "Bayqaamin", 2, context),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              height: 70 + 14,
              padding: EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: adjusted, // Figma color
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(LucideIcons.phone, "Wicitaano", 0, context),
                  _buildNavItem(LucideIcons.messageCircle, "Dhambaalo", 1, context),
                  _buildNavItem(LucideIcons.cog, "Bayqaamin", 2, context),
                ],
              ),
            ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    BuildContext context,
  ) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).textTheme.bodyLarge!.color
                  : Theme.of(context).hintColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? Theme.of(context).textTheme.bodyLarge!.color
                    : Theme.of(context).hintColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
