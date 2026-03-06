import '../entities/movie_entity.dart';
import '../repositories/home_repository.dart';

class GetMoviesUseCase {
  final HomeRepository _repository;

  GetMoviesUseCase(this._repository);

  Future<List<MovieEntity>> call() async {
    return await _repository.getMovies();
  }
}