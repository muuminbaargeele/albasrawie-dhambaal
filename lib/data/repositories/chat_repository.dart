import '../network/api_client.dart';

class ChatRepository {
  Future<void> sendMessage({
    required String message,
    required String chatId,
    required String receiverId,
    required String senderId,
    required void Function(bool status, dynamic result, String? error) callback,
  }) async {
    await ApiClient.postRequest(
      'end_point/save_new_message',
      {
        "chat_id": chatId,
        "receiver_id": receiverId,
        "sender_id": senderId,
        "content": message,
        "created_at": DateTime.now().toString(),
      },
      (status, result, error) {
        callback(status, result, error);
      },
    );
  }

  Future<void> sendMessageWithSocket({
    required String message,
    required String chatId,
    required String receiverId,
    required String senderId,
    required String senderName,
    required void Function(bool status, dynamic result, String? error) callback,
  }) async {
    await ApiClient.postRequest(
      'end_point/show_chat_tap_on_top/socket',
      {
        "chat_id": chatId,
        "receiver_id": receiverId,
        "sender_id": senderId,
        "content": message,
        "sender_name": senderName,
        "created_at": DateTime.now().toString(),
      },
      (status, result, error) {
        callback(status, result, error);
      },
    );
  }
}
