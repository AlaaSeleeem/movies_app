import 'package:equatable/equatable.dart';

import '../../domian/entities/register_request.dart';

abstract class AuthEvent {}
class RegisterEvent extends Equatable {
  // final RegisterRequest request;
  // RegisterEvent(this.request);

  @override
  List<Object?> get props => [];
}

final class AuthActionEventRegister extends AuthEvent {
  final RegisterRequest request;
  AuthActionEventRegister({required this.request});

}