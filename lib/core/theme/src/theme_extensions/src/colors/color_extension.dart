part of 'colors.dart';

class ColorExtension {
  const ColorExtension({
    required this.border,
    required this.icon,
    required this.onPrimary,
    required this.primary,
    required this.scaffoldBackground,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.disabled,
    required this.active,
    required this.inactive,
    required this.secondary,
    required this.accent,
    required this.backgroundLight,
    required this.backgroundDark,
    required this.textPrimaryLight,
    required this.textPrimaryDark,
    required this.textSecondary,
    required this.appBar,
    required this.bottomNavBar,
    required this.pageView,
    required this.text,
  });

  final Color border;
  final Color icon;
  final Color onPrimary;
  final Color primary;
  final Color scaffoldBackground;
  final Color success;
  final Color error;
  final Color warning;
  final Color info;
  final Color disabled;
  final Color active;
  final Color inactive;

  final Color secondary;
  final Color accent;

  final Color backgroundLight;
  final Color backgroundDark;

  final Color textPrimaryLight;
  final Color textPrimaryDark;
  final Color textSecondary;

  final AppBarColors appBar;
  final BottomNavBarColors bottomNavBar;
  final PageViewColors pageView;
  final TextColors text;
}
