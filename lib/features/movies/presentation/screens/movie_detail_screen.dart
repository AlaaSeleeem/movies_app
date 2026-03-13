
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/GetMovieDetails.dart';
import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_detail_state.dart';
import '../../data/repositories_impl/movie_repository_impl.dart';
import '../../data/data_source/movie_details_remote_data_source.dart';

const Color kBackgroundColor = Color(0xFF121312);
const Color kCardColor = Color(0xFF282A28);
const Color kAccentYellow = Color(0xFFF6BD00);
const Color kAccentRed = Color(0xFFE82626);
const Color kGreyTextColor = Color(0xFFADADAD);

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});
  static const String routeName = '/movie-details';

  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepositoryImpl(remoteDataSource: MovieDetailsRemoteDataSource());
    final getMovieDetails = GetMovieDetails(movieRepository);
    return BlocProvider(
        create: (_) => MovieDetailBloc(getMovieDetails: getMovieDetails)
          ..add(LoadMovieDetail(movieId)),
        child: Scaffold(
            backgroundColor: kBackgroundColor,
            body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
                builder: (context, state) {
                  if (state is MovieDetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieDetailLoaded) {
                    final movie = state.movieDetails;
                    final screenHeight = MediaQuery.of(context).size.height;
                    final screenWidth = MediaQuery.of(context).size.width;

                    return CustomScrollView(
                      slivers: [
                      SliverAppBar(
                      pinned: true,
                      backgroundColor: kBackgroundColor,
                      elevation: 0,
                      expandedHeight: screenHeight * 0.4,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.bookmark, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              movie.bannerImage,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.transparent, kBackgroundColor],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.5, 1.0],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                  children: [
                  const SizedBox(height: 16),
                  Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                  color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),const SizedBox(height: 12),
                  Text('${movie.year}', style: const TextStyle(color: kGreyTextColor, fontSize: 16)),
                  const SizedBox(height: 24),
                  SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentRed,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
                  ),
                  child: const Text('Watch',
                  style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Expanded(
                  child: _buildStatItem(icon: Icons.favorite, value: '${movie.likeCount}')),
                  const SizedBox(width: 12),
                  Expanded(
                  child: _buildStatItem(icon: Icons.access_time_filled, value: '${movie.runtime}')),
                  const SizedBox(width: 12),
                  Expanded(
                  child: _buildStatItem(icon: Icons.star, value: '${movie.rating}')),
                  ],
                  ),
                  ],
                  ),
                  ),
                  ),
                  SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                  sliver: SliverList(
                  delegate: SliverChildListDelegate(
                  [
                  _buildSectionTitle('Screen Shots'),
                  const SizedBox(height: 16),
                  ...movie.screenshots.map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildScreenshot(s),
                  )),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Summary'),
                  const SizedBox(height: 12),
                  Text(
                  movie.description,
                  style:
                  TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Cast'),
                  const SizedBox(height: 16),
                  ...movie.cast.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildCastCard(c.image, c.name, c.characterName),
                  )),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Genres'),
                  const SizedBox(height: 16),
                  Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: movie.genres.map((g) => _buildGenreChip(g)).toList(),
                  ),const SizedBox(height: 50),
                  ],
                  ),
                  ),
                  ),
                      ],
                    );
                  } else if (state is MovieDetailError) {
                    return Center(
                        child: Text(state.message, style: const TextStyle(color: Colors.white, fontSize: 16)));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
            ),
        ),
    );
  }

  Widget _buildSectionTitle(String title) =>
      Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold));

  Widget _buildScreenshot(String imageUrl) =>
      ClipRRect(borderRadius: BorderRadius.circular(16.0), child: Image.network(imageUrl, fit: BoxFit.cover));

  Widget _buildCastCard(String imageUrl, String name, String character) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(16.0)),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(imageUrl, width: 65, height: 65, fit: BoxFit.cover)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Text('Character: $character',
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(12.0)),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
    );
  }

  Widget _buildStatItem({required IconData icon, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(16.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: kAccentYellow, size: 20),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}