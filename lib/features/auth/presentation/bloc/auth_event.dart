import 'package:equatable/equatable.dart';
import '../../domian/entities/register_request.dart';

abstract class AuthEvent {}

class AuthActionEventRegister extends AuthEvent {
  final RegisterRequest request;
  AuthActionEventRegister({required this.request});
}

class PasswordResetRequested extends AuthEvent {
  final String email;
  PasswordResetRequested({required this.email});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  RegisterEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}