import 'package:movies_app/features/movies/domain/entities/cast.dart';
import 'package:movies_app/features/movies/domain/entities/movie_details.dart';

class MovieDetailModel extends MovieDetails {
  MovieDetailModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.likeCount,
    required super.description,
    required super.bannerImage,
    required super.genres,
    required super.screenshots,
    required super.cast,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    final movieData = json['data']['movie'];
    return MovieDetailModel(
      id: movieData['id'] ?? 0,
      title: movieData['title'] ?? '',
      year: movieData['year'] ?? 0,
      rating: (movieData['rating'] ?? 0).toDouble(),
      runtime: movieData['runtime'] ?? 0,
      likeCount: movieData['like_count'] ?? 0,
      description: movieData['description_full'] ?? '',
      bannerImage: movieData['background_image'] ?? '',
      genres: List<String>.from(movieData['genres'] ?? []),
      screenshots: [
        movieData['medium_screenshot_image1'] ?? '',
        movieData['medium_screenshot_image2'] ?? '',
        movieData['medium_screenshot_image3'] ?? '',
      ],
      cast: (movieData['cast'] as List? ?? [])
          .map((c) => Cast(
        name: c['name'] ?? '',
        characterName: c['character_name'] ?? '',
        image: c['url_small_image'] ?? '',
      ))
          .toList(),
    );
  }
}