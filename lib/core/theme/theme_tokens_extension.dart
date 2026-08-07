import 'package:flutter/material.dart';

import 'tokens/tokens.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final ColorTokensBase colors;
  final GradientTokensBase gradients;
  final ShadowTokensBase shadows;
  final SpacingTokens spacing;
  final RadiusTokens radius;
  final TypographyTokens typography;
  final DimensionTokens dimensions;
  final ElevationTokens elevations;

  const AppThemeExtension({
    required this.colors,
    required this.gradients,
    required this.shadows,
    required this.spacing,
    required this.radius,
    required this.typography,
    required this.dimensions,
    required this.elevations,
  });

  @override
  AppThemeExtension copyWith({
    ColorTokensBase? colors,
    GradientTokensBase? gradients,
    ShadowTokensBase? shadows,
    SpacingTokens? spacing,
    RadiusTokens? radius,
    TypographyTokens? typography,
    DimensionTokens? dimensions,
    ElevationTokens? elevations,
  }) {
    return AppThemeExtension(
      colors: colors ?? this.colors,
      gradients: gradients ?? this.gradients,
      shadows: shadows ?? this.shadows,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      typography: typography ?? this.typography,
      dimensions: dimensions ?? this.dimensions,
      elevations: elevations ?? this.elevations,
    );
  }

  @override
  AppThemeExtension lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return t < 0.5 ? this : other;
  }

  static const AppThemeExtension light = AppThemeExtension(
    colors: LightColorTokens(),
    gradients: LightGradientTokens(),
    shadows: LightShadowTokens(),
    spacing: SpacingTokens(),
    radius: RadiusTokens(),
    typography: TypographyTokens(),
    dimensions: DimensionTokens(),
    elevations: ElevationTokens(),
  );

  static const AppThemeExtension dark = AppThemeExtension(
    colors: DarkColorTokens(),
    gradients: DarkGradientTokens(),
    shadows: DarkShadowTokens(),
    spacing: SpacingTokens(),
    radius: RadiusTokens(),
    typography: TypographyTokens(),
    dimensions: DimensionTokens(),
    elevations: ElevationTokens(),
  );

  static const AppThemeExtension aurora = AppThemeExtension(
    colors: AuroraColorTokens(),
    gradients: AuroraGradientTokens(),
    shadows: AuroraShadowTokens(),
    spacing: SpacingTokens(),
    radius: RadiusTokens(),
    typography: TypographyTokens(),
    dimensions: DimensionTokens(),
    elevations: ElevationTokens(),
  );
}
