import 'package:flutter_template_2025/core/base/export.dart';

/// Individual featured card widget with gradient and animation.
class FeaturedCard extends StatelessWidget {
  final int index;
  final Color primaryColor;
  final Color secondaryColor;
  final IconData icon;
  final VoidCallback onTap;

  const FeaturedCard({
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
        duration: Duration(milliseconds: 400 + (index * 100)),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, (1 - value) * 30),
            child: Opacity(opacity: value, child: child),
          );
        },
        child: Container(
          width: 160.w,
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
                blurRadius: 20.r,
                offset: Offset(0, 8.h),
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
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28.sp),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feature ${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'Discover more',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12.sp,
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

/// Featured cards horizontal list section.
class FeaturedSection extends StatelessWidget {
  final VoidCallback? onCardTap;

  const FeaturedSection({super.key, this.onCardTap});

  @override
  Widget build(BuildContext context) {
    const colors = [
      [Colors.blue, Colors.indigo],
      [Colors.purple, Colors.blue],
      [Colors.teal, Colors.green],
      [Colors.cyan, Colors.blue],
      [Colors.green, Colors.teal],
    ];

    const icons = [
      Icons.star,
      Icons.favorite,
      Icons.trending_up,
      Icons.bolt,
      Icons.rocket_launch,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.locale.featured,
            style: context.textStyle.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(12.h),
          SizedBox(
            height: 180.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: index == 4 ? 0 : 16.w),
                  child: FeaturedCard(
                    index: index,
                    primaryColor: Color(colors[index][0].value),
                    secondaryColor: Color(colors[index][1].value),
                    icon: icons[index],
                    onTap: onCardTap ?? () => context.pushNamed('profile'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
