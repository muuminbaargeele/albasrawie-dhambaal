import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final RxBool isDisabled;
  final RxBool? isLoading;
  final double? width;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isDisabled,
    required this.isLoading,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final disabled = isDisabled.value;
      final loading = isLoading?.value ?? false;
      return SizedBox(
        width: width ?? double.infinity,
        height: 48.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: disabled || loading
                ? Theme.of(context).disabledColor
                : Theme.of(context).primaryColor,
            textStyle: Theme.of(context).textTheme.labelLarge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
          onPressed: disabled || loading ? null : onPressed,
          child: loading
              ? SizedBox(height: 24, width: 24, child: const CircularProgressIndicator.adaptive())
              : Text(text, style: Theme.of(context).textTheme.labelLarge,),
        ),
      );
    });
  }
}