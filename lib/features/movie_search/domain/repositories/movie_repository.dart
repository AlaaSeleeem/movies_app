import '../entities/movie_entity.dart';

// This is the "Contract" that was missing
abstract class MovieSearchRepository {
  Future<List<MovieSearchEntity>> searchMovies(String query);
}