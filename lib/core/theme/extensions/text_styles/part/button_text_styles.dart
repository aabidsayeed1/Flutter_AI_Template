part of '../text_styles.dart';

/// Button text styles
abstract class ButtonTextStyles {
  const ButtonTextStyles();

  TextStyle get primary;
  TextStyle get secondary;
}

class _LightButtonTextStyles extends ButtonTextStyles {
  const _LightButtonTextStyles();

  @override
  TextStyle get primary => _Primitive.labelLarge;

  @override
  TextStyle get secondary => _Primitive.labelMedium;
}

class _DarkButtonTextStyles extends ButtonTextStyles {
  const _DarkButtonTextStyles();

  @override
  TextStyle get primary => _Primitive.labelLarge;

  @override
  TextStyle get secondary => _Primitive.labelMedium;
}
