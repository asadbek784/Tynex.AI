import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color secondaryGrey = Color(0xFF1A1A1A);
  static const Color accentGrey = Color(0xFF2C2C2C);
  static const Color textGrey = Color(0xFFAAAAAA);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryBlack,
    colorScheme: const ColorScheme.dark(
      primary: primaryWhite,
      onPrimary: primaryBlack,
      secondary: secondaryGrey,
      onSecondary: primaryWhite,
      surface: secondaryGrey,
      onSurface: primaryWhite,
      background: primaryBlack,
      onBackground: primaryWhite,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
      displayLarge: TextStyle(color: primaryWhite, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: primaryWhite, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: primaryWhite),
      bodyMedium: TextStyle(color: textGrey),
    )),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlack,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryWhite),
      titleTextStyle: TextStyle(color: primaryWhite, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: primaryBlack,
      elevation: 0,
    ),
  );
}
