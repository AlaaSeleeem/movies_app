import '../ repositories/profile_repository.dart';
import '../entities/user_entity.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<void> call(UserEntity user) async {
    await _repository.updateProfile(user);
  }
}