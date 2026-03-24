import 'package:dio/dio.dart';

import '../../../home/data/models/movie_model.dart';
import 'favoriteRemoteDataSource.dart';

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final Dio dio;

  FavoriteRemoteDataSourceImpl(this.dio);

  @override
  Future<bool> isFavorite(int movieId) async {
    final response = await dio.get(
      '/favorites/is-favorite/$movieId',
    );

    return response.data['data'];
  }

  @override
  Future<void> addToFavorites(int movieId) async {
    await dio.post('/favorites', data: {
      "movieId": movieId,
    });
  }

  @override
  Future<void> removeFromFavorites(int movieId) async {
    await dio.delete('/favorites/$movieId');
  }

  @override
  Future<List<MovieModel>> getAllFavorites() async {
    final response = await dio.get('/favorites');

    return (response.data['data'] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }
}