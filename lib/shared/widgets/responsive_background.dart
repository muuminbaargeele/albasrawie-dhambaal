import 'package:flutter/material.dart';

class ResponsiveBackground extends StatelessWidget {
  final Widget child;

  const ResponsiveBackground({super.key, required this.child});

  bool _isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  String _getBackgroundImage(BuildContext context) {
    final dark = _isDarkMode(context);
    final tablet = _isTablet(context);

    if (tablet && dark) return 'assets/images/chat_bg_dark_ipad.png';
    if (tablet && !dark) return 'assets/images/chat_bg_light_ipad.png';
    if (!tablet && dark) return 'assets/images/chat_bg_dark.png';
    return 'assets/images/chat_bg_light.png';
  }

  @override
  Widget build(BuildContext context) {
    final bgImage = _getBackgroundImage(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          bgImage,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}