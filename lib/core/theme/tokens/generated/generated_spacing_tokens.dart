import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widgets.dart';
import '../responsive_value.dart';

class GeneratedSpacingTokens {
  const GeneratedSpacingTokens();

  double sm(BuildContext context) {
    return ResponsiveValue<double>(mobile: 6, tablet: 8, desktop: 12).resolve(context).r;
  }

  double md(BuildContext context) {
    return ResponsiveValue<double>(mobile: 12, tablet: 16, desktop: 20).resolve(context).r;
  }

  double lg(BuildContext context) {
    return ResponsiveValue<double>(mobile: 20, tablet: 24, desktop: 32).resolve(context).r;
  }
}
