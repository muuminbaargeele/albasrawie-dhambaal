import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';
import '../widgets/bottom_wave_widget.dart';
import '../widgets/forgot_password_link.dart';
import '../widgets/register_text_link.dart';
import '../widgets/top_wave_widget.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const TopWaveWidget(),
          const BottomWaveWidget(),
          Positioned(
            top: 130.h,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppLogo(width: 84, height: 74),
                    SizedBox(height: 16.h), // spacing for future widgets below
                    Text(
                      "Gal xisaabtaada",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: 34.h),
                    CustomTextField(
                      hintText: "Lambar ama farriin-danabeed",
                      icon: LucideIcons.mail,
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: "Erey-daahsoooneed",
                      icon: LucideIcons.lock,
                      controller: controller.passwordController,
                      obscureText: true,
                      obscureTextRx: controller.passwordObscure,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 8.h),
                    ForgotPasswordLink(onTap: () {}),
                    SizedBox(height: 24.h),
                    AppButton(
                      text: "Hore u gal",
                      width: 150.w,
                      isDisabled: controller.isDisabled,
                      isLoading: controller.isLoading,
                      onPressed: () {
                        controller.login();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 128.h,
            left: 0,
            right: 0,
            child: Center(child: RegisterTextLink(onTap: () {})),
          ),
        ],
      ),
    );
  }
}
