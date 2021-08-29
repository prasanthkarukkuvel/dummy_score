import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFFBB86FC);
  static const accentColor = Color(0xFF00C4B4);
  static const backgroundColor = Color(0xFF121212);
  static const onPrimary = Colors.black;

  static MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }

  static final darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: createMaterialColor(primaryColor),
            accentColor: accentColor,
            backgroundColor: backgroundColor,
            brightness: Brightness.dark)
        .copyWith(
      secondary: accentColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    accentColor: accentColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: onPrimary,
        primary: primaryColor,
      ),
    ),
  );

  static TextStyle? lightHeading5(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline5
        ?.copyWith(fontWeight: FontWeight.w300);
  }
}
