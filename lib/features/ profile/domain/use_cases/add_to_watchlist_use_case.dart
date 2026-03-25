
import '../ repositories/profile_repository.dart';

class AddToWatchlistUseCase {
  final ProfileRepository repository;

  AddToWatchlistUseCase(this.repository);

  Future<void> call({
    required int movieId,
    required String title,
    required String image,
    required double rating,
  }) async {
    await repository.addToWatchlist(
      movieId: movieId,
      title: title,
      image: image,
      rating: rating,
    );
  }
}