import 'package:albasrawie_dhambaal/data/models/chat/chat_participant_model.dart';
import 'package:albasrawie_dhambaal/data/repositories/chat_repository.dart';
import 'package:get/get.dart';
import '../../../core/services/socket_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/models/user_model.dart';

class ChatController extends GetxController {
    final ChatRepository _chatRepository = ChatRepository();
    final StorageService _storageService = StorageService();
    final SocketService _socketService = SocketService();
    late final ChatParticipant? chatMessage;

    late final UserModel? user;

    @override
  void onInit() {
    super.onInit();
    chatMessage = Get.arguments;
    user = _storageService.getUser();
  }
  
}