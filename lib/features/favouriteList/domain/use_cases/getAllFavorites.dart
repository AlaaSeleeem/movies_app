import '../../../movies/domain/entities/movie.dart';
import '../repositories/favourite_repository.dart';

class GetAllFavorites {
  final FavoriteRepository repository;

  GetAllFavorites(this.repository);

  Future<List<Movie>> call() {
    return repository.getAllFavorites();
  }
}