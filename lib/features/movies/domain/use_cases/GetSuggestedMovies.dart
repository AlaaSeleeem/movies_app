import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetSuggestedMovies {
  final MovieRepository repository;

  GetSuggestedMovies(this.repository);

  Future<List<Movie>> call(int movieId) {
    return repository.getSuggestedMovies(movieId);
  }
}