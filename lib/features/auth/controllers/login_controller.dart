import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../data/models/user_model.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final StorageService _storageService = StorageService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final passwordObscure = true.obs;
  final isDisabled = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.showError("Email and password must not be empty");
      return;
    }

    isLoading.value = true;

    await _authRepository.login(
      email: email,
      password: password,
      callback: (status, result, error) {
        isLoading.value = false;

        print(status);
        if (status) {
          final user = UserModel.fromJson(result);
          _storageService.saveUser(user);
          CustomSnackbar.showSuccess("Login successful");
          Get.offAllNamed(AppRoutes.home);
        } else {
          print(error);
          CustomSnackbar.showError(title:  "Login Failed", error ?? "Unknown error");
        }
      },
    );
  }
}
