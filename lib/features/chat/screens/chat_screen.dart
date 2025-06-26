import 'package:albasrawie_dhambaal/features/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/color_utils.dart';
import '../../../shared/widgets/responsive_background.dart';
import '../widgets/chat_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    bool isNeedSafeArea = MediaQuery.of(context).viewPadding.top > 24;

    final base = Theme.of(context).scaffoldBackgroundColor;
    final adjusted = adjustColorBrightness(base);

    return Scaffold(
      body: ResponsiveBackground(
        child: Column(
          children: [
            ChatAppBar(adjusted: adjusted, isNeedSafeArea: isNeedSafeArea, controller: controller),
          ],
        ),
      ),
    );
  }
}

