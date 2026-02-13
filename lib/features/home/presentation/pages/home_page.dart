import 'package:flutter_template_2025/core/base/export.dart';
import 'package:flutter_template_2025/core/router/routes.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.scaffoldBackground,
        elevation: 0,
        title: Text(
          context.locale.home,
          style: context.textStyle.headlineLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: context.color.scaffoldBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Enhanced Search Bar
            Container(
              decoration: BoxDecoration(
                color: context.color.backgroundLight,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: context.color.primary.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: context.color.textSecondary),
                  prefixIcon: Icon(Icons.search, color: context.color.primary),
                  suffixIcon: Icon(
                    Icons.tune,
                    color: context.color.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            const Gap(24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Cards Section
                    Text(
                      'Featured',
                      style: context.textStyle.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(12),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final colors = [
                            [context.color.primary, context.color.secondary],
                            [context.color.accent, context.color.primary],
                            [context.color.secondary, context.color.accent],
                            [context.color.info, context.color.primary],
                            [context.color.accent, context.color.secondary],
                          ];
                          final icons = [
                            Icons.star,
                            Icons.favorite,
                            Icons.trending_up,
                            Icons.bolt,
                            Icons.rocket_launch,
                          ];
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(Routes.profile);
                            },
                            child: Container(
                              width: 160,
                              margin: EdgeInsets.only(
                                right: index == 4 ? 0 : 16,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: colors[index],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors[index][0].withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        icons[index],
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Feature ${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Gap(4),
                                        Text(
                                          'Discover more',
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.9,
                                            ),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(32),
                    // Categories Section
                    Text(
                      'Categories',
                      style: context.textStyle.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(12),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final categoryIcons = [
                            Icons.shopping_bag,
                            Icons.restaurant,
                            Icons.movie,
                            Icons.music_note,
                            Icons.sports_soccer,
                          ];
                          final categoryNames = [
                            'Shopping',
                            'Food',
                            'Movies',
                            'Music',
                            'Sports',
                          ];
                          return Container(
                            width: 100,
                            margin: EdgeInsets.only(right: index == 4 ? 0 : 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  context.color.primary.withValues(alpha: 0.1),
                                  context.color.secondary.withValues(
                                    alpha: 0.1,
                                  ),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: context.color.primary.withValues(
                                  alpha: 0.2,
                                ),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: context.color.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: context.color.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    categoryIcons[index],
                                    color: context.color.primary,
                                    size: 32,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  categoryNames[index],
                                  style: TextStyle(
                                    color: context.color.text.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(32),
                    // Grid Items Section
                    Text(
                      'Explore',
                      style: context.textStyle.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(12),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final gridIcons = [
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
                        final gridColors = [
                          [context.color.primary, context.color.secondary],
                          [context.color.accent, context.color.primary],
                          [context.color.secondary, context.color.accent],
                          [context.color.info, context.color.primary],
                          [context.color.accent, context.color.secondary],
                          [context.color.primary, context.color.accent],
                          [context.color.secondary, context.color.primary],
                          [context.color.primary, context.color.info],
                          [context.color.accent, context.color.primary],
                          [context.color.secondary, context.color.accent],
                        ];
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: gridColors[index % gridColors.length],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: gridColors[index % gridColors.length][0]
                                    .withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    gridIcons[index],
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Item ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(4),
                                    Text(
                                      'Tap to explore',
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Gap(24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
