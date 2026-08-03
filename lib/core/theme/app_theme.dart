import 'package:flutter/material.dart';

import 'theme_tokens_extension.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light =>
      _buildTheme(brightness: Brightness.light, tokens: AppThemeTokensExtension.light);

  static ThemeData get dark =>
      _buildTheme(brightness: Brightness.dark, tokens: AppThemeTokensExtension.dark);

  static ThemeData _buildTheme({
    required Brightness brightness,
    required AppThemeTokensExtension tokens,
  }) {
    final colors = tokens.colors;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.scaffoldBackground,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onPrimary,
        error: colors.error,
        onError: colors.onPrimary,
        surface: colors.surface,
        onSurface: colors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        elevation: 1,
        centerTitle: false,
        backgroundColor: colors.appBarBackground,
        foregroundColor: colors.appBarIcon,
        surfaceTintColor: colors.appBarSurfaceTint,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0.5,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colors.bottomNavSelected,
        unselectedItemColor: colors.bottomNavUnselected,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: const StadiumBorder(),
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.infinity, 48),
          shape: const StadiumBorder(),
          side: BorderSide(color: colors.primary, width: 2),
          foregroundColor: colors.primary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colors.textSecondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        hintStyle: TextStyle(color: colors.textSecondary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: colors.border, width: 1),
        ),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        suffixIconColor: colors.icon,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: colors.border, width: 1),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(width: 1.25, color: colors.border),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.scaffoldBackground;
        }),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.onPrimary;
          }
          return colors.border;
        }),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.primary),
      iconTheme: IconThemeData(color: colors.icon),
      extensions: <ThemeExtension<dynamic>>[tokens],
    );
  }
}
