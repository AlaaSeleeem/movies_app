import '../../../home/data/models/movie_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<bool> isFavorite(int movieId);

  Future<void> addToFavorites(int movieId);

  Future<void> removeFromFavorites(int movieId);

  Future<List<MovieModel>> getAllFavorites();
}