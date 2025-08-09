// // widget_test.dart
//
// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:lovebirds_lens/main.dart';
//
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }


// widget_test.dart

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:lovebirds_lens/main.dart';
import 'package:lovebirds_lens/providers/theme_provider.dart';
import 'package:lovebirds_lens/providers/auth_provider.dart';

void main() {
  testWidgets('App launches correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MyApp(isFirstLaunch: false),
      ),
    );

    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Verify that the app launches without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Onboarding screen shows on first launch', (WidgetTester tester) async {
    // Build our app with first launch = true
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MyApp(isFirstLaunch: true),
      ),
    );

    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Verify that onboarding content is shown
    expect(find.text('Skip'), findsOneWidget);
  });

  testWidgets('Main screen shows when not first launch', (WidgetTester tester) async {
    // Build our app with first launch = false
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MyApp(isFirstLaunch: false),
      ),
    );

    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Verify that main screen content is shown (adjust based on your main screen)
    // This might be a bottom navigation bar, app bar, or other main screen elements
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('Theme toggle works', (WidgetTester tester) async {
    final themeProvider = ThemeProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MyApp(isFirstLaunch: false),
      ),
    );

    await tester.pumpAndSettle();

    // Get initial theme state
    final initialIsDark = themeProvider.isDarkTheme;

    // Toggle theme (you might need to navigate to settings first)
    themeProvider.toggleTheme();
    await tester.pump();

    // Verify theme changed
    expect(themeProvider.isDarkTheme, !initialIsDark);
  });
}