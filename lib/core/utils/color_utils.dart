import 'package:flutter/material.dart';

Color adjustColorBrightness(
  Color color, {
  double amount = 0.05,
  String? operator, // '+' or '-' or null
}) {
  final hsl = HSLColor.fromColor(color);
  double adjustment;

  if (operator == '+') {
    adjustment = amount;
  } else if (operator == '-') {
    adjustment = -amount;
  } else {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    adjustment = brightness == Brightness.dark ? amount : -amount;
  }

  final adjustedLightness = (hsl.lightness + adjustment).clamp(0.0, 1.0);

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
