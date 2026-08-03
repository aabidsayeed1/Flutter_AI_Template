import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'theme_tokens_extension.dart';
import 'tokens/tokens.dart';

export 'app_theme.dart';
export 'theme_tokens_extension.dart';
export 'tokens/tokens.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);

  AppThemeTokensExtension get tokens {
    final ext = _theme.extension<AppThemeTokensExtension>();

    assert(
      ext != null,
      'Ensure AppThemeTokensExtension is added to ThemeData.extensions in AppTheme.',
    );

    return ext!;
  }

  GeneratedColorTokensBase get tokenColors => tokens.colors;
  SpacingTokens get spacing => tokens.spacing;
  RadiusTokens get radius => tokens.radius;
  TypographyTokens get typography => tokens.typography;
  DimensionTokens get dimensions => tokens.dimensions;

  ThemeColorAccessor get color => ThemeColorAccessor(this);
  ThemeTextStyleAccessor get textStyle => ThemeTextStyleAccessor(this);

  ThemeData get lightTheme => AppTheme.light;
  ThemeData get darkTheme => AppTheme.dark;
}

class ThemeColorAccessor {
  ThemeColorAccessor(this._context);

  final BuildContext _context;

  GeneratedColorTokensBase get _colors => _context.tokens.colors;

  Color get border => _colors.border;
  Color get icon => _colors.icon;
  Color get onPrimary => _colors.onPrimary;
  Color get primary => _colors.primary;
  Color get scaffoldBackground => _colors.scaffoldBackground;
  Color get success => _colors.success;
  Color get error => _colors.error;
  Color get warning => _colors.warning;
  Color get info => _colors.info;
  Color get disabled => _colors.disabled;
  Color get active => _colors.active;
  Color get inactive => _colors.inactive;
  Color get secondary => _colors.secondary;
  Color get accent => _colors.accent;
  Color get backgroundLight => _colors.backgroundLight;
  Color get backgroundDark => _colors.backgroundDark;
  Color get textPrimaryLight => _colors.textPrimaryLight;
  Color get textPrimaryDark => _colors.textPrimaryDark;
  Color get textSecondary => _colors.textSecondary;

  ThemeTextColorAccessor get text => ThemeTextColorAccessor(_colors);
  ThemeAppBarColorAccessor get appBar => ThemeAppBarColorAccessor(_colors);
  ThemeBottomNavColorAccessor get bottomNavBar => ThemeBottomNavColorAccessor(_colors);
  ThemePageViewColorAccessor get pageView => ThemePageViewColorAccessor(_colors);
}

class ThemeTextColorAccessor {
  const ThemeTextColorAccessor(this._colors);

  final GeneratedColorTokensBase _colors;

  Color get primary => _colors.textPrimary;
  Color get secondary => _colors.textSecondary;
  Color get tertiary => _colors.textTertiary;
}

class ThemeAppBarColorAccessor {
  const ThemeAppBarColorAccessor(this._colors);

  final GeneratedColorTokensBase _colors;

  Color get background => _colors.appBarBackground;
  Color get icon => _colors.appBarIcon;
  Color get surfaceTint => _colors.appBarSurfaceTint;
  Color get title => _colors.appBarTitle;
}

class ThemeBottomNavColorAccessor {
  const ThemeBottomNavColorAccessor(this._colors);

  final GeneratedColorTokensBase _colors;

  Color get selectedItem => _colors.bottomNavSelected;
  Color get unselectedItem => _colors.bottomNavUnselected;
}

class ThemePageViewColorAccessor {
  const ThemePageViewColorAccessor(this._colors);

  final GeneratedColorTokensBase _colors;

  Color get active => _colors.pageViewActive;
  Color get inactive => _colors.pageViewInactive;
}

class ThemeTextStyleAccessor {
  ThemeTextStyleAccessor(this._context);

  final BuildContext _context;

  TypographyTokens get _typo => _context.tokens.typography;

  TextStyle get headlineLarge => _typo.headlineLarge(_context);
  TextStyle get headlineMedium => _typo.headlineMedium(_context);
  TextStyle get headlineSmall => _typo.headlineSmall(_context);
  TextStyle get titleLarge => _typo.titleLarge(_context);
  TextStyle get titleMedium => _typo.titleMedium(_context);
  TextStyle get titleSmall => _typo.titleSmall(_context);
  TextStyle get bodyLarge => _typo.bodyLarge(_context);
  TextStyle get bodyMedium => _typo.bodyMedium(_context);
  TextStyle get bodySmall => _typo.bodySmall(_context);
  TextStyle get labelLarge => _typo.labelLarge(_context);
  TextStyle get labelMedium => _typo.labelMedium(_context);
  TextStyle get labelSmall => _typo.labelSmall(_context);
  TextStyle get caption => _typo.caption(_context);

  ThemeAppBarTextStyleAccessor get appBar => ThemeAppBarTextStyleAccessor(this);
  ThemeButtonTextStyleAccessor get button => ThemeButtonTextStyleAccessor(this);
  ThemeNavigationTextStyleAccessor get navigation => ThemeNavigationTextStyleAccessor(this);
  ThemeBodyTextStyleAccessor get body => ThemeBodyTextStyleAccessor(this);
}

class ThemeAppBarTextStyleAccessor {
  const ThemeAppBarTextStyleAccessor(this._styles);

  final ThemeTextStyleAccessor _styles;

  TextStyle get title => _styles.titleMedium;
}

class ThemeButtonTextStyleAccessor {
  const ThemeButtonTextStyleAccessor(this._styles);

  final ThemeTextStyleAccessor _styles;

  TextStyle get primary => _styles.labelLarge;
  TextStyle get secondary => _styles.labelMedium;
}

class ThemeNavigationTextStyleAccessor {
  const ThemeNavigationTextStyleAccessor(this._styles);

  final ThemeTextStyleAccessor _styles;

  TextStyle get selected => _styles.labelLarge;
  TextStyle get unselected => _styles.labelMedium;
}

class ThemeBodyTextStyleAccessor {
  const ThemeBodyTextStyleAccessor(this._styles);

  final ThemeTextStyleAccessor _styles;

  TextStyle get heading => _styles.headlineMedium;
  TextStyle get subheading => _styles.titleMedium;
  TextStyle get body => _styles.bodyMedium;
  TextStyle get caption => _styles.caption;
}
