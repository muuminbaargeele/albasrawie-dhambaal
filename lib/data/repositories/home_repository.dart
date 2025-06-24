import '../network/api_client.dart';

class HomeRepository {
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
}
