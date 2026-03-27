import '../entities/movie_entity.dart';

abstract class MovieSearchRepository {
  Future<List<MovieSearchEntity>> searchMovies(String query);
}