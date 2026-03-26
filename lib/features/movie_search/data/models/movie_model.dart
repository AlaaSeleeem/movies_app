import '../../domain/entities/movie_entity.dart';

class MovieSearchModel extends MovieSearchEntity {
  MovieSearchModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.rating,
  });

  factory MovieSearchModel.fromJson(Map<String, dynamic> json) {
    return MovieSearchModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['medium_cover_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}