import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['medium_cover_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
