import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_light_colors.dart';
import 'app_dark_colors.dart';
import 'app_shared_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppLightColors.background,
    primaryColor: AppLightColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppLightColors.primary,
      secondary: AppLightColors.accent,
      error: AppSharedColors.error,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: AppLightColors.mainText,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: AppLightColors.mainText,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: AppLightColors.mainText,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.4,
        color: AppLightColors.mainText,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: AppLightColors.mainText,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.4,
        color: AppSharedColors.mutedText,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppDarkColors.background,
    primaryColor: AppDarkColors.primary,
    colorScheme: ColorScheme.dark(
      primary: AppDarkColors.primary,
      secondary: AppDarkColors.accent,
      error: AppSharedColors.error,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: AppDarkColors.mainText,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: AppDarkColors.mainText,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: AppDarkColors.mainText,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.4,
        color: AppDarkColors.mainText,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: AppDarkColors.mainText,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.4,
        color: AppSharedColors.mutedText,
      ),
    ),
  );
}