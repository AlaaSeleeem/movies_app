import '../../domain/ repositories/profile_repository.dart';
import '../data_source/profile_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<void> updateProfile(UserEntity user) async {
    await remoteDataSource.updateProfile(user);
  }

  @override
  Future<void> deleteAccount() async {
    await remoteDataSource.deleteAccount();
  }

  @override
  Future<void> addToWatchlist({
    required int movieId,
    required String title,
    required String image,
    required double rating,
  }) async {
    await remoteDataSource.addToWatchlist(
      movieId: movieId,
      title: title,
      image: image,
      rating: rating,
    );
  }

  @override
  Future<void> removeFromWatchlist(int movieId) async {
    await remoteDataSource.removeFromWatchlist(movieId);
  }

  @override
  Stream<List<Map<String, dynamic>>> getWatchlist() {
    return remoteDataSource.getWatchlist();
  }

  @override
  Future<void> addToHistory({
    required int movieId,
    required String title,
    required String image,
    required double rating,
  }) async {
    await remoteDataSource.addToHistory(
      movieId: movieId,
      title: title,
      image: image,
      rating: rating,
    );
  }

  @override
  Stream<List<Map<String, dynamic>>> getHistory() {
    return remoteDataSource.getHistory();
  }
}