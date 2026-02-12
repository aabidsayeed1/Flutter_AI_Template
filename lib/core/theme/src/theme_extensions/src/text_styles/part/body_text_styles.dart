part of '../text_styles.dart';

/// Body/Page content text styles
abstract class BodyTextStyles {
  const BodyTextStyles();

  TextStyle get heading;
  TextStyle get subheading;
  TextStyle get body;
  TextStyle get caption;
}

class _LightBodyTextStyles extends BodyTextStyles {
  const _LightBodyTextStyles();

  @override
  TextStyle get heading => _Primitive.headlineMedium;

  @override
  TextStyle get subheading => _Primitive.titleMedium;

  @override
  TextStyle get body => _Primitive.bodyMedium;

  @override
  TextStyle get caption => _Primitive.caption;
}

class _DarkBodyTextStyles extends BodyTextStyles {
  const _DarkBodyTextStyles();

  @override
  TextStyle get heading => _Primitive.headlineMedium;

  @override
  TextStyle get subheading => _Primitive.titleMedium;

  @override
  TextStyle get body => _Primitive.bodyMedium;

  @override
  TextStyle get caption => _Primitive.caption;
}
