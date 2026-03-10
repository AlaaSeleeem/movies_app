import '../entities/movie.dart';
import '../entities/movie_details.dart';

abstract class MovieRepository {
  Future<MovieDetails> getMovieDetails(int movieId);

  Future<List<Movie>> getSuggestedMovies(int movieId);
}