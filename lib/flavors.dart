enum Flavor {
  dev,
  qa,
  uat,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Flutter Template Dev';
      case Flavor.qa:
        return 'Flutter Template QA';
      case Flavor.uat:
        return 'Flutter Template UAT';
      case Flavor.prod:
        return 'Flutter Template';
    }
  }

}
