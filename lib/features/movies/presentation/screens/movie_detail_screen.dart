import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/presentation/widgets/movieDetailsAppBar.dart';
import 'package:movies_app/features/movies/presentation/widgets/suggestedMovieWidget.dart';
import '../../domain/entities/cast.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../domain/use_cases/GetMovieDetails.dart';
import '../../domain/use_cases/GetSuggestedMovies.dart';
import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_detail_state.dart';
import '../../data/repositories_impl/movie_repository_impl.dart';
import '../../data/data_source/movie_details_remote_data_source.dart';
import 'package:movies_app/core/constants/app_colors.dart';

import '../widgets/MovieGenreChip.dart';
import '../widgets/movieCastList.dart';
import '../widgets/movieScreenShotsList.dart';
import '../widgets/movieSectionTitle.dart';
import '../widgets/movieWatchButton.dart';

class MovieDetailsScreen extends StatelessWidget {

  static const String routeName = '/movie-details';
  final int movieId;
  final MovieRepository repository;
  MovieDetailsScreen({super.key, required this.movieId})
      : repository = MovieRepositoryImpl(remoteDataSource: MovieDetailsRemoteDataSource());


  //get screenWidth => null;

  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepositoryImpl(remoteDataSource: MovieDetailsRemoteDataSource());
    final getMovieDetails = GetMovieDetails(movieRepository);
    return BlocProvider(
      create: (_) => MovieDetailBloc(
        getMovieDetails: GetMovieDetails(repository), getSuggestedMovies: GetSuggestedMovies(repository),
      )..add(LoadMovieDetail(movieId)),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.red));

            }else if (state is MovieDetailError) {
              return Center(
                  child: Text(state.message,
                      style: const TextStyle(color: Colors.white, fontSize: 16)));
            } else if (state is MovieDetailLoaded) {
              final movie = state.movieDetails;
              final screenHeight = MediaQuery.of(context).size.height;

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  MovieDetailsAppBar(movie: movie, height: screenHeight),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Center(
                            child: Text(
                              movie.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text('${movie.year}',
                                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16)),
                          ),
                          const SizedBox(height: 24),
                          MovieWatchButton(),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatItem(icon: Icons.favorite, value: movie.likeCount.toString()),
                              _buildStatItem(icon: Icons.access_time_filled_sharp, value: '${movie.runtime} min'),
                              _buildStatItem(icon: Icons.star, value: movie.rating.toString()),
                            ]
                          ),
                          movieSectionTitle(title:'Summary'),
                          const SizedBox(height: 12),
                          Text(
                            movie.description,
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15, height: 1.5),
                          ),
                          const SizedBox(height: 32),
                          movieSectionTitle(title: 'Screen Shots'),
                        ],
                      ),
                    ),
                  ),
                  MovieScreenShotsList(screenshots: movie.screenshots),
                  SliverToBoxAdapter(
                    child: SuggestedMoviesWidget(movies: state.suggestedMovies),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: movieSectionTitle(title:'Cast'),
                    ),
                  ),
                  MovieCastList(cast:movie.cast),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          movieSectionTitle(title:'Genres'),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: movie.genres.map((g) => GenreChip(label:g)).toList(),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
  Widget _buildStatItem({required IconData icon, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(16.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.yellow, size: 20),
          const SizedBox(width: 8),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}



