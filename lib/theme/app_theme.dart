import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ================= BASE TYPOGRAPHY =================
  static final TextTheme baseText = GoogleFonts.poppinsTextTheme();

  // ================= LIGHT THEME =================
  static ThemeData light = ThemeData(
    brightness: Brightness.light,

    //pengaturan warna global
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1565C0),
      secondary: Color(0xFF42A5F5),
      surface: Colors.white,
    ),

    //ini untuk warna scaffold mode terang
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),

    //pengaturan warna appbar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1565C0),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    //pengaturan warna card
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    //ini untuk dialog
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: AppTheme.baseText.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      contentTextStyle: AppTheme.baseText.bodyMedium?.copyWith(
        fontSize: 14,
        color: Colors.black87,
      ),
    ),

    //pengaturan font tulisan aplikasi
    textTheme: baseText.copyWith(
      titleLarge: baseText.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodyMedium: baseText.bodyMedium?.copyWith(
        fontSize: 14,
        color: Colors.black87,
      ),
      bodySmall: baseText.bodySmall?.copyWith(fontSize: 12, color: Colors.grey),
    ),
  );

  // ================= DARK THEME =================
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,

    //pengaturan warna global
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 6, 6, 249),
      secondary: Color.fromARGB(255, 0, 28, 244),
      surface: Color(0xFF1E1E1E),
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),

    //pengaturan warna appbar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 12, 0, 150),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    //pengaturan warna card
    cardTheme: CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: AppTheme.baseText.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      contentTextStyle: AppTheme.baseText.bodyMedium?.copyWith(
        fontSize: 14,
        color: Colors.white70,
      ),
    ),

    //pengaturan font tulisan
    textTheme: baseText.copyWith(
      titleLarge: baseText.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: baseText.bodyMedium?.copyWith(
        fontSize: 14,
        color: Colors.white70,
      ),
      bodySmall: baseText.bodySmall?.copyWith(fontSize: 12, color: Colors.grey),
    ),
  );
}
