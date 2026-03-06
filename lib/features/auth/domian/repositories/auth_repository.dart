import '../entities/register_request.dart';

abstract class AuthRepository {
  Future<void> register({required RegisterRequest request});
  Future<void> sendPasswordResetEmail({required String email});
}