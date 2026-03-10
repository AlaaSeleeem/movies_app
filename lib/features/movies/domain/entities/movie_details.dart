import 'package:movies_app/features/movies/domain/entities/cast.dart';

class MovieDetails {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final int likeCount;
  final String description;
  final String bannerImage;
  final List<String> genres;
  final List<String> screenshots;
  final List<Cast> cast;

  MovieDetails({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.likeCount,
    required this.description,
    required this.bannerImage,
    required this.genres,
    required this.screenshots,
    required this.cast,
  });
}