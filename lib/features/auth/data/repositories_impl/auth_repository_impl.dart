import '../data_source/auth_interface_data_source.dart';
import '../../domian/entities/register_request.dart';
import '../../domian/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthInterfaceDataSource _authInterfaceDataSource;

  AuthRepositoryImpl(this._authInterfaceDataSource);

  @override
  Future<void> register({required RegisterRequest request}) async {
    try {
      await _authInterfaceDataSource.execute(request: request);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }
}