import 'package:flutter_template_2025/core/base/export.dart';

/// Individual category chip widget.
/// Uses [flutter_animate] for scale entrance animation.
class CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 100.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.color.primary.withValues(alpha: 0.1),
                  context.color.secondary.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: context.color.primary.withValues(alpha: 0.2),
                width: 1.5.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.color.primary.withValues(alpha: 0.1),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: context.color.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: context.color.primary, size: 32.sp),
                ),
                Gap(8.h),
                Text(
                  label,
                  style: TextStyle(
                    color: context.color.text.primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        )
        .animate()
        .scaleXY(
          begin: 0.0,
          end: 1.0,
          delay: Duration(milliseconds: index * 80),
          duration: 500.ms,
          curve: Curves.easeOut,
        )
        .fadeIn(
          delay: Duration(milliseconds: index * 80),
          duration: 400.ms,
        );
  }
}

/// Categories horizontal list section.
class CategoriesSection extends StatelessWidget {
  final VoidCallback? onCategoryTap;

  const CategoriesSection({super.key, this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    const categoryIcons = [
      Icons.shopping_bag,
      Icons.restaurant,
      Icons.movie,
      Icons.music_note,
      Icons.sports_soccer,
    ];

    const categoryNames = ['Shopping', 'Food', 'Movies', 'Music', 'Sports'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                'Categories',
                style: context.textStyle.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideX(begin: -0.1, end: 0, duration: 300.ms),
          Gap(12.h),
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryNames.length,
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == categoryNames.length - 1 ? 0 : 16.w,
                  ),
                  child: CategoryChip(
                    icon: categoryIcons[index],
                    label: categoryNames[index],
                    index: index,
                    onTap: onCategoryTap ?? () {},
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
