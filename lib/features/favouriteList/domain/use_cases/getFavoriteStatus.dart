import '../repositories/favourite_repository.dart';

class GetFavoriteStatus {
  final FavoriteRepository repository;

  GetFavoriteStatus(this.repository);

  Future<bool> call(int movieId) {
    return repository.isFavorite(movieId);
  }
}