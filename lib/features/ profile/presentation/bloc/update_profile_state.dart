import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class DeleteAccountLoading extends UpdateProfileState {}

class ProfileLoaded extends UpdateProfileState {
  final UserEntity user;
  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateProfileSuccess extends UpdateProfileState {}

class DeleteAccountSuccess extends UpdateProfileState {}

class UpdateProfileError extends UpdateProfileState {
  final String message;
  const UpdateProfileError(this.message);

  @override
  List<Object?> get props => [message];
}