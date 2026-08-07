import 'package:flutter_template_2025/core/base/export.dart';

import '../../../../../core/router/routes.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  context.locale.resetPassword,
                  style: context.typo.h3.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.locale.enterAssociatedEmail,
                  style: context.typo.body.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.locale.emailAddress,
                  style: context.typo.body,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(hintText: context.locale.email),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    context.pushReplacementNamed(Routes.emailVerification);
                  },
                  child: Text(context.locale.continueAction),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
