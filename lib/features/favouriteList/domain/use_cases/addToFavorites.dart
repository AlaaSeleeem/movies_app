import '../repositories/favourite_repository.dart';

class AddToFavorites {
  final FavoriteRepository repository;

  AddToFavorites(this.repository);

  Future<void> call(int movieId) {
    return repository.addToFavorites(movieId);
  }
}