// // constants.dart
// import 'package:flutter/material.dart';
//
// class AppConstants {
//   static const String roboflowApiKey = 'vx1G50Zwi0MOrqXNCvGk';
//   static const String roboflowModelUrl = 'https://detect.roboflow.com/lovebirds_lens/1';
//   static const String roboflowProjectUrl = 'https://app.roboflow.com/fida-hussain-awan-3wjxj/lovebirds_lens/models/lovebirds_lens/1';
// }
//
// class AppColors {
//   static const Color primaryGreen = Color(0xFF4CAF50);
//   static const Color lightGreen = Color(0xFF8BC34A);
//   static const Color darkGreen = Color(0xFF2E7D32);
//   static const Color backgroundColor = Color(0xFF121212);
//   static const Color cardColor = Color(0xFF1E1E1E);
//   static const Color textLight = Color(0xFFFFFFFF);
//   static const Color textDark = Color(0xFF000000);
//   static const Color grey = Color(0xFF757575);
// }
//
// class AppThemes {
//   static final ThemeData lightTheme = ThemeData(
//     primarySwatch: Colors.green,
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: Colors.white,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColors.primaryGreen,
//       foregroundColor: Colors.white,
//       elevation: 0,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryGreen,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       ),
//     ),
//     cardTheme: CardTheme(
//       color: Colors.white,
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//     ),
//   );
//
//   static final ThemeData darkTheme = ThemeData(
//     primarySwatch: Colors.green,
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: AppColors.backgroundColor,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColors.backgroundColor,
//       foregroundColor: AppColors.textLight,
//       elevation: 0,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryGreen,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       ),
//     ),
//     cardTheme: CardTheme(
//       color: AppColors.cardColor,
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//     ),
//   );
// }

// constants.dart
import 'package:flutter/material.dart';

class AppConstants {
  static const String roboflowApiKey = 'vx1G50Zwi0MOrqXNCvGk';
  static const String roboflowModelUrl = 'https://detect.roboflow.com/lovebirds_lens/1';
  static const String roboflowProjectUrl = 'https://app.roboflow.com/fida-hussain-awan-3wjxj/lovebirds_lens/models/lovebirds_lens/1';
}

class AppColors {
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xFF8BC34A);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF000000);
  static const Color grey = Color(0xFF757575);
}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    ),
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: AppColors.textLight,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );
}