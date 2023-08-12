import 'package:flutter/material.dart';

class FlutterContactsTheme {
  static const primaryColor = Color(0xFF3F51B5);
  static const iconNameTextColor = Color(0xFFADB4DE);
  static const greyColor = Color(0xFF898989);
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xFF3F51B5),
      ),
      scaffoldBackgroundColor: Color(0xFFFAFAFA),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: const Color(0xFF13B9FF),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFF3F51B5),
        foregroundColor: Colors.white,
        hoverColor: Colors.redAccent,
        splashColor: Colors.tealAccent,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xFF13B9FF),
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: const Color(0xFF13B9FF),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
