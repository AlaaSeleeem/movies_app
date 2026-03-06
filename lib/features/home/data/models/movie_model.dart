import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required super.coverImage,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      year: json['year'].toString(),
      rating: (json['rating'] ?? 0).toDouble(),
      coverImage: json['large_cover_image'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}