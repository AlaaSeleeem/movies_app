import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/data_source/home_remote_data_source.dart';
import '../../data/repositories_impl/home_repository_impl.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/use_cases/get_movies_use_case.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/category_section.dart';
import '../widgets/featured_section.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const String routeName = "/home";


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        GetMoviesUseCase(
          HomeRepositoryImpl(
            HomeRemoteDataSourceImpl(),
          ),
        ),
      )..add(GetMoviesEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.black,
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.yellow),
                );
              }

              if (state is HomeError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: AppColors.white),
                  ),
                );
              }

              if (state is HomeLoaded) {
                final Map<String, List<MovieEntity>> genreMap = {};
                for (final movie in state.movies) {
                  for (final genre in movie.genres) {
                    genreMap.putIfAbsent(genre, () => []).add(movie);
                  }
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Featured Section ─────────────────
                      FeaturedSection(movies: state.movies.take(3).toList()),
                      SizedBox(height: 61.h),

                      // ── Category Sections ─────────────────
                      ...genreMap.entries.take(5).map(
                            (entry) => Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: CategorySection(
                            genre: entry.key,
                            movies: List<MovieEntity>.from(entry.value)
                                .take(3)
                                .toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}