import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/utils.dart';

const themeSeedColor = Color(0xFF0D1B2A);

final appThemeMode = ThemeMode.dark;

final appTheme = _applyFont(
  ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: themeSeedColor,
    ),
  ),
);

ThemeData _applyFont(ThemeData themeData) {
  themeData = themeData.copyWith(
    textTheme: GoogleFonts.interTextTheme(themeData.textTheme),
  );

  TextStyle fontFallback(TextStyle? style) {
    style = style ?? TextStyle();
    return style.copyWith(
      letterSpacing: 0.5,
      fontFamilyFallback: [
        ...style.fontFamilyFallback ?? [],
        "Segoe UI",
        'sans-serif',
        "Helvetica Neue",
        "Roboto",
        "Arial",
        "system-ui",
        "-apple-system",
        "BlinkMacSystemFont",
      ],
    );
  }

  return themeData.copyWith(
    textTheme: themeData.textTheme.copyWith(
      displayLarge: fontFallback(themeData.textTheme.displayLarge),
      displayMedium: fontFallback(themeData.textTheme.displayMedium),
      displaySmall: fontFallback(themeData.textTheme.displaySmall),
      headlineLarge: fontFallback(themeData.textTheme.headlineLarge),
      headlineMedium: fontFallback(themeData.textTheme.headlineMedium),
      headlineSmall: fontFallback(themeData.textTheme.headlineSmall),
      titleLarge: fontFallback(themeData.textTheme.titleLarge),
      titleMedium: fontFallback(themeData.textTheme.titleMedium),
      titleSmall: fontFallback(themeData.textTheme.titleSmall),
      bodyLarge: fontFallback(themeData.textTheme.bodyLarge),
      bodyMedium: fontFallback(themeData.textTheme.bodyMedium),
      bodySmall: fontFallback(themeData.textTheme.bodySmall),
      labelLarge: fontFallback(themeData.textTheme.labelLarge),
      labelMedium: fontFallback(themeData.textTheme.labelMedium),
      labelSmall: fontFallback(themeData.textTheme.labelSmall),
    ),
  );
}

//

const backgroundGradient = SweepGradient(
  colors: [
    Color(0xFF060F17),
    Color(0xFF0A131B),
    Color(0xFF0C1923),
    // Color(0xFF1B314B),
    Color(0xFF0C1923),
    Color(0xFF0A131B),
    Color(0xFF060F17),
  ],
);

final wideContainerBorderColor = Colors.white.withValues(alpha: 0.1);
const containerLeftBackgroundColor = Color(0xFF060D1A);
const containerRightBackgroundColor = Color(0xFF04070F);

const titleColor = Color(0xFF6488B0);

final copyrightIconColor = containerLeftBackgroundColor.contrastWB().withValues(alpha: 0.1);

const wordCloudColors = [
  titleColor,
  Color(0xFF5A7CA5),
  Color(0xFF7C9DB8),
  Color(0xFF8893B5),
  Color(0xFF8BADD1),
  Color(0xFFA3BFE2),
  Color(0xFF4C9CA8),
  Color(0xFF69B0C6),
  Color(0xFF7FD0D9),
  Color(0xFF9BA6B5),
  Color(0xFFC3CBD8),
  Color(0xFFD8DDE5),

  // Color(0xFFE57373),
  // Color(0xFFFF5252),
  // Color(0xFFF06292),
  // Color(0xFFFF4081),
  // Color(0xFFBA68C8),
  // Color(0xFFAED581),
  // Color(0xFFEEFF41),
  // Color(0xFFFFF176),
  // Color(0xFFFFD740),
  // Color(0xFFFFB74D),
  // Color(0xFFFF6E40),
  // Color(0xFFA1887F),
  // Color(0xFFFFCDD2),
  // Color(0xFFFFDAB9),
  // Color(0xFFC8E6C9),
  // Color(0xFFFFF9C4),
  // Color(0xFFE1BEE7),
  // Color(0xFFFFCCBC),
  // Color(0xFFDCEDC8),
  // Color(0xFFB2EBF2),
  // Color(0xFFFAFAFA),
];

final longTextStyle = (appTheme.textTheme.bodyMedium ?? const TextStyle()).copyWith(
  color: const Color(0xFFB0BEC5),
  fontSize: 20,
  height: 1.7,
);
