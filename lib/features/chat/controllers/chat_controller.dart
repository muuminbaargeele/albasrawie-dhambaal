import 'dart:async';

import 'package:albasrawie_dhambaal/data/models/chat/chat_participant_model.dart';
import 'package:albasrawie_dhambaal/data/repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/socket_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/models/chat/chat_message_model.dart';
import '../../../data/models/user_model.dart';
import '../../chats/controllers/chats_controller.dart';

class ChatController extends GetxController {
  final ChatRepository _chatRepository = ChatRepository();
  final StorageService _storageService = StorageService();
  final SocketService _socketService = SocketService();
  final Rxn<ChatParticipant> chatMessage = Rxn<ChatParticipant>();

  late final UserModel? user;

  final messageController = TextEditingController();
  final isSending = false.obs;
  var messageQuery = ''.obs;
  late final RxBool isTyping;
  Timer? typingTimer;

  final ScrollController scrollController = ScrollController();
  final RxBool showScrollButton = false.obs;
  final RxInt newMessagesCount = 0.obs;
  int oldChatsLength = 0;

  List<ChatMessage> get currentMessages {
    final chats = Get.find<ChatsController>();
    final chat = chats.allChats.firstWhereOrNull(
      (c) => c.chatId == chatMessage.value?.chatId,
    );
    return chat?.chat ?? [];
  }

  @override
  void onInit() {
    super.onInit();
    final chatsController = Get.find<ChatsController>();
    final passedChat = Get.arguments["chat"] as ChatParticipant;
    isTyping = Get.arguments["isTyping"] as RxBool;
    chatMessage.value = passedChat;
    user = _storageService.getUser();

    ever(chatsController.allChats, (_) {
      final updated = chatsController.allChats.firstWhereOrNull(
        (c) => c.chatId == passedChat.chatId,
      );
      if (updated != null) {
        chatMessage.value = updated;
      }
    });

    messageController.addListener(() {
      messageQuery.value = messageController.text;

      emitTypingIndicator(chatMessage.value!.chatId, true);

      typingTimer?.cancel();

      typingTimer = Timer(Duration(seconds: 2), () {
        emitTypingIndicator(chatMessage.value!.chatId, false);
      });
    });

    ever(messageQuery, (_) => checkIsSending());

    setupScrollListener();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void checkIsSending() {
    isSending.value = messageQuery.value.trim().isNotEmpty;
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      final atBottom =
          scrollController.hasClients && scrollController.offset <= 50;
      showScrollButton.value = !atBottom;
      if (atBottom) newMessagesCount.value = 0;
    });
  }

  void scrollToBottom() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    newMessagesCount.value = 0;
  }

  void trackNewMessages(List<ChatMessage> chats) {
    if (chats.length > oldChatsLength) {
      final atBottom =
          scrollController.hasClients && scrollController.offset <= 50;
      if (!atBottom) {
        newMessagesCount.value += chats.length - oldChatsLength;
      }
    }
    oldChatsLength = chats.length;
  }

  Future<void> sendMessage() async {
    final message = messageController.text.trim();

    if (message.isEmpty) {
      return;
    }

    await _chatRepository.sendMessage(
      message: message,
      chatId: chatMessage.value!.chatId.toString(),
      receiverId: chatMessage.value!.receiver.traineeId.toString(),
      senderId: chatMessage.value!.sender.traineeId.toString(),
      callback: (status, result, error) {
        if (status) {
          chatMessage.refresh();
        } else {
          if (kDebugMode) {
            print(error);
          }
        }
      },
    );
  }

  Future<void> sendMessageWithSocket() async {
    final message = messageController.text.trim();
    messageController.clear();

    if (message.isEmpty) {
      return;
    }

    await _chatRepository.sendMessageWithSocket(
      message: message,
      chatId: chatMessage.value!.chatId.toString(),
      receiverId: chatMessage.value!.receiver.traineeId.toString(),
      senderId: chatMessage.value!.sender.traineeId.toString(),
      senderName: chatMessage.value!.sender.fullName,
      callback: (status, result, error) {
        if (status) {
          chatMessage.refresh();
        } else {
          if (kDebugMode) {
            print(error);
          }
        }
      },
    );
  }

  void emitTypingIndicator(int chatId, bool typing) {
    _socketService.emit('check-indicator', {
      'chat_id': chatId,
      'is_typing': typing,
      'sender_id': user!.traineeId,
    });
  }
}
