import 'package:equatable/equatable.dart';
import '../../domian/entities/register_request.dart';

abstract class AuthEvent {}

class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthActionEventRegister extends AuthEvent {
  final RegisterRequest request;
  AuthActionEventRegister({required this.request});
}

class PasswordResetRequested extends AuthEvent {
  final String email;
  PasswordResetRequested({required this.email});
}