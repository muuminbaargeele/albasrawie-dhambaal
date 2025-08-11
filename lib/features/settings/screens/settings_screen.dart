import 'package:albasrawie_dhambaal/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    final user = controller.user!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Haye, ${user.fullName}\nAqoonsigaaga: ${user.traineeId}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: AppButton(
                  text: "Ka Bax Xisaabtaada",
                  onPressed: controller.logOut,
                  isDisabled: false.obs,
                  isLoading: false.obs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
