import 'package:equatable/equatable.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends UpdateProfileEvent {}

class UpdateProfileSubmitted extends UpdateProfileEvent {
  final String name;
  final String phone;
  final int avatarIndex;

  const UpdateProfileSubmitted({
    required this.name,
    required this.phone,
    required this.avatarIndex,
  });

  @override
  List<Object> get props => [name, phone, avatarIndex];
}

class DeleteAccountEvent extends UpdateProfileEvent {}