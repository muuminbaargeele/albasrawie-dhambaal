import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Example loading state
  final isLoading = false.obs;

  // Future login logic here
}