import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/custom_nav_bar.dart';
import '../../calls/screens/calls_screen.dart';
import '../../chats/controllers/chats_controller.dart';
import '../../chats/screens/chats_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    final bottomInset = MediaQuery.of(context).padding.bottom;
    if (bottomInset > 30) {
      // 3-button mode
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    }

    return Scaffold(
      body: Obx(() {
        switch (controller.selectedTabIndex.value) {
          case 0:
            return const CallsScreen(); // auto binds CallsController
          case 1:
            return GetBuilder<ChatsController>(
              init: ChatsController(),
              builder: (_) => const ChatsScreen(),
            );
          case 2:
            return const SettingsScreen(); // auto binds SettingsController
          default:
            return const Center(child: Text("Unknown tab"));
        }
      }),
      bottomNavigationBar: Obx(
        () => CustomNavBar(
          selectedIndex: controller.selectedTabIndex.value,
          onTabSelected: controller.updateTabIndex,
          bottomInset: bottomInset,
        ),
      ),
    );
  }
}
