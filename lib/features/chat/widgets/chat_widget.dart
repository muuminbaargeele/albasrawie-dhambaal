import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/utils/time_utils.dart';
import '../controllers/chat_controller.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.controller,
    required this.adjustedChat,
    required this.adjusted,
  });

  final ChatController controller;
  final Color adjustedChat;
  final Color adjusted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Obx(() {
            final chats = controller.currentMessages;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.trackNewMessages(chats);
            });
            final bool isTyping =
                controller.typingChatId.value ==
                controller.chatMessage.value?.chatId;
            final extraTyping = isTyping
                ? [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 3 / 4,
                        ),
                        child: ChatBubble(
                          clipper: ChatBubbleClipper3(
                            type: BubbleType.receiverBubble,
                          ),
                          alignment: Alignment.topLeft,
                          backGroundColor: adjusted,
                          elevation: 0,
                          margin: EdgeInsets.fromLTRB(4.h, 0, 4.h, 8.h),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: LoadingAnimationWidget.waveDots(
                              size: 20,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                : [];
            return ListView.builder(
              controller: controller.scrollController,
              reverse: true,
              padding: EdgeInsets.all(0),
              itemCount: chats.length + extraTyping.length,
              itemBuilder: (context, index) {
                if (index < extraTyping.length) {
                  return extraTyping[index];
                }
                final chat = chats[index - extraTyping.length];
                final bool isSender =
                    chat.senderId == controller.user!.traineeId;

                // New logic for grouping bubbles
                final bool isFirst = index - extraTyping.length == 0;
                final bool isPrevSameSender =
                    !isFirst &&
                    chats[index - extraTyping.length - 1].senderId ==
                        chat.senderId;
                final bool showBubble = isFirst || !isPrevSameSender;
                final double sideMargin = isFirst
                    ? 4.h
                    : (showBubble ? 4.h : 12.h);

                final statusIcon = chat.status != null && isSender
                    ? switch (chat.status) {
                        'sent' => LucideIcons.check,
                        'delivered' || 'seen' => LucideIcons.checkCheck,
                        _ => null,
                      }
                    : null;

                final statusIconColor = chat.status != null
                    ? switch (chat.status) {
                        'seen' => Theme.of(context).scaffoldBackgroundColor,
                        'delivered' || 'sent' => Theme.of(context).hintColor,
                        _ => null,
                      }
                    : null;

                final time = formatChatTime(chat.sentAt, is24h: false);

                return Align(
                  alignment: isSender ? Alignment.topRight : Alignment.topLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 3 / 4,
                    ),
                    child: showBubble
                        ? ChatBubble(
                            clipper: ChatBubbleClipper3(
                              type: isSender
                                  ? BubbleType.sendBubble
                                  : BubbleType.receiverBubble,
                            ),
                            alignment: isSender
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            backGroundColor: isSender ? adjustedChat : adjusted,
                            elevation: 0,
                            margin: EdgeInsets.fromLTRB(
                              sideMargin,
                              8,
                              sideMargin,
                              8.h,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    chat.content ?? "",
                                    maxLines: null,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  time,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        color: Theme.of(context).hintColor,
                                      ),
                                ),
                                if (statusIcon != null) SizedBox(width: 4.w),
                                if (statusIcon != null)
                                  Icon(
                                    statusIcon,
                                    size: 17.w,
                                    color: statusIconColor,
                                  ),
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.fromLTRB(
                              sideMargin,
                              8.w,
                              sideMargin,
                              0,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSender ? adjustedChat : adjusted,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r),
                                bottomLeft: Radius.circular(
                                  isSender ? 16.r : 4.r,
                                ),
                                bottomRight: Radius.circular(
                                  isSender ? 4.r : 16.r,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    chat.content ?? "",
                                    maxLines: null,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  time,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        color: Theme.of(context).hintColor,
                                      ),
                                ),
                                if (statusIcon != null) SizedBox(width: 4.w),
                                if (statusIcon != null)
                                  Icon(
                                    statusIcon,
                                    size: 17.w,
                                    color: statusIconColor,
                                  ),
                              ],
                            ),
                          ),
                  ),
                );
              },
            );
          }),
          Obx(
            () => controller.showScrollButton.value
                ? Positioned(
                    bottom: 16.h,
                    right: 12.w,
                    child: GestureDetector(
                      onTap: controller.scrollToBottom,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 42.w,
                            height: 42.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: adjusted,
                              boxShadow: [
                                BoxShadow(
                                  color: adjusted.withOpacity(0.1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                          if (controller.newMessagesCount.value > 0)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.secondary,
                                child: Text(
                                  '${controller.newMessagesCount.value}',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
