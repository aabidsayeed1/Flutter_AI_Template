import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widgets.dart';

import '../responsive_value.dart';

class GeneratedElevationTokens {
  const GeneratedElevationTokens();

  double level1(BuildContext context) {
    return ResponsiveValue<double>(
      mobile: 1,
      tablet: 1,
      desktop: 1,
    ).resolve(context).r;
  }

  double level2(BuildContext context) {
    return ResponsiveValue<double>(
      mobile: 2,
      tablet: 2,
      desktop: 2,
    ).resolve(context).r;
  }

  double level3(BuildContext context) {
    return ResponsiveValue<double>(
      mobile: 4,
      tablet: 4,
      desktop: 4,
    ).resolve(context).r;
  }


  double surface(BuildContext context) {
    return level1(context);
  }

  double card(BuildContext context) {
    return level1(context);
  }

  double popover(BuildContext context) {
    return level2(context);
  }

  double dialog(BuildContext context) {
    return level3(context);
  }


}
