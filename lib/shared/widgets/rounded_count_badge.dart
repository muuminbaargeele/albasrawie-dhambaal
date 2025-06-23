import 'package:flutter/material.dart';

class RoundedCountBadge extends StatelessWidget {
  final String text;
  final double fontSize;
  final EdgeInsets padding;

  const RoundedCountBadge({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(999), // maximum roundness
      ),
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Theme.of(context).scaffoldBackgroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
