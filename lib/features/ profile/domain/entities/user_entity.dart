import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String phone;
  final int avatarIndex;

  const UserEntity({
    required this.name,
    required this.phone,
    required this.avatarIndex,
  });

  @override
  List<Object> get props => [name, phone, avatarIndex];
}