import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      body: Center(
        child: Text(
          'Login Screen',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
