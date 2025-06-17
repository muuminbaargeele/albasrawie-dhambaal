import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscureText;
  final RxBool? obscureTextRx;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.obscureTextRx,
    this.keyboardType = TextInputType.none,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = obscureTextRx ?? RxBool(obscureText);

    return Obx(() => TextField(
          controller: controller,
          obscureText: isObscure.value,
          keyboardType: keyboardType,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 12.w),
              child: Icon(icon, size: 24.sp, color: Theme.of(context).hintColor),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 48.w),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).hintColor),
            filled: false,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Theme.of(context).focusColor, width: 2),
            ),
            suffixIcon: obscureTextRx != null
                ? IconButton(
                    icon: Icon(
                      isObscure.value ? LucideIcons.eyeOff : LucideIcons.eye,
                      color: Theme.of(context).hintColor,
                    ),
                    onPressed: () => isObscure.value = !isObscure.value,
                  )
                : null,
          ),
        ));
  }
}
