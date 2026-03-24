import '../../../movies/domain/entities/movie.dart';

abstract class FavoriteRepository {
  Future<bool> isFavorite(int movieId);

  Future<void> addToFavorites(int movieId);

  Future<void> removeFromFavorites(int movieId);

  Future<List<Movie>> getAllFavorites();
}