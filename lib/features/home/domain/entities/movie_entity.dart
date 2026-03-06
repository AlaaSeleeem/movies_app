import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String year;
  final double rating;
  final String coverImage;
  final List<String> genres;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.coverImage,
    required this.genres,
  });

  @override
  List<Object> get props => [id, title, year, rating, coverImage, genres];
}