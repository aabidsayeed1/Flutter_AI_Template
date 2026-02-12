part of 'text_styles.dart';

/// Light theme text style extension
class LightTextStyleExtension extends ThemeExtension<LightTextStyleExtension>
    implements TextStyleExtension {
  const LightTextStyleExtension({
    this.appBar = const _LightAppBarTextStyles(),
    this.button = const _LightButtonTextStyles(),
    this.navigation = const _LightNavigationTextStyles(),
    this.body = const _LightBodyTextStyles(),
  });

  @override
  final AppBarTextStyles appBar;

  @override
  final ButtonTextStyles button;

  @override
  final NavigationTextStyles navigation;

  @override
  final BodyTextStyles body;

  @override
  TextStyle get headlineLarge => _Primitive.headlineLarge;

  @override
  TextStyle get headlineMedium => _Primitive.headlineMedium;

  @override
  TextStyle get headlineSmall => _Primitive.headlineSmall;

  @override
  TextStyle get titleLarge => _Primitive.titleLarge;

  @override
  TextStyle get titleMedium => _Primitive.titleMedium;

  @override
  TextStyle get titleSmall => _Primitive.titleSmall;

  @override
  TextStyle get bodyLarge => _Primitive.bodyLarge;

  @override
  TextStyle get bodyMedium => _Primitive.bodyMedium;

  @override
  TextStyle get bodySmall => _Primitive.bodySmall;

  @override
  TextStyle get labelLarge => _Primitive.labelLarge;

  @override
  TextStyle get labelMedium => _Primitive.labelMedium;

  @override
  TextStyle get labelSmall => _Primitive.labelSmall;

  @override
  TextStyle get caption => _Primitive.caption;

  @override
  ThemeExtension<LightTextStyleExtension> copyWith({
    AppBarTextStyles? appBar,
    ButtonTextStyles? button,
    NavigationTextStyles? navigation,
    BodyTextStyles? body,
  }) => LightTextStyleExtension(
    appBar: appBar ?? this.appBar,
    button: button ?? this.button,
    navigation: navigation ?? this.navigation,
    body: body ?? this.body,
  );

  @override
  ThemeExtension<LightTextStyleExtension> lerp(
    ThemeExtension<LightTextStyleExtension>? other,
    double t,
  ) {
    if (other is! LightTextStyleExtension) {
      return this;
    }
    return other;
  }
}

/// Dark theme text style extension
class DarkTextStyleExtension extends ThemeExtension<DarkTextStyleExtension>
    implements TextStyleExtension {
  const DarkTextStyleExtension({
    this.appBar = const _DarkAppBarTextStyles(),
    this.button = const _DarkButtonTextStyles(),
    this.navigation = const _DarkNavigationTextStyles(),
    this.body = const _DarkBodyTextStyles(),
  });

  @override
  final AppBarTextStyles appBar;

  @override
  final ButtonTextStyles button;

  @override
  final NavigationTextStyles navigation;

  @override
  final BodyTextStyles body;

  @override
  TextStyle get headlineLarge => _Primitive.headlineLarge;

  @override
  TextStyle get headlineMedium => _Primitive.headlineMedium;

  @override
  TextStyle get headlineSmall => _Primitive.headlineSmall;

  @override
  TextStyle get titleLarge => _Primitive.titleLarge;

  @override
  TextStyle get titleMedium => _Primitive.titleMedium;

  @override
  TextStyle get titleSmall => _Primitive.titleSmall;

  @override
  TextStyle get bodyLarge => _Primitive.bodyLarge;

  @override
  TextStyle get bodyMedium => _Primitive.bodyMedium;

  @override
  TextStyle get bodySmall => _Primitive.bodySmall;

  @override
  TextStyle get labelLarge => _Primitive.labelLarge;

  @override
  TextStyle get labelMedium => _Primitive.labelMedium;

  @override
  TextStyle get labelSmall => _Primitive.labelSmall;

  @override
  TextStyle get caption => _Primitive.caption;

  @override
  ThemeExtension<DarkTextStyleExtension> copyWith({
    AppBarTextStyles? appBar,
    ButtonTextStyles? button,
    NavigationTextStyles? navigation,
    BodyTextStyles? body,
  }) => DarkTextStyleExtension(
    appBar: appBar ?? this.appBar,
    button: button ?? this.button,
    navigation: navigation ?? this.navigation,
    body: body ?? this.body,
  );

  @override
  ThemeExtension<DarkTextStyleExtension> lerp(
    ThemeExtension<DarkTextStyleExtension>? other,
    double t,
  ) {
    if (other is! DarkTextStyleExtension) {
      return this;
    }
    return other;
  }
}
