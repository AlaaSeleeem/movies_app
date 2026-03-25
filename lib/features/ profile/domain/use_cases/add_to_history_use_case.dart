
import '../ repositories/profile_repository.dart';

class AddToHistoryUseCase {
  final ProfileRepository repository;

  AddToHistoryUseCase(this.repository);

  Future<void> call({
    required int movieId,
    required String title,
    required String image,
    required double rating,
  }) async {
    await repository.addToHistory(
      movieId: movieId,
      title: title,
      image: image,
      rating: rating,
    );
  }
}