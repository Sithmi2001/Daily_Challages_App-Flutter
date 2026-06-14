// ─────────────────────────────────────────────
//  theme.dart  –  complete design system, pure Dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/challenge.dart';

abstract class AppColors {
  // Backgrounds
  static const Color bg          = Color(0xFF080B14);
  static const Color surface     = Color(0xFF0F1221);
  static const Color card        = Color(0xFF151929);
  static const Color cardHigh    = Color(0xFF1C2035);
  static const Color divider     = Color(0xFF252840);

  // Accents
  static const Color orange      = Color(0xFFFF6B35);
  static const Color orangeGlow  = Color(0xFFFF9057);
  static const Color gold        = Color(0xFFFFCC00);
  static const Color teal        = Color(0xFF00E5C3);
  static const Color lavender    = Color(0xFFA78BFA);
  static const Color rose        = Color(0xFFFF6B9D);
  static const Color sky         = Color(0xFF38BDF8);

  // Text
  static const Color textPrimary   = Color(0xFFF1F0FF);
  static const Color textSecondary = Color(0xFF8B8FA8);
  static const Color textMuted     = Color(0xFF4E5168);

  // Category palette
  static const Map<ChallengeCategory, Color> categoryColors = {
    ChallengeCategory.creative:    Color(0xFFFF6B9D),
    ChallengeCategory.physical:    Color(0xFF00E5C3),
    ChallengeCategory.social:      Color(0xFF38BDF8),
    ChallengeCategory.mindfulness: Color(0xFFA78BFA),
    ChallengeCategory.learning:    Color(0xFFFFCC00),
    ChallengeCategory.adventure:   Color(0xFFFF6B35),
  };

  static Color forCategory(ChallengeCategory cat) =>
      categoryColors[cat] ?? orange;
}

abstract class AppTextStyles {
  static TextStyle display(double size) => GoogleFonts.cormorantGaramond(
        color: AppColors.textPrimary,
        fontSize: size,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.1,
      );

  static TextStyle heading(double size) => GoogleFonts.outfit(
        color: AppColors.textPrimary,
        fontSize: size,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      );

  static TextStyle body(double size, {Color? color}) => GoogleFonts.outfit(
        color: color ?? AppColors.textSecondary,
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: 1.65,
      );

  static TextStyle label(double size, {Color? color}) => GoogleFonts.spaceGrotesk(
        color: color ?? AppColors.textMuted,
        fontSize: size,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      );

  static TextStyle mono(double size, {Color? color}) => GoogleFonts.jetBrainsMono(
        color: color ?? AppColors.textSecondary,
        fontSize: size,
        height: 1.4,
      );
}

abstract class AppDecorations {
  static BoxDecoration card({Color? borderColor}) => BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor ?? AppColors.divider,
          width: 1,
        ),
      );

  static BoxDecoration glowCard(Color accent) => BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withOpacity(0.25), width: 1),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.07),
            blurRadius: 32,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      );

  static BoxDecoration pill(Color color, {double opacity = 0.12}) =>
      BoxDecoration(
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      );

  static BoxDecoration iconBadge(Color color) => BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      );

  static LinearGradient accentGradient(Color color) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color.withOpacity(0.65)],
      );

  static BoxDecoration accentButton(Color color) => BoxDecoration(
        gradient: accentGradient(color),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.38),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      );
}

ThemeData buildAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.orange,
      secondary: AppColors.teal,
      surface: AppColors.surface,
      onPrimary: Colors.white,
      onSurface: AppColors.textPrimary,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
