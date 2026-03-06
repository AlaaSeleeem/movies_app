import '../../domain/ repositories/profile_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../data_source/profile_remote_data_source.dart';
import '../models/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<void> updateProfile(UserEntity user) async {
    await _dataSource.updateProfile(
      UserModel(
        name: user.name,
        phone: user.phone,
        avatarIndex: user.avatarIndex,
      ),
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _dataSource.deleteAccount();
  }

  @override
  Future<UserEntity?> getProfile() async {
    return await _dataSource.getProfile();
  }
}