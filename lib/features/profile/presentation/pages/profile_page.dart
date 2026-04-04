import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template_2025/core/base/export.dart';
import 'package:flutter_template_2025/core/user/user_cubit.dart';
import 'package:flutter_template_2025/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:gap/gap.dart';
import 'instagram_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.locale.profile)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<UserCubit, UserState>(
            bloc: getIt<UserCubit>(),
            builder: (context, userState) {
              final user = userState.user;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user?.fullName ?? ''),
                  Text(user?.email ?? ''),
                  Gap(20),
                  FilledButton(
                    onPressed: () {
                      getIt<AuthCubit>().logout();
                    },
                    child: Text(context.locale.logout),
                  ),
                  Gap(20),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InstagramProfilePage(),
                        ),
                      );
                    },
                    child: Text('Instagram Profile Page'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
