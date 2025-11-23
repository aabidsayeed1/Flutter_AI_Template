import 'package:flutter/material.dart';

import 'src/theme_data.dart';
import 'src/theme_extensions/extensions.dart';

export 'src/theme_data.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);
  ColorExtension get color {
    final ext = _theme.brightness == Brightness.light
        ? _theme.extension<LightColorExtension>()
        : _theme.extension<DarkColorExtension>();

    assert(
      ext != null,
      'Ensure ColorExtension is added to ThemeData.extensions in src/theme_data.dart.',
    );

    return ext!;
  }

  TextStyleExtension get textStyle {
    final ext = _theme.extension<TextStyleExtension>();

    assert(
      ext != null,
      'Ensure TextStyleExtension is added to ThemeData.extensions in src/theme_data.dart.',
    );

    return ext!;
  }

  ThemeData get lightTheme => $LightThemeData()();
  ThemeData get darkTheme => $DarkThemeData()();
}
