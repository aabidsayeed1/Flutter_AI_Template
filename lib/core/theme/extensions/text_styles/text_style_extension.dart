part of 'text_styles.dart';

class TextStyleExtension {
  const TextStyleExtension({
    required this.appBar,
    required this.button,
    required this.navigation,
    required this.body,
  });

  final AppBarTextStyles appBar;
  final ButtonTextStyles button;
  final NavigationTextStyles navigation;
  final BodyTextStyles body;

  // Primitive text styles
  TextStyle get headlineLarge => _Primitive.headlineLarge;
  TextStyle get headlineMedium => _Primitive.headlineMedium;
  TextStyle get headlineSmall => _Primitive.headlineSmall;

  TextStyle get titleLarge => _Primitive.titleLarge;
  TextStyle get titleMedium => _Primitive.titleMedium;
  TextStyle get titleSmall => _Primitive.titleSmall;

  TextStyle get bodyLarge => _Primitive.bodyLarge;
  TextStyle get bodyMedium => _Primitive.bodyMedium;
  TextStyle get bodySmall => _Primitive.bodySmall;

  TextStyle get labelLarge => _Primitive.labelLarge;
  TextStyle get labelMedium => _Primitive.labelMedium;
  TextStyle get labelSmall => _Primitive.labelSmall;

  TextStyle get caption => _Primitive.caption;
}
