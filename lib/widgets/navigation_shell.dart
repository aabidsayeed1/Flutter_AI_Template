import 'package:flutter_template_2025/core/base/export.dart';

class NavigationShell extends StatelessWidget {
  const NavigationShell({super.key, required this.statefulNavigationShell});

  final StatefulNavigationShell statefulNavigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Flutter Template')),
      body: statefulNavigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: statefulNavigationShell.currentIndex,
        onTap: (index) {
          statefulNavigationShell.goBranch(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.locale.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: context.locale.profile,
          ),
        ],
      ),
    );
  }
}
