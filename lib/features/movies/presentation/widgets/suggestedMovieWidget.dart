import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class SuggestedMoviesWidget extends StatelessWidget {
  final List<Movie> movies;

  const SuggestedMoviesWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Similar Movies',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true, // important inside CustomScrollView
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movies.length > 4 ? 4 : movies.length, // max 2x2
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _buildMovieCard(movie);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(movie.image, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: AppColors.yellow, size: 14),
            const SizedBox(width: 4),
            Text(
              '${movie.rating}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}