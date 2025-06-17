import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterTextLink extends StatelessWidget {
  final VoidCallback onTap;

  const RegisterTextLink({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            text: 'Ma diiwaangashanid? ',
            style: Theme.of(context).textTheme.bodySmall,
            children: [
              TextSpan(
                text: 'Hadda is-qor',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        LayoutBuilder(
          builder: (context, constraints) {
            final textPainter = TextPainter(
              text: TextSpan(
                text: 'Ma diiwaangashanid? Hadda is-qor',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              textDirection: TextDirection.ltr,
            )..layout();

            return SizedBox(
              width: textPainter.size.width,
              height: 3.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(color: Theme.of(context).hintColor),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}