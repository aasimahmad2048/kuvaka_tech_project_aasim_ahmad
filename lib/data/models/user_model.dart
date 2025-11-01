
import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String? name;

  UserModel({required this.id, required this.email, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id']?.toString() ?? '',
        email: json['email'] ?? '',
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'name': name};

  factory UserModel.fromFirebaseUser(dynamic user) => UserModel(
        id: user.uid as String,
        email: user.email ?? '',
        name: user.displayName,
      );

  UserEntity toEntity() => UserEntity(id: id, email: email, name: name);
}
