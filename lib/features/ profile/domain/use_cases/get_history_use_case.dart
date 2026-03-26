
import '../ repositories/profile_repository.dart';

class GetHistoryUseCase {
  final ProfileRepository repository;

  GetHistoryUseCase(this.repository);

  Stream<List<Map<String, dynamic>>> call() {
    return repository.getHistory();
  }
}