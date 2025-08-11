import 'package:albasrawie_dhambaal/features/chat/controllers/chat_controller.dart';
import 'package:albasrawie_dhambaal/features/chat/screens/chat_screen.dart';
import 'package:albasrawie_dhambaal/features/main/controllers/main_controller.dart';
import 'package:albasrawie_dhambaal/features/main/screens/main_screen.dart';
import 'package:albasrawie_dhambaal/features/settings/controllers/settings_controller.dart';
import 'package:albasrawie_dhambaal/features/settings/screens/settings_screen.dart';
import 'package:get/get.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/chats/screens/chats_screen.dart';
import '../features/auth/controllers/login_controller.dart';
import '../features/chats/controllers/chats_controller.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MainController());
      }),
    ),
    GetPage(
      name: AppRoutes.chats,
      page: () => const ChatsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChatsController());
      }),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChatController());
      }),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SettingsController());
      }),
    ),
  ];
}
