import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _dataSource;

  HomeRepositoryImpl(this._dataSource);

  @override
  Future<List<MovieEntity>> getMovies() async {
    return await _dataSource.getMovies();
  }
}