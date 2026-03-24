import '../repositories/favourite_repository.dart';

class RemoveFromFavorites {
  final FavoriteRepository repository;

  RemoveFromFavorites(this.repository);

  Future<void> call(int movieId) {
    return repository.removeFromFavorites(movieId);
  }
}