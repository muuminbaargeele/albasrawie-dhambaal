import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopWaveWidget extends StatelessWidget {
  const TopWaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          return Image.asset(
            isTablet
                ? 'assets/waves/top_wave_bg_tablet.png'
                : 'assets/waves/top_wave_bg.png',
            width: double.infinity,
            height: isTablet ? 130.h : 100.h,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}