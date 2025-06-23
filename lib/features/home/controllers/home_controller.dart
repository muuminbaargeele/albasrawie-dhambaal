import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../../../data/models/active_participant_model.dart';
import '../../../data/models/chat_participant_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final StorageService _storageService = StorageService();

  var selectedTabIndex = 0.obs;
  late final UserModel? user;
  final searchController = TextEditingController();
  var searchQuery = ''.obs;
  final isLoading = false.obs;
  final RxList<ChatParticipant> allChats = <ChatParticipant>[].obs;
  final RxList<ActiveParticipant> activeParticipants = <ActiveParticipant>[].obs;

  @override
  void onInit() {
    super.onInit();
    user = _storageService.getUser();
    final cached = GetStorage().read('chat_participants');
    if (cached != null) {
      final List<dynamic> cachedList = cached;
      allChats.assignAll(cachedList.map((e) => ChatParticipant.fromJson(e)).toList());
    }
    final cachedActive = GetStorage().read('active_participants');
    if (cachedActive != null) {
      final List<dynamic> cachedActiveList = cachedActive;
      activeParticipants.assignAll(
        cachedActiveList.map((e) => ActiveParticipant.fromJson(e)).toList(),
      );
    }
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
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
          allChats.assignAll(chatList.map((e) => ChatParticipant.fromJson(e)).toList());
          GetStorage().write('chat_participants', allChats.map((e) => e.toJson()).toList());
          final activeList = result["list_info"]["active_participants"] as List;
          activeParticipants.assignAll(activeList.map((e) => ActiveParticipant.fromJson(e)).toList());
          GetStorage().write('active_participants', activeParticipants.map((e) => e.toJson()).toList());
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
      final targetName = chat.receiverFullName.isNotEmpty
          ? chat.receiverFullName
          : chat.senderFullName;
      return targetName.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }
}
