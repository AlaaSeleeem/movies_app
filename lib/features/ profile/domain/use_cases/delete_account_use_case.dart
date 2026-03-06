
import '../ repositories/profile_repository.dart';

class DeleteAccountUseCase {
  final ProfileRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<void> call() async {
    await _repository.deleteAccount();
  }
}