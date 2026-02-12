part of 'colors.dart';

class LightColorExtension extends ThemeExtension<LightColorExtension>
    implements ColorExtension {
  const LightColorExtension({
    this.border = _Primitive.neutral20,
    this.icon = _Primitive.neutral0,
    this.onPrimary = _Primitive.neutral0,
    this.primary = _Primitive.primary,
    this.scaffoldBackground = _Primitive.neutral10,
    this.success = _Primitive.success,
    this.error = _Primitive.error,
    this.warning = _Primitive.warning,
    this.info = _Primitive.info,
    this.disabled = _Primitive.neutral20,
    this.active = _Primitive.primary,
    this.inactive = _Primitive.neutral30,
    this.secondary = _Primitive.secondary,
    this.accent = _Primitive.accent,
    this.backgroundLight = _Primitive.backgroundLight,
    this.backgroundDark = _Primitive.backgroundDark,
    this.textPrimaryLight = _Primitive.textPrimaryLight,
    this.textPrimaryDark = _Primitive.textPrimaryDark,
    this.textSecondary = _Primitive.textSecondary,
    this.appBar = const _LightAppBarColors(),
    this.bottomNavBar = const _LightBottomNavBarColors(),
    this.pageView = const _LightPageViewColors(),
    this.text = const _LightTextColors(),
  });

  @override
  final Color border;

  @override
  final Color icon;

  @override
  final Color onPrimary;

  @override
  final Color primary;

  @override
  final Color scaffoldBackground;

  @override
  final AppBarColors appBar;

  @override
  final BottomNavBarColors bottomNavBar;

  @override
  final PageViewColors pageView;

  @override
  final TextColors text;

  @override
  final Color success;

  @override
  final Color error;

  @override
  final Color warning;

  @override
  final Color info;

  @override
  final Color disabled;

  @override
  final Color active;

  @override
  final Color inactive;

  @override
  final Color secondary;

  @override
  final Color accent;

  @override
  final Color backgroundLight;

  @override
  final Color backgroundDark;

  @override
  final Color textPrimaryLight;

  @override
  final Color textPrimaryDark;

  @override
  final Color textSecondary;

  @override
  LightColorExtension copyWith({
    Color? border,
    Color? icon,
    Color? onPrimary,
    Color? primary,
    Color? scaffoldBackground,
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
    Color? disabled,
    Color? active,
    Color? inactive,
    Color? secondary,
    Color? accent,
    Color? backgroundLight,
    Color? backgroundDark,
    Color? textPrimaryLight,
    Color? textPrimaryDark,
    Color? textSecondary,
    AppBarColors? appBar,
    BottomNavBarColors? bottomNavBar,
    PageViewColors? pageView,
    TextColors? text,
  }) {
    return LightColorExtension(
      border: border ?? this.border,
      icon: icon ?? this.icon,
      onPrimary: onPrimary ?? this.onPrimary,
      primary: primary ?? this.primary,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      disabled: disabled ?? this.disabled,
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      backgroundLight: backgroundLight ?? this.backgroundLight,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      textPrimaryLight: textPrimaryLight ?? this.textPrimaryLight,
      textPrimaryDark: textPrimaryDark ?? this.textPrimaryDark,
      textSecondary: textSecondary ?? this.textSecondary,
      appBar: appBar ?? this.appBar,
      bottomNavBar: bottomNavBar ?? this.bottomNavBar,
      pageView: pageView ?? this.pageView,
      text: text ?? this.text,
    );
  }

  @override
  ThemeExtension<LightColorExtension> lerp(
    covariant ThemeExtension<LightColorExtension>? other,
    double t,
  ) {
    if (other is! LightColorExtension) {
      return this;
    }

    return LightColorExtension(
      border: Color.lerp(border, other.border, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      scaffoldBackground: Color.lerp(
        scaffoldBackground,
        other.scaffoldBackground,
        t,
      )!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      active: Color.lerp(active, other.active, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      backgroundLight: Color.lerp(backgroundLight, other.backgroundLight, t)!,
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t)!,
      textPrimaryLight: Color.lerp(
        textPrimaryLight,
        other.textPrimaryLight,
        t,
      )!,
      textPrimaryDark: Color.lerp(textPrimaryDark, other.textPrimaryDark, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      // Complex objects are harder to lerp, so we'll just use whichever is
      // appropriate based on animation progress
      appBar: t < 0.5 ? appBar : other.appBar,
      bottomNavBar: t < 0.5 ? bottomNavBar : other.bottomNavBar,
      pageView: t < 0.5 ? pageView : other.pageView,
      text: t < 0.5 ? text : other.text,
    );
  }
}

class DarkColorExtension extends ThemeExtension<DarkColorExtension>
    implements ColorExtension {
  const DarkColorExtension({
    this.border = _Primitive.neutral30,
    this.icon = _Primitive.neutral0,
    this.onPrimary = _Primitive.neutral90,
    this.primary = _Primitive.primary,
    this.scaffoldBackground = _Primitive.neutral60,
    this.success = _Primitive.success,
    this.error = _Primitive.error,
    this.warning = _Primitive.warning,
    this.info = _Primitive.info,
    this.disabled = _Primitive.neutral20,
    this.active = _Primitive.primary,
    this.inactive = _Primitive.neutral30,
    this.secondary = _Primitive.secondary,
    this.accent = _Primitive.accent,
    this.backgroundLight = _Primitive.backgroundLight,
    this.backgroundDark = _Primitive.backgroundDark,
    this.textPrimaryLight = _Primitive.textPrimaryLight,
    this.textPrimaryDark = _Primitive.textPrimaryDark,
    this.textSecondary = _Primitive.textSecondary,
    this.appBar = const _DarkAppBarColors(),
    this.bottomNavBar = const _DarkBottomNavBarColors(),
    this.pageView = const _DarkPageViewColors(),
    this.text = const _DarkTextColors(),
  });

  @override
  final Color border;

  @override
  final Color icon;

  @override
  final Color onPrimary;

  @override
  final Color primary;

  @override
  final Color scaffoldBackground;

  @override
  final AppBarColors appBar;

  @override
  final BottomNavBarColors bottomNavBar;

  @override
  final PageViewColors pageView;

  @override
  final TextColors text;

  @override
  final Color success;

  @override
  final Color error;

  @override
  final Color warning;

  @override
  final Color info;

  @override
  final Color disabled;

  @override
  final Color active;

  @override
  final Color inactive;

  @override
  final Color secondary;

  @override
  final Color accent;

  @override
  final Color backgroundLight;

  @override
  final Color backgroundDark;

  @override
  final Color textPrimaryLight;

  @override
  final Color textPrimaryDark;

  @override
  final Color textSecondary;

  @override
  DarkColorExtension copyWith({
    Color? border,
    Color? icon,
    Color? onPrimary,
    Color? primary,
    Color? scaffoldBackground,
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
    Color? disabled,
    Color? active,
    Color? inactive,
    Color? secondary,
    Color? accent,
    Color? backgroundLight,
    Color? backgroundDark,
    Color? textPrimaryLight,
    Color? textPrimaryDark,
    Color? textSecondary,
    AppBarColors? appBar,
    BottomNavBarColors? bottomNavBar,
    PageViewColors? pageView,
    TextColors? text,
  }) {
    return DarkColorExtension(
      border: border ?? this.border,
      icon: icon ?? this.icon,
      onPrimary: onPrimary ?? this.onPrimary,
      primary: primary ?? this.primary,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      disabled: disabled ?? this.disabled,
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      backgroundLight: backgroundLight ?? this.backgroundLight,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      textPrimaryLight: textPrimaryLight ?? this.textPrimaryLight,
      textPrimaryDark: textPrimaryDark ?? this.textPrimaryDark,
      textSecondary: textSecondary ?? this.textSecondary,
      appBar: appBar ?? this.appBar,
      bottomNavBar: bottomNavBar ?? this.bottomNavBar,
      pageView: pageView ?? this.pageView,
      text: text ?? this.text,
    );
  }

  @override
  ThemeExtension<DarkColorExtension> lerp(
    covariant ThemeExtension<DarkColorExtension>? other,
    double t,
  ) {
    if (other is! DarkColorExtension) {
      return this;
    }

    return DarkColorExtension(
      border: Color.lerp(border, other.border, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      scaffoldBackground: Color.lerp(
        scaffoldBackground,
        other.scaffoldBackground,
        t,
      )!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      active: Color.lerp(active, other.active, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      backgroundLight: Color.lerp(backgroundLight, other.backgroundLight, t)!,
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t)!,
      textPrimaryLight: Color.lerp(
        textPrimaryLight,
        other.textPrimaryLight,
        t,
      )!,
      textPrimaryDark: Color.lerp(textPrimaryDark, other.textPrimaryDark, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      // Complex objects are harder to lerp, so we'll just use whichever is
      // appropriate based on animation progress
      appBar: t < 0.5 ? appBar : other.appBar,
      bottomNavBar: t < 0.5 ? bottomNavBar : other.bottomNavBar,
      pageView: t < 0.5 ? pageView : other.pageView,
      text: t < 0.5 ? text : other.text,
    );
  }
}
