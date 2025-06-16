import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomWaveWidget extends StatelessWidget {
  const BottomWaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          return Image.asset(
            isTablet
                ? 'assets/waves/bottom_wave_bg_tablet.png'
                : 'assets/waves/bottom_wave_bg.png',
            width: double.infinity,
            height: isTablet ? 130.h : 85.h,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}