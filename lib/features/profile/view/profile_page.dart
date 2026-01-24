import 'package:gap/gap.dart';

import '../../../core/base/export.dart';
import '../../authentication/presentation/cubit/auth_cubit.dart';
import 'instagram_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.locale.profile)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getIt<AuthCubit>().state.user?.name ?? ''),
              Text(getIt<AuthCubit>().state.user?.email ?? ''),
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
          ),
        ),
      ),
    );
  }
}
