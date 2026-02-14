import 'package:flutter_template_2025/core/base/export.dart';

/// Animated search bar widget for the home page.
/// Provides search functionality with a modern, elevated design.
/// Uses [flutter_animate] for a subtle scale + fadeIn entrance animation.
class HomeSearchBar extends StatelessWidget {
  /// Optional callback when search text changes.
  final ValueChanged<String>? onSearchChanged;

  /// Optional callback when filter button is tapped.
  final VoidCallback? onFilterTap;

  const HomeSearchBar({super.key, this.onSearchChanged, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: context.color.backgroundLight,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: context.color.primary.withValues(alpha: 0.1),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: context.locale.search,
              hintStyle: TextStyle(
                color: context.color.textSecondary,
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: context.color.primary,
                size: 22.sp,
              ),
              suffixIcon: GestureDetector(
                onTap: onFilterTap,
                child: Icon(
                  Icons.tune,
                  color: context.color.textSecondary,
                  size: 22.sp,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, curve: Curves.easeOut)
        .scaleXY(
          begin: 0.95,
          end: 1.0,
          duration: 600.ms,
          curve: Curves.easeInOut,
        );
  }
}
