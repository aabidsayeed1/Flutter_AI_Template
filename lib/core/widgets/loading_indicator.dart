import 'package:flutter_template_2025/core/base/export.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.colors.textOnPrimary.withValues(alpha: 0.75),
        ),
      ),
    );
  }
}
