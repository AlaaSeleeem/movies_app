import 'package:equatable/equatable.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class DeleteAccountLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {}

class UpdateProfileError extends UpdateProfileState {
  final String message;
  const UpdateProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteAccountSuccess extends UpdateProfileState {}