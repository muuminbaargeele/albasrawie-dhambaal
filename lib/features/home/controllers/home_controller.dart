import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/socket_service.dart';
import 'dart:async';
import '../../../core/utils/custom_snackbar.dart';
import '../../../data/models/active_participant_model.dart';
import '../../../data/models/chat/chat_message_model.dart';
import '../../../data/models/chat/chat_participant_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final StorageService _storageService = StorageService();
  final SocketService _socketService = SocketService();

  var selectedTabIndex = 0.obs;
  late final UserModel? user;
  final searchController = TextEditingController();
  var searchQuery = ''.obs;
  final isLoading = false.obs;
  final RxList<ChatParticipant> allChats = <ChatParticipant>[].obs;
  final RxList<ActiveParticipant> activeParticipants =
      <ActiveParticipant>[].obs;

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
    _socketService.emit('subscribe_to_event', {'event': 'show_chat_tap_on_top'});
    _listenToSocket();
  }

  void setTab(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> getActiveParticipantsAndChats() async {
    isLoading.value = true;

    await _homeRepository.getActiveParticipantsAndChats(
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

  void _listenToSocket() {
    _socketService.on('show_chat_tap_on_top', (data) {
      try {
        final result = data['payload']?['result'];

        if (result == null) return;

        final chatId = int.parse(result['chat_id'].toString());
        final content = result['content'];
        final createdAt = result['created_at'];
        final senderId = int.parse(result['sender_id'].toString());
        final receiverId = int.parse(result['receiver_id'].toString());

        // Find the existing chat
        final index = allChats.indexWhere((chat) => chat.chatId == chatId);

        if (index != -1) {
          final chat = allChats[index];

          // Create new ChatMessage
          final newMessage = ChatMessage(
            content: content,
            deletedBy: null,
            deliveredAt: null,
            groupDesc: null,
            groupName: chat.chat.first.groupName,
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

      } catch (e) {
        print('❌ Error handling socket message: $e');
      }
    });
  }

  @override
  void onClose() {
    _socketService.off('show_chat_tap_on_top');
    _socketService.disconnect();
    searchController.dispose();
    super.onClose();
  }
}
