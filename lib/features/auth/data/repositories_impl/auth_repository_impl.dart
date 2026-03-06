import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}