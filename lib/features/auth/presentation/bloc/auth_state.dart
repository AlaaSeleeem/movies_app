abstract class AuthState {}
class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  @override
  List<Object?> get props => [];
  final String token;
  AuthSuccess(this.token);
}

class AuthError extends AuthState {
  @override
  List<Object?> get props => [];
  final String message;
  AuthError(this.message);
}