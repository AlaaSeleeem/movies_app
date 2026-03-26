import '../ repositories/profile_repository.dart';

class IsInWatchlistUseCase {
  final ProfileRepository repository;

  IsInWatchlistUseCase(this.repository);

  Future<bool> call(int movieId) {
    return repository.isInWatchlist(movieId);
  }
}