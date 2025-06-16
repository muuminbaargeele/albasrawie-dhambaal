import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/app_logo.dart';
import '../controllers/login_controller.dart';
import '../widgets/bottom_wave_widget.dart' show BottomWaveWidget;
import '../widgets/top_wave_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      body: Stack(
        children: [
          const TopWaveWidget(),
          const BottomWaveWidget(),
          Positioned(
            top: 130.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppLogo(width: 84, height: 74,),
                SizedBox(height: 16.h), // spacing for future widgets below
                Text("Gal xisaabtaada", style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}