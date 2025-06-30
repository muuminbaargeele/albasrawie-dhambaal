import 'package:albasrawie_dhambaal/data/models/chat/chat_participant_model.dart';
import 'package:albasrawie_dhambaal/data/repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/socket_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/models/chat/chat_message_model.dart';
import '../../../data/models/user_model.dart';

class ChatController extends GetxController {
  final ChatRepository _chatRepository = ChatRepository();
  final StorageService _storageService = StorageService();
  final SocketService _socketService = SocketService();
  final Rxn<ChatParticipant> chatMessage = Rxn<ChatParticipant>();

  late final UserModel? user;

  final messageController = TextEditingController();
  final isSending = false.obs;
  var messageQuery = ''.obs;

  List<ChatMessage> get currentMessages => chatMessage.value?.chat ?? [];

  @override
  void onInit() {
    super.onInit();
    chatMessage.value = Get.arguments;
    user = _storageService.getUser();

    messageController.addListener(() {
      messageQuery.value = messageController.text;
    });

    ever(messageQuery, (_) => checkIsSending());
  }

  void checkIsSending() {
    isSending.value = messageQuery.value.trim().isNotEmpty;
  }

  Future<void> sendMassage() async {
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

  Future<void> sendMassageWithSocket() async {
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
}
