import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_light_colors.dart';
import 'app_dark_colors.dart';
import 'app_shared_colors.dart';

class AppTheme {
  static TextTheme textTheme(Color textColor, Color buttonTextColor) {
    return TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        height: 1.2.h,
        color: textColor,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        height: 1.2.h,
        color: textColor,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1.2.h,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        height: 1.4.h,
        color: textColor,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.2.h,
        color: buttonTextColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        height: 1.4.h,
        color: AppSharedColors.mutedText,
      ),
    );
  }

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppLightColors.background,
    primaryColor: AppLightColors.primary,
    focusColor: AppLightColors.activeBorderColor,
    hintColor: AppLightColors.hintColor,
    colorScheme: ColorScheme.light(
      primary: AppLightColors.primary,
      secondary: AppLightColors.accent,
      error: AppSharedColors.error,
      outline: AppLightColors. borderColor,
    ),
    textTheme: textTheme(AppLightColors.mainText, AppLightColors.buttonTextColor),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppDarkColors.background,
    focusColor: AppDarkColors.activeBorderColor,
    hintColor: AppDarkColors.hintColor,
    primaryColor: AppDarkColors.primary,
    colorScheme: ColorScheme.dark(
      outline: AppDarkColors. borderColor,
      primary: AppDarkColors.primary,
      secondary: AppDarkColors.accent,
      error: AppSharedColors.error,
    ),
    textTheme: textTheme(AppDarkColors.mainText, AppDarkColors.buttonTextColor),
  );
}