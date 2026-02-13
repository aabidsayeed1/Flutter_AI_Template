import 'package:flutter/material.dart';

import '../di/injectable.dart';
import '../localization/l10n/app_localizations.dart';
import '../services/navigation_service.dart';

extension GlobalContextExtension on Object {
  BuildContext? get globalContext => getIt<NavigationService>().currentContext;

  AppLocalizations? get tr {
    final context = globalContext;
    if (context == null) {
      debugPrint('⚠️ Localization context not found');
      return null;
    }
    return AppLocalizations.of(context);
  }
}
