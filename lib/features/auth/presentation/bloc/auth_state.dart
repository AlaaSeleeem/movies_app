import 'package:equatable/equatable.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  final String? token;
  AuthSuccess(this.message, {this.token});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure({required this.errorMessage});
}