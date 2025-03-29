import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.accentBlueColor,
  ),
  textTheme: GoogleFonts.urbanistTextTheme().copyWith(
    bodyLarge: GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
    ),
    bodySmall: GoogleFonts.urbanist(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4,
    ),
    titleLarge: GoogleFonts.urbanist(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.1,
    ),
    headlineSmall: GoogleFonts.urbanist(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
    ),
    labelLarge: GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.blackColor,
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.blackColor),
      minimumSize: MaterialStatePropertyAll(Size(double.infinity, 50)),
      foregroundColor: MaterialStatePropertyAll(AppColors.secondaryTextColor),
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.blackColor),
      minimumSize: MaterialStatePropertyAll(Size(double.infinity, 50)),
      foregroundColor: MaterialStatePropertyAll(AppColors.secondaryTextColor),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: AppColors.primaryColor,
    iconTheme: IconThemeData(color: AppColors.secondaryTextColor),
    foregroundColor: AppColors.secondaryTextColor,
  ),
  datePickerTheme: const DatePickerThemeData(),
);

// Extension for additional theme-related properties
extension AppThemeExtension on ThemeData {
  BoxDecoration get drawerHeaderDecoration {
    return const BoxDecoration(
      color: AppColors.primaryColor,
    );
  }
}


final ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryColor,
    secondary: AppColors.accentBlueColor,
  ),
  textTheme: GoogleFonts.urbanistTextTheme(ThemeData.dark().textTheme).copyWith(
    bodyLarge: GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
      color: Colors.white, 
    ),
  
  ),
  
);