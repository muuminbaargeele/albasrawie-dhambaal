import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/utils/color_utils.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscureText;
  final RxBool? obscureTextRx;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const SearchTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.obscureTextRx,
    this.keyboardType = TextInputType.none,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = obscureTextRx ?? RxBool(obscureText);
    final base = Theme.of(context).scaffoldBackgroundColor;
    final adjusted = adjustColorBrightness(base);

    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
        child: TextField(
          controller: controller,
          obscureText: isObscure.value,
          keyboardType: keyboardType,
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(
              icon,
              size: 16.sp,
              color: Theme.of(context).hintColor,
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 30.w, minHeight: 40.h),
            hintText: hintText,
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor),
            filled: true,
            fillColor: adjusted,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 0.h,
              horizontal: 16.w,
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
        ),
      ),
    );
  }
}
