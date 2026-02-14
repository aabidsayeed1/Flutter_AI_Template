import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_template_2025/core/base/export.dart';

/// Data model for a single carousel banner item.
class BannerItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;

  const BannerItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

/// Auto-playing carousel banner using [CarouselSlider].
/// Infinite scroll with auto-play, center-enlarged page, and animated dot indicators.
/// Uses [StatefulWidget] only to track the active page index for the indicator.
class CarouselBanner extends StatefulWidget {
  /// Called when a banner is tapped. Receives the banner index.
  final ValueChanged<int>? onBannerTap;

  /// Duration between auto-play page transitions.
  final Duration autoPlayInterval;

  const CarouselBanner({
    super.key,
    this.onBannerTap,
    this.autoPlayInterval = const Duration(seconds: 4),
  });

  static const _banners = [
    BannerItem(
      title: 'Welcome Back!',
      subtitle: 'Check out the latest updates and features',
      icon: Icons.celebration,
      primaryColor: Color(0xFF6366F1),
      secondaryColor: Color(0xFF8B5CF6),
    ),
    BannerItem(
      title: 'New Collection',
      subtitle: 'Explore our handpicked items just for you',
      icon: Icons.auto_awesome,
      primaryColor: Color(0xFFEC4899),
      secondaryColor: Color(0xFFF43F5E),
    ),
    BannerItem(
      title: 'Special Offer',
      subtitle: "Limited time deals you don't want to miss",
      icon: Icons.local_offer,
      primaryColor: Color(0xFF14B8A6),
      secondaryColor: Color(0xFF06B6D4),
    ),
    BannerItem(
      title: 'Trending Now',
      subtitle: "See what's popular in your community",
      icon: Icons.trending_up,
      primaryColor: Color(0xFFF59E0B),
      secondaryColor: Color(0xFFF97316),
    ),
  ];

  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            CarouselSlider.builder(
              itemCount: CarouselBanner._banners.length,
              itemBuilder: (context, index, realIndex) {
                final banner = CarouselBanner._banners[index];
                return BannerCard(
                  banner: banner,
                  onTap: () => widget.onBannerTap?.call(index),
                );
              },
              options: CarouselOptions(
                height: 180.h,
                viewportFraction: 0.88,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: widget.autoPlayInterval,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                padEnds: true,
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
            ),
            Gap(14.h),
            _DotsIndicator(
              count: CarouselBanner._banners.length,
              activeIndex: _currentIndex,
              activeColor: context.color.primary,
              inactiveColor: context.color.primary.withValues(alpha: 0.2),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .slideY(begin: -0.1, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}

/// Animated dot indicator that highlights the current active page
/// with an expanding pill shape and smooth color/size transitions.
class _DotsIndicator extends StatelessWidget {
  final int count;
  final int activeIndex;
  final Color activeColor;
  final Color inactiveColor;

  const _DotsIndicator({
    required this.count,
    required this.activeIndex,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.color.backgroundLight,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(count, (index) {
          final isActive = index == activeIndex;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              width: isActive ? 28.w : 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: isActive ? activeColor : inactiveColor,
                borderRadius: BorderRadius.circular(5.r),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: activeColor.withValues(alpha: 0.4),
                          blurRadius: 6.r,
                          offset: Offset(0, 2.h),
                        ),
                      ]
                    : [],
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Individual banner card with gradient, icon, and text.
class BannerCard extends StatelessWidget {
  final BannerItem banner;
  final VoidCallback onTap;

  const BannerCard({super.key, required this.banner, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [banner.primaryColor, banner.secondaryColor],
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: banner.primaryColor.withValues(alpha: 0.35),
              blurRadius: 24.r,
              offset: Offset(0, 10.h),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative background circles
            Positioned(
              top: -20.h,
              right: -20.w,
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              bottom: -30.h,
              left: -10.w,
              child: Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          banner.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        Gap(8.h),
                        Text(
                          banner.subtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 13.sp,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Gap(16.w),
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.w,
                      ),
                    ),
                    child: Icon(banner.icon, color: Colors.white, size: 34.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
