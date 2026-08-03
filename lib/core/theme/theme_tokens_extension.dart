import 'package:flutter/material.dart';

import 'tokens/tokens.dart';

class AppThemeTokensExtension extends ThemeExtension<AppThemeTokensExtension> {
  const AppThemeTokensExtension({
    required this.colors,
    required this.spacing,
    required this.radius,
    required this.typography,
    required this.dimensions,
  });

  final GeneratedColorTokensBase colors;
  final SpacingTokens spacing;
  final RadiusTokens radius;
  final TypographyTokens typography;
  final DimensionTokens dimensions;

  @override
  AppThemeTokensExtension copyWith({
    GeneratedColorTokensBase? colors,
    SpacingTokens? spacing,
    RadiusTokens? radius,
    TypographyTokens? typography,
    DimensionTokens? dimensions,
  }) {
    return AppThemeTokensExtension(
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      typography: typography ?? this.typography,
      dimensions: dimensions ?? this.dimensions,
    );
  }

  @override
  ThemeExtension<AppThemeTokensExtension> lerp(
    covariant ThemeExtension<AppThemeTokensExtension>? other,
    double t,
  ) {
    if (other is! AppThemeTokensExtension) {
      return this;
    }

    return t < 0.5 ? this : other;
  }

  static const AppThemeTokensExtension light = AppThemeTokensExtension(
    colors: ColorTokens(),
    spacing: SpacingTokens(),
    radius: RadiusTokens(),
    typography: TypographyTokens(),
    dimensions: DimensionTokens(),
  );

  static const AppThemeTokensExtension dark = AppThemeTokensExtension(
    colors: DarkColorTokens(),
    spacing: SpacingTokens(),
    radius: RadiusTokens(),
    typography: TypographyTokens(),
    dimensions: DimensionTokens(),
  );
}
