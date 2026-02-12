import 'extensions.dart';

export 'src/colors/colors.dart';
export 'src/text_styles/text_styles.dart';

mixin ThemeExtensions {
  final LightColorExtension lightColor = const LightColorExtension();
  final DarkColorExtension darkColor = const DarkColorExtension();
  final LightTextStyleExtension lightTextStyle =
      const LightTextStyleExtension();
  final DarkTextStyleExtension darkTextStyle = const DarkTextStyleExtension();
}
