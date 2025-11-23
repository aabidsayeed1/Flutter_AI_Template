import '../../../core/base/export.dart';
import '../../../core/router/routes.dart';
part '../model/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: PageView(
                    onPageChanged: (int page) {},
                    children: _getOnboardingItems(context).map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: context.textStyle.headlineSmall.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 24),
                            item.image,
                            const SizedBox(height: 24),
                            Column(
                              children: item.features.map((feature) {
                                return _OnboardingListItem(title: feature);
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _getOnboardingItems(context).map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: context.color.pageView.active,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 44),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: FilledButton(
                    onPressed: () {
                      context.goNamed(Routes.login);
                    },
                    child: Text(context.locale.getStarted),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingListItem extends StatelessWidget {
  const _OnboardingListItem({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 6, color: context.color.text.tertiary),
          const SizedBox(width: 8),
          Expanded(
            child: Baseline(
              baseline: 8,
              baselineType: TextBaseline.alphabetic,
              child: Text(title, style: context.textStyle.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}
