import 'package:flutter_template_2025/core/base/export.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  const LanguageSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      bloc: getIt<LocaleCubit>(),
      builder: (context, state) {
        return PopupMenuButton<Locale>(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language, color: context.color.primary),
              const SizedBox(width: 4),
              Text(
                context.locale.getLanguageName(state.languageCode),
                style: context.textStyle.bodyMedium,
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          onSelected: (Locale locale) =>
              context.read<LocaleCubit>().switchLocale(),
          itemBuilder: (BuildContext context) {
            return AppLocalizations.supportedLocales.map((Locale locale) {
              return PopupMenuItem<Locale>(
                value: locale,
                child: Row(
                  children: [
                    Text(context.locale.getLanguageName(locale.languageCode)),
                    if (locale == state) ...[
                      const Spacer(),
                      Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                        size: 16,
                      ),
                    ],
                  ],
                ),
              );
            }).toList();
          },
        );
      },
    );
  }
}
