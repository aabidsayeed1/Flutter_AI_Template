import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widgets.dart';
import '../responsive_value.dart';

class GeneratedRadiusTokens {
  const GeneratedRadiusTokens();

  double sm(BuildContext context) {
    return ResponsiveValue<double>(mobile: 6, tablet: 8, desktop: 10).resolve(context).r;
  }

  double md(BuildContext context) {
    return ResponsiveValue<double>(mobile: 10, tablet: 12, desktop: 16).resolve(context).r;
  }

  double lg(BuildContext context) {
    return ResponsiveValue<double>(mobile: 14, tablet: 16, desktop: 20).resolve(context).r;
  }
}
