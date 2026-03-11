import 'package:movies_app/features/movies/domain/entities/movie.dart';

class MovieSuggestionModel extends Movie {
  MovieSuggestionModel({
    required super.id,
    required super.title,
    required super.image,
    required super.rating,
  });

  factory MovieSuggestionModel.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}