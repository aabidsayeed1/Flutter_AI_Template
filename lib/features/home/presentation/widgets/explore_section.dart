import 'package:flutter_template_2025/core/base/export.dart';

/// Individual grid item card with gradient.
class ExploreCard extends StatelessWidget {
  final int index;
  final Color primaryColor;
  final Color secondaryColor;
  final IconData icon;
  final VoidCallback onTap;

  const ExploreCard({
    super.key,
    required this.index,
    required this.primaryColor,
    required this.secondaryColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 600 + (index * 100)),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, (1 - value) * 40),
            child: Opacity(opacity: value, child: child),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryColor, secondaryColor],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.3),
                blurRadius: 15.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: Colors.white, size: 32.sp),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item ${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'Tap to explore',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Explore grid section as a regular box widget.
/// Used inside [SliverToBoxAdapter] in the home page.
class ExploreSection extends StatelessWidget {
  final VoidCallback? onItemTap;

  const ExploreSection({super.key, this.onItemTap});

  static const _gridIcons = [
    Icons.palette,
    Icons.camera_alt,
    Icons.code,
    Icons.design_services,
    Icons.lightbulb,
    Icons.book,
    Icons.fitness_center,
    Icons.travel_explore,
    Icons.science,
    Icons.psychology,
  ];

  static const _gridColors = [
    (Colors.blue, Colors.indigo),
    (Colors.purple, Colors.blue),
    (Colors.teal, Colors.green),
    (Colors.cyan, Colors.blue),
    (Colors.green, Colors.teal),
    (Colors.blue, Colors.cyan),
    (Colors.indigo, Colors.blue),
    (Colors.blue, Colors.cyan),
    (Colors.purple, Colors.blue),
    (Colors.teal, Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore',
            style: context.textStyle.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(12.h),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.85,
            ),
            itemCount: _gridIcons.length,
            itemBuilder: (context, index) {
              return ExploreCard(
                index: index,
                primaryColor: Color(_gridColors[index].$1.value),
                secondaryColor: Color(_gridColors[index].$2.value),
                icon: _gridIcons[index],
                onTap: onItemTap ?? () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
