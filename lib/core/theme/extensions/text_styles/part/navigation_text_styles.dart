part of '../text_styles.dart';

/// Navigation (BottomNavBar) text styles
abstract class NavigationTextStyles {
  const NavigationTextStyles();

  TextStyle get label;
}

class _LightNavigationTextStyles extends NavigationTextStyles {
  const _LightNavigationTextStyles();

  @override
  TextStyle get label => _Primitive.labelSmall;
}

class _DarkNavigationTextStyles extends NavigationTextStyles {
  const _DarkNavigationTextStyles();

  @override
  TextStyle get label => _Primitive.labelSmall;
}
