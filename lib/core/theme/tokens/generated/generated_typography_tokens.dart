import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme_tokens_extension.dart';
import '../responsive_value.dart';

class GeneratedTypographyTokens {
  const GeneratedTypographyTokens();

  TextStyle headlineLarge(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 30, tablet: 32, desktop: 34).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w600,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle headlineMedium(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 26, tablet: 28, desktop: 30).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w600,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle headlineSmall(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 22, tablet: 24, desktop: 26).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w600,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle titleLarge(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 20, tablet: 22, desktop: 24).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w500,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle titleMedium(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 18, tablet: 20, desktop: 22).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w500,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle titleSmall(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 16, tablet: 18, desktop: 20).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w500,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle bodyLarge(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 16, tablet: 17, desktop: 18).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w400,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle bodyMedium(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 14, tablet: 15, desktop: 16).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w400,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle bodySmall(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 12, tablet: 13, desktop: 14).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w400,
      color: appTheme.colors.textSecondary,
    );
  }

  TextStyle labelLarge(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 14, tablet: 15, desktop: 16).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w500,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle labelMedium(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 12, tablet: 13, desktop: 14).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w500,
      color: appTheme.colors.textPrimary,
    );
  }

  TextStyle labelSmall(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    final size = ResponsiveValue<double>(mobile: 10, tablet: 11, desktop: 12).resolve(context);

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w500,
      color: appTheme.colors.textSecondary,
    );
  }

  TextStyle caption(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;
    const size = 12.0;

    return TextStyle(
      fontSize: size.sp,
      fontWeight: FontWeight.w400,
      color: appTheme.colors.textSecondary,
    );
  }
}
