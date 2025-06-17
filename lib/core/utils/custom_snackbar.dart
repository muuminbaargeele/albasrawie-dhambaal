import 'package:albasrawie_dhambaal/core/theme/app_dark_colors.dart';
import 'package:albasrawie_dhambaal/core/theme/app_shared_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../theme/app_light_colors.dart';

class CustomSnackbar {
  static void showSuccess(String message, {String title = "Success"}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: Get.textTheme.bodyLarge?.copyWith(
          color: AppDarkColors.mainText,
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall?.copyWith(color: AppDarkColors.mainText),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppSharedColors.success,
      colorText: AppDarkColors.mainText,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(LucideIcons.checkCircle, color: AppDarkColors.mainText),
      duration: const Duration(seconds: 3),
    );
  }

  static void showError(String message, {String title = "Error"}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: Get.textTheme.bodyLarge?.copyWith(
          color: AppDarkColors.mainText,
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall?.copyWith(color: AppDarkColors.mainText),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppSharedColors.error,
      colorText: AppDarkColors.mainText,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(LucideIcons.ban, color: AppDarkColors.mainText),
      duration: const Duration(seconds: 3),
    );
  }

  static void showWarning(String message, {String title = "Warning"}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: Get.textTheme.bodyLarge?.copyWith(
          color: AppLightColors.mainText,
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall?.copyWith(color: AppLightColors.mainText),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppSharedColors.warning,
      colorText: AppLightColors.mainText,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(LucideIcons.alertCircle, color: AppLightColors.mainText),
      duration: const Duration(seconds: 3),
    );
  }
}
