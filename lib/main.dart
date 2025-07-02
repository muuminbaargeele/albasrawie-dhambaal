import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'config/app_binding.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'features/chats/controllers/chats_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize((payload) {
    final chatId = int.tryParse(payload);
    if (chatId != null) {
      final chatsController = Get.find<ChatsController>();
      final chat = chatsController.allChats.firstWhereOrNull((c) => c.chatId == chatId);
      if (chat != null) {
        chatsController.navigateToChat(chat);
      }
    }
  });
  await GetStorage.init();
  Get.put(StorageService());
  runApp(
    LayoutBuilder(builder: (context, constraints) {
      final isTablet = constraints.maxWidth > 600;
      return ScreenUtilInit(
        designSize: isTablet ? Size(constraints.maxWidth, constraints.maxHeight) : Size(412, 917),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MainApp(),
      );
    }),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Get.find<StorageService>().isLoggedIn();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialBinding: AppBinding(),
      initialRoute: isLoggedIn ? AppRoutes.main : AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}