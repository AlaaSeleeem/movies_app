import '../entities/user_entity.dart';

abstract class ProfileRepository {
  Future<void> updateProfile(UserEntity user);
  Future<void> deleteAccount();
  Future<UserEntity?> getProfile();
}