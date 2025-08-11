import 'package:albasrawie_dhambaal/data/models/chat/receiver_model.dart';
import 'package:albasrawie_dhambaal/data/models/chat/sender_model.dart';
import 'package:albasrawie_dhambaal/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/socket_service.dart';
import 'dart:async';
import '../../../core/utils/custom_snackbar.dart';
import '../../../data/models/active_participant_model.dart';
import '../../../data/models/chat/chat_message_model.dart';
import '../../../data/models/chat/chat_participant_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/chats_repository.dart';
import '../../../core/constants/constants.dart';

class ChatsController extends GetxController {
  final ChatsRepository _chatsRepository = ChatsRepository();
  final StorageService _storageService = StorageService();
  final SocketService _socketService = SocketService();

  var selectedTabIndex = 0.obs;
  var currentChatId = 0;
  var isChatOpen = false;
  late final UserModel? user;
  final searchController = TextEditingController();
  var searchQuery = ''.obs;
  final isLoading = false.obs;
  final RxList<ChatParticipant> allChats = <ChatParticipant>[].obs;
  final RxList<ActiveParticipant> activeParticipants =
      <ActiveParticipant>[].obs;
  final isTyping = false.obs;
  final Rx<int?> typingChatId = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();

    user = _storageService.getUser();
    final cached = GetStorage().read('chat_participants');
    if (cached != null) {
      final List<dynamic> cachedList = cached;
      allChats.assignAll(
        cachedList.map((e) => ChatParticipant.fromJson(e)).toList(),
      );
    }
    final cachedActive = GetStorage().read('active_participants');
    if (cachedActive != null) {
      final List<dynamic> cachedActiveList = cachedActive;
      activeParticipants.assignAll(
        cachedActiveList.map((e) => ActiveParticipant.fromJson(e)).toList(),
      );
    }

    getActiveParticipantsAndChats();

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
    _socketService.connect();
    _listenToSocket();
  }

  void setTab(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> getActiveParticipantsAndChats() async {
    isLoading.value = true;

    await _chatsRepository.getActiveParticipantsAndChats(
      userId: user!.traineeId.toString(),
      callback: (status, result, error) {
        isLoading.value = false;
        if (status) {
          final chatList = result["list_info"]["chat_participants"] as List;
          allChats.assignAll(
            chatList.map((e) => ChatParticipant.fromJson(e)).toList(),
          );
          GetStorage().write(
            'chat_participants',
            allChats.map((e) => e.toJson()).toList(),
          );
          final activeList = result["list_info"]["active_participants"] as List;
          activeParticipants.assignAll(
            activeList.map((e) => ActiveParticipant.fromJson(e)).toList(),
          );
          GetStorage().write(
            'active_participants',
            activeParticipants.map((e) => e.toJson()).toList(),
          );
        } else {
          CustomSnackbar.showError(
            title: "Cilad farsamo ayaa dhacay",
            error ?? "Cilad farsamo ayaa dhacay",
          );
        }
      },
    );
  }

  Future<void> createNewChat(Receiver receiver) async {
    isLoading.value = true;

    await _chatsRepository.getNewChatId(
      userId: user!.traineeId.toString(),
      traineeId: receiver.traineeId.toString(),
      callback: (status, result, error) {
        isLoading.value = false;
        if (status) {
          var chatId = result["chat_id"];
          final chat = ChatParticipant(
            chat: [],
            chatId: chatId,
            createBy: user!.traineeId,
            createdAt: DateTime.now().toUtc().toIso8601String(),
            receiver: receiver,
            sender: Sender(
              fullName: user!.fullName,
              image: user!.imagePath ?? Constants.noImagePath,
              phone: user!.phoneNumber,
              traineeId: user!.traineeId,
            ),
          );
          navigateToChat(chat);
        } else {
          CustomSnackbar.showError(
            title: "Cilad farsamo ayaa dhacay",
            error ?? "Cilad farsamo ayaa dhacay",
          );
        }
      },
    );
  }

  List<ChatParticipant> get filteredChats {
    List<ChatParticipant> baseList = allChats;

    if (searchQuery.value.isEmpty) return baseList;

    return baseList.where((chat) {
      final targetName = chat.receiver.fullName.isNotEmpty
          ? chat.receiver.fullName
          : chat.sender.fullName;
      return targetName.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  List<ActiveParticipant> get filteredActiveParticipants {
    List<ActiveParticipant> baseList = activeParticipants;

    if (searchQuery.value.isEmpty) return baseList;

    return baseList.where((participant) {
      final name = participant.traineeFullName.toLowerCase();
      final email = participant.traineeEmail.toLowerCase();
      final phone = participant.traineePhoneNumber.toLowerCase();
      final query = searchQuery.value.toLowerCase();

      return name.contains(query) ||
          email.contains(query) ||
          phone.contains(query);
    }).toList();
  }

  void _listenToSocket() {
    _socketService.on('show_chat_tap_on_top', (data) {
      try {
        final result = data['payload']?['result'];
        if (result != null) updateChatFromSocket(result);
      } catch (e) {
        if (kDebugMode) {
          print('❌ Error handling socket message: $e');
        }
      }
    });

    _socketService.on('show-indicator', (data) {
      try {
        final typingChatId = int.tryParse(data['chat_id'].toString());
        final isTypingValue = data['is_typing'] == true;
        final typingSenderId = int.tryParse(data['sender_id'].toString());

        final isNotMyselfTyping = typingSenderId != user!.traineeId;

        if (typingChatId != null && isTypingValue && isNotMyselfTyping) {
          isTyping.value = true;
          this.typingChatId.value = typingChatId; // 👈 NEW
          print("3 ${isTyping.value}");
          allChats.refresh();
        } else {
          isTyping.value = false;
          this.typingChatId.value = null; // 👈 NEW
          allChats.refresh();
        }
      } catch (e) {
        if (kDebugMode) {
          print('❌ Error handling typing indicator: $e');
        }
      }
    });
  }

  void updateChatFromSocket(Map<String, dynamic> result) {
    print(result);
    final chatId = int.parse(result['chat_id'].toString());
    final content = result['content'];
    final createdAt = result['created_at'];
    final senderId = int.parse(result['sender_id'].toString());
    final receiverId = int.parse(result['receiver_id'].toString());
    final senderName = result['sender_name'];

    final title = senderName ?? 'Farriin Cusub';
    final message = content ?? '';

    final index = allChats.indexWhere((chat) => chat.chatId == chatId);

    if (index != -1) {
      final newMessage = ChatMessage(
        content: content,
        deletedBy: null,
        deliveredAt: null,
        groupDesc: null,
        groupName: "",
        isDeleted: 0,
        isGroup: 0,
        messageId: null,
        messageType: "text",
        quotedMessageId: null,
        receiverId: receiverId,
        seenAt: null,
        senderId: senderId,
        sentAt: createdAt,
        status: "sent",
      );

      allChats[index].chat.insert(0, newMessage);
      allChats.refresh();
    }

    // Show notification for new message
    if (isChatOpen) {
      if (chatId != currentChatId) {
        NotificationService.showNotification(
          title: title,
          body: message,
          payload: chatId.toString(),
        );
      }
    } else {
      NotificationService.showNotification(
        title: title,
        body: message,
        payload: chatId.toString(),
      );
    }
  }

  void navigateToChat(ChatParticipant chat) {
    isChatOpen = true;
    currentChatId = chat.chatId;
    Get.toNamed(
      AppRoutes.chat,
      arguments: {
        "chat": chat,
        "isTyping": isTyping,
        "typingChatId": typingChatId,
      },
    )?.then((_) {
      // This runs when user comes back from Chat screen
      isChatOpen = false;
      currentChatId = 0;
    });
  }
}
