
import '../data_source/auth_interface_data_source.dart';
import '../../domian/entities/register_request.dart';
import '../../domian/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthInterfaceDataSource _authInterfaceDataSource;

  AuthRepositoryImpl(this._authInterfaceDataSource);

  @override
  Future<void> register({required RegisterRequest request}) async {
    try {
      await _authInterfaceDataSource.execute(request: request);
    } catch (e) {
      // handled by bloc
      throw Exception('Registration failed: $e');
    }
  }
}