import 'package:albasrawie_dhambaal/core/theme/app_shared_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomSnackbar {
  static void showSuccess(String message, {String title = "Waa lagu Guuleystay"}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: Get.textTheme.bodyLarge
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall
      ),
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(LucideIcons.checkCircle, color: AppSharedColors.success),
      duration: const Duration(seconds: 5),
    );
  }

  static void showError(String message, {String title = "Adeeggu wuu ciladaysan yahay"}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: Get.textTheme.bodyLarge
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall
      ),
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(LucideIcons.ban, color: AppSharedColors.error),
      duration: const Duration(seconds: 5),
    );
  }

  static void showWarning(String message, {String title = "Digniin"}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: Get.textTheme.bodyLarge
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall
      ),
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(LucideIcons.alertCircle, color: AppSharedColors.warning),
      duration: const Duration(seconds: 5),
    );
  }
}
