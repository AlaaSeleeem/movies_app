import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.phone,
    required super.avatarIndex,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      avatarIndex: json['avatarIndex'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'avatarIndex': avatarIndex,
    };
  }
}