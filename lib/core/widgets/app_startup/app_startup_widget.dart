import 'package:flutter_template_2025/features/authentication/presentation/cubit/auth_cubit.dart';
import '../../base/export.dart';
import '../splash/splash_page.dart';
import 'startup_error_widget.dart';

class AppStartupWidget extends StatelessWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      builder: (context, state) {
        return state.error != null
            ? AppStartupErrorWidget(
                errorMessage:
                    'An error occurred during startup. ${state.error}',
                onRetry: () {
                  getIt<AuthCubit>().retry();
                },
              )
            : SplashPage();
      },
    );
  }
}
