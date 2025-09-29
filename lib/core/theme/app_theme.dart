import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.lightBlueColor,
      scaffoldBackgroundColor: AppColors.biegeColor,
      fontFamily: 'SuseMono',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.biegeColor,
        foregroundColor: AppColors.greyishBlackColor,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.whiteColor,
        elevation: 4,
        shadowColor: AppColors.lightBlueColor.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlueColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 2,
          shadowColor: AppColors.lightBlueColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.whiteColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.lightBlueColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.lightGrey.withValues(alpha: 0.3),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.greyishBlackColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'SuseMono',
        ),
        headlineMedium: TextStyle(
          color: AppColors.greyishBlackColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'SuseMono',
        ),
        bodyLarge: TextStyle(
          color: AppColors.greyishBlackColor,
          fontSize: 16,
          fontFamily: 'SuseMono',
        ),
        bodyMedium: TextStyle(
          color: AppColors.greyColor,
          fontSize: 14,
          fontFamily: 'SuseMono',
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.lightBlueColor,
        selectionColor: AppColors.lightBlueColor.withValues(alpha: 0.2),
        selectionHandleColor: AppColors.lightBlueColor,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightBlueColor;
          }
          return AppColors.lightGrey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightBlueColor.withValues(alpha: 0.3);
          }
          return AppColors.lightGrey.withValues(alpha: 0.3);
        }),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.lightBlueColor,
      scaffoldBackgroundColor: AppColors.greyishBlackColor,
      fontFamily: 'SuseMono',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.greyishBlackColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.blackColor.withValues(alpha: 0.4),
        elevation: 4,
        shadowColor: AppColors.lightBlueColor.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlueColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 2,
          shadowColor: AppColors.lightBlueColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.blackColor.withValues(alpha: 0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.lightBlueColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.lightGrey.withValues(alpha: 0.2),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'SuseMono',
        ),
        headlineMedium: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'SuseMono',
        ),
        bodyLarge: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 16,
          fontFamily: 'SuseMono',
        ),
        bodyMedium: TextStyle(
          color: AppColors.lightGrey,
          fontSize: 14,
          fontFamily: 'SuseMono',
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightBlueColor;
          }
          return AppColors.lightGrey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightBlueColor.withValues(alpha: 0.3);
          }
          return AppColors.lightGrey.withValues(alpha: 0.2);
        }),
      ),
    );
  }
}
