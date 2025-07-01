import 'package:albasrawie_dhambaal/features/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/color_utils.dart';
import '../../../shared/widgets/dismiss_keyboard.dart';
import '../../../shared/widgets/responsive_background.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    bool isNeedTopSafeArea = MediaQuery.of(context).viewPadding.top > 24;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    final brightness = View.of(context).platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final base = Theme.of(context).scaffoldBackgroundColor;
    final adjusted = adjustColorBrightness(base);

    final baseChat = Theme.of(context).colorScheme.secondary;
    final adjustedChat = adjustColorBrightness(
      baseChat,
      operator: isDarkMode ? "-" : "+",
      amount: isDarkMode ? 0.15 : 0,
    );

    final baseField = Theme.of(context).scaffoldBackgroundColor;
    final adjustedField = adjustColorBrightness(
      baseField,
      operator: isDarkMode ? "+" : null,
      amount: isDarkMode ? 0.10 : 0,
    );
    return DismissKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            ResponsiveBackground(),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChatAppBar(
                    adjusted: adjusted,
                    isNeedSafeArea: isNeedTopSafeArea,
                    controller: controller,
                  ),
                  ChatWidget(
                    controller: controller,
                    adjustedChat: adjustedChat,
                    adjusted: adjusted,
                  ),
                  SingleChildScrollView(
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeOut,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: BottomBar(
                        adjusted: adjusted,
                        bottomInset: bottomInset,
                        adjustedField: adjustedField,
                        controller: controller,
                        onChanged: (value) {
                          controller.messageQuery.value = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
