import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/presentation/screens/movie_detail_screen.dart';
import '../../domain/entities/movie_entity.dart';
import 'movie_card.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';

class FeaturedSection extends StatefulWidget {
  final List<MovieEntity> movies;

  const FeaturedSection({super.key, required this.movies});

  @override
  State<FeaturedSection> createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends State<FeaturedSection> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.6,
      initialPage: _currentIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) return const SizedBox();

    return SizedBox(
      height: 620.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [

          // ── Background  ─────────────
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.network(
                widget.movies[_currentIndex].coverImage,
                key: ValueKey(_currentIndex),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppColors.black),
              ),
            ),
          ),

          // ── Linear Gradient Overlay  ────────
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xCC121312), // #121312 - 80%
                    Color(0x99121312), // #121312 - 60%
                    Color(0xFF121312), // #121312 - 100%
                  ],
                ),
              ),
            ),
          ),

          // ── Available Now ──────────────────────────────
          Positioned(
            top: 7.h,
            child: Image.asset(
              AppAssets.availableNow,
              width: 267.w,
              height: 93.h,
            ),
          ),

          // ── Carousel ──────────────────────────────────
          Positioned(
            top: 100.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 380.h,
              child: PageView.builder(
                controller: _pageController,
                clipBehavior: Clip.none,
                itemCount: widget.movies.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double scale = 1.0;
                      double opacity = 1.0;

                      if (_pageController.position.haveDimensions) {
                        final double page =
                            _pageController.page ?? _currentIndex.toDouble();
                        final double diff = (page - index).abs();

                        scale = (1 - diff * 0.25).clamp(0.75, 1.0);
                        opacity = (1 - diff * 0.4).clamp(1.0, 1.0);
                      } else {
                        if (index != _currentIndex) {
                          scale = 0.75;
                          opacity = 0.5;
                        }
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MovieDetailsScreen.routeName,
                            arguments: widget.movies[index].id,
                          );

                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        /*onTap: () {
                          Navigator.pushNamed(context,MovieDetailsScreen. routeName, arguments: movie.id);
                          _pageController.animateToPage(
                           index,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },*/
                        child: Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: opacity,
                            child: MovieCard(
                              movie: widget.movies[index],
                              width: double.infinity,
                              height: 380.h,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // ── Watch Now ─────────────────────────────────
          Positioned(
            bottom: 0,
            child: Image.asset(
              AppAssets.watchNow,
              width: 354.w,
              height: 146.h,
            ),
          ),
        ],
      ),
    );
  }
}
