import '../network/api_client.dart';

class ChatsRepository {
  Future<void> getActiveParticipantsAndChats({
    required String userId,
    required void Function(bool status, dynamic result, String? error) callback,
  }) async {
    await ApiClient.postRequest(
      'get_active_participants_and_chats_v2',
      {'user_id': userId},
      (status, result, error) {
        callback(status, result, error);
      },
    );
  }

    Future<void> getNewChatId({
    required String userId,
    required String traineeId,
    required void Function(bool status, dynamic result, String? error) callback,
  }) async {
    await ApiClient.postRequest(
      'end_point/create_new_chat',
      {
        "user_id": userId,
        "trainee_id": traineeId,
        "created_at": DateTime.now().toUtc().toIso8601String(),
      },
      (status, result, error) {
        callback(status, result, error);
      },
    );
  }
}
