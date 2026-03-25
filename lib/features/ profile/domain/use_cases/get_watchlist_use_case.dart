
import '../ repositories/profile_repository.dart';

class GetWatchlistUseCase {
  final ProfileRepository repository;

  GetWatchlistUseCase(this.repository);

  Stream<List<Map<String, dynamic>>> call() {
    return repository.getWatchlist();
  }
}