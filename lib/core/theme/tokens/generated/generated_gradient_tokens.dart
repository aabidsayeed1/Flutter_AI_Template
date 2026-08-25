import 'package:flutter/material.dart';

import '../../theme_tokens_extension.dart';

abstract class GeneratedThemeGradientTokens {
  const GeneratedThemeGradientTokens();
  Gradient brandLinear(BuildContext context);
  Gradient surfaceRadial(BuildContext context);
  Gradient statusSweep(BuildContext context);
}

class GeneratedLightGradientTokens extends GeneratedThemeGradientTokens {
  const GeneratedLightGradientTokens();
  @override
  Gradient brandLinear(BuildContext context) {
    return LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.primary, Theme.of(context).extension<AppThemeExtension>()!.colors.secondary]);
  }
  @override
  Gradient surfaceRadial(BuildContext context) {
    return RadialGradient(center: Alignment.center, radius: 1.15, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.surface, Theme.of(context).extension<AppThemeExtension>()!.colors.primaryLight]);
  }
  @override
  Gradient statusSweep(BuildContext context) {
    return SweepGradient(center: Alignment.center, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.success, Theme.of(context).extension<AppThemeExtension>()!.colors.warning, Theme.of(context).extension<AppThemeExtension>()!.colors.error, Theme.of(context).extension<AppThemeExtension>()!.colors.success], startAngle: 0.0, endAngle: 6.28318);
  }
}

class GeneratedDarkGradientTokens extends GeneratedThemeGradientTokens {
  const GeneratedDarkGradientTokens();
  @override
  Gradient brandLinear(BuildContext context) {
    return LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.primary, Theme.of(context).extension<AppThemeExtension>()!.colors.secondary]);
  }
  @override
  Gradient surfaceRadial(BuildContext context) {
    return RadialGradient(center: Alignment.center, radius: 1.15, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.surface, Theme.of(context).extension<AppThemeExtension>()!.colors.background]);
  }
  @override
  Gradient statusSweep(BuildContext context) {
    return SweepGradient(center: Alignment.center, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.success, Theme.of(context).extension<AppThemeExtension>()!.colors.warning, Theme.of(context).extension<AppThemeExtension>()!.colors.error, Theme.of(context).extension<AppThemeExtension>()!.colors.success], startAngle: 0.0, endAngle: 6.28318);
  }
}

class GeneratedAuroraGradientTokens extends GeneratedThemeGradientTokens {
  const GeneratedAuroraGradientTokens();
  @override
  Gradient brandLinear(BuildContext context) {
    return LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.primary, Theme.of(context).extension<AppThemeExtension>()!.colors.secondary]);
  }
  @override
  Gradient surfaceRadial(BuildContext context) {
    return RadialGradient(center: Alignment.center, radius: 1.15, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.surface, Theme.of(context).extension<AppThemeExtension>()!.colors.secondaryLight]);
  }
  @override
  Gradient statusSweep(BuildContext context) {
    return SweepGradient(center: Alignment.center, colors: [Theme.of(context).extension<AppThemeExtension>()!.colors.success, Theme.of(context).extension<AppThemeExtension>()!.colors.warning, Theme.of(context).extension<AppThemeExtension>()!.colors.error, Theme.of(context).extension<AppThemeExtension>()!.colors.success], startAngle: 0.0, endAngle: 6.28318);
  }
}
