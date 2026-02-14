import 'package:flutter_template_2025/core/base/export.dart';
import 'package:flutter_template_2025/core/router/routes.dart';
import 'package:flutter_template_2025/features/home/presentation/widgets/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverList.list(
            children: [
              // Carousel Banner
              Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                child: CarouselBanner(
                  onBannerTap: (index) {
                    // Handle banner tap
                  },
                ),
              ),

              // Featured Section
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: FeaturedSection(
                  onCardTap: () => context.pushNamed(Routes.profile),
                ),
              ),

              // Categories Section
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: CategoriesSection(onCategoryTap: () {}),
              ),

              // Explore Section (Grid)
              Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
                child: ExploreSection(onItemTap: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a [SliverAppBar] with pinned search bar.
  /// The title scrolls away, but the search bar stays pinned at the top.
  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: context.color.scaffoldBackground,
      elevation: 0,
      floating: true,
      pinned: true,
      snap: true,
      expandedHeight: 120.h,
      title: Text(
        context.locale.home,
        style: context.textStyle.headlineMedium.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: HomeSearchBar(
            onSearchChanged: (value) {
              // Handle search
            },
            onFilterTap: () {
              // Handle filter
            },
          ),
        ),
      ),
    );
  }
}
