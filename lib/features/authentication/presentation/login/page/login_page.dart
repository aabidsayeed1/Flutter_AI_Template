import 'package:flutter_template_2025/core/base/export.dart';
import 'package:flutter_template_2025/features/authentication/presentation/cubit/auth_cubit.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/link_text.dart';
import '../widgets/language_switcher.dart';

part '../widgets/login_form.dart';
part '../widgets/login_form_footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final shouldRemember = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final data = await getIt<AuthCubit>().getRememberMe();
    shouldRemember.value = data.enabled;
    if (data.enabled) {
      emailController.text = data.email ?? '';
      passwordController.text = data.password ?? '';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    shouldRemember.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Directionality.of(context) == TextDirection.ltr
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: LanguageSwitcherWidget(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 200,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FlutterLogo(size: 200),
                        const SizedBox(height: 80),
                        Form(
                          key: formKey,
                          child: _LoginForm(
                            emailController: emailController,
                            passwordController: passwordController,
                            shouldRemember: shouldRemember,
                          ),
                        ),
                        const SizedBox(height: 32),
                        FilledButton(
                          onPressed: () {
                            getIt<AuthCubit>().login(
                              username: emailController.text,
                              password: passwordController.text,
                              rememberMe: shouldRemember.value,
                            );
                            // context.pushReplacementNamed(Routes.home);
                          },
                          child: Text(context.locale.login),
                        ),
                        LinkText(
                          text: context.locale.dontHaveAccount,
                          linkText: context.locale.signUp,
                          onTap: () {
                            context.pushNamed(Routes.registration);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
