import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../controllers/chats_controller.dart';
import '../widgets/chats_widget.dart';
import '../widgets/custom_appBar.dart';
import 'select_user_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatsController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(controller: controller),
            ChatsContainer(controller: controller),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => SelectUserScreen());
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 4,
        child: Icon(LucideIcons.messageSquarePlus, size: 28),
      ),
    );
  }
}
