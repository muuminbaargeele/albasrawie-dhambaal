import 'package:flutter/material.dart';

Color adjustColorBrightness(Color color) {
  final brightness = ThemeData.estimateBrightnessForColor(color);
  final hsl = HSLColor.fromColor(color);
  final adjustedLightness =
      (hsl.lightness + (brightness == Brightness.dark ? 0.05 : -0.05))
          .clamp(0.0, 1.0);
  return hsl.withLightness(adjustedLightness).toColor();
}

Color getAvatarColor(String key) {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.teal,
    Colors.orange,
    Colors.brown,
    Colors.indigo,
  ];

  final int index = key.hashCode % colors.length;
  return colors[index];
}