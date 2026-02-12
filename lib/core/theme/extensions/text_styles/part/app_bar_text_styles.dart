part of '../text_styles.dart';

/// AppBar text styles
abstract class AppBarTextStyles {
  const AppBarTextStyles();

  TextStyle get title;
}

class _LightAppBarTextStyles extends AppBarTextStyles {
  const _LightAppBarTextStyles();

  @override
  TextStyle get title => _Primitive.titleLarge;
}

class _DarkAppBarTextStyles extends AppBarTextStyles {
  const _DarkAppBarTextStyles();

  @override
  TextStyle get title => _Primitive.titleLarge;
}
