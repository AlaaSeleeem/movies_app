import '../../../movies/domain/entities/movie.dart';
import '../../domain/repositories/favourite_repository.dart';
import '../data_source/favoriteRemoteDataSource.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remote;

  FavoriteRepositoryImpl(this.remote);

  @override
  Future<bool> isFavorite(int movieId) {
    return remote.isFavorite(movieId);
  }

  @override
  Future<void> addToFavorites(int movieId) {
    return remote.addToFavorites(movieId);
  }

  @override
  Future<void> removeFromFavorites(int movieId) {
    return remote.removeFromFavorites(movieId);
  }

  @override
  Future<List<Movie>> getAllFavorites() async {
    final models = await remote.getAllFavorites();
    return models.map((e) => e.toEntity()).toList();
  }
}