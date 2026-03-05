part of 'auth_bloc.dart';

abstract class AuthEvent {}
class PasswordResetRequested extends AuthEvent {
  final String email;

  PasswordResetRequested({required this.email});

}