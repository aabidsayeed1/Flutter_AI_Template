import '../base/export.dart';

extension BaseExtension on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
  void pushNamedAndRemoveUntil(String routeName) {
    while (canPop()) {
      pop();
    }
    pushReplacementNamed(routeName);
  }
}

extension AppLocalizationExtension on AppLocalizations {
  String getLanguageName(String languageCode) {
    return switch (languageCode) {
      'en' => english,
      'bn' => bangla,
      'ar' => arabic,
      _ => languageCode,
    };
  }
}
