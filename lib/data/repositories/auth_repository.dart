import '../network/api_client.dart';

class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
    required void Function(bool status, dynamic result, String? error) callback,
  }) async {
    await ApiClient.postRequest(
      'check_login',
      {
        'email': email,
        'password': password,
      },
      (status, result, error) {
        callback(status, result, error);
      },
    );
  }
}