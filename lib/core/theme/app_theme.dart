import 'package:flutter/material.dart';

import 'responsive/design_sizes.dart';
import 'responsive/responsive_value.dart';
import 'tokens/tokens.dart';
import 'theme_tokens_extension.dart';

export 'context_extensions.dart';
export 'responsive/design_sizes.dart';
export 'theme_tokens_extension.dart';
export 'tokens/tokens.dart';

class AppTheme {
  static const SpacingTokens spacing = SpacingTokens();
  static const RadiusTokens radius = RadiusTokens();
  static const TypographyTokens typography = TypographyTokens();
  static const DimensionTokens dimensions = DimensionTokens();
  static const ElevationTokens elevations = ElevationTokens();

  static const Size mobileDesignSize = AppDesignSizes.mobile;

  static final ThemeData light = _buildTheme(
    tokens: AppThemeExtension.light,
    brightness: Brightness.light,
  );

  static final ThemeData dark = _buildTheme(
    tokens: AppThemeExtension.dark,
    brightness: Brightness.dark,
  );

  static final ThemeData aurora = _buildTheme(
    tokens: AppThemeExtension.aurora,
    brightness: Brightness.light,
  );

  static final Map<String, ThemeData> themes = {
    'light': light,
    'dark': dark,
    'aurora': aurora,
  };

  static ThemeData theme(String themeName) => themes[themeName] ?? themes.values.first;

  static Size designSize(BuildContext context) {
    return ResponsiveValue<Size>(
      mobile: AppDesignSizes.mobile,
      tablet: AppDesignSizes.tablet,
      desktop: AppDesignSizes.desktop,
    ).resolve(context);
  }

  static ThemeData _buildTheme({
    required AppThemeExtension tokens,
    required Brightness brightness,
  }) {
    final colors = tokens.colors;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.scaffold,
      colorScheme: brightness == Brightness.dark
          ? ColorScheme.dark(
              primary: colors.primary,
              surface: colors.surface,
              error: colors.error,
            )
          : ColorScheme.light(
              primary: colors.primary,
              surface: colors.surface,
              error: colors.error,
            ),
      appBarTheme: AppBarTheme(
        elevation: 1,
        centerTitle: false,
        backgroundColor: colors.navBar,
        foregroundColor: colors.icon,
        surfaceTintColor: colors.navBar,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0.5,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colors.navBarActive,
        unselectedItemColor: colors.navBarInactive,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: StadiumBorder(
            side: BorderSide(color: colors.buttonPrimary, width: 2),
          ),
          backgroundColor: colors.buttonPrimary,
          foregroundColor: colors.textOnPrimary,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.infinity, 48),
          shape: StadiumBorder(
            side: BorderSide(color: colors.buttonPrimary, width: 2),
          ),
          foregroundColor: colors.buttonPrimary,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.textSecondary,
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        hintStyle: TextStyle(color: colors.placeholder, fontSize: 14),
        fillColor: colors.inputBackground,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.inputBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.inputFocus, width: 1.5),
        ),
        suffixIconColor: colors.icon,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors.inputBorder, width: 1),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(width: 1.25, color: colors.border),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.scaffold;
        }),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.textOnPrimary;
          }
          return colors.border;
        }),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.primary),
      dividerTheme: DividerThemeData(color: colors.divider),
      iconTheme: IconThemeData(color: colors.icon),
      extensions: [
        tokens,
      ],
    );
  }
}
