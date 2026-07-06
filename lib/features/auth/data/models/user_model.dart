import 'user_role.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.role,
  });

  final String id;
  final String name;
  final String email;
  final UserRole? role;

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'],
      email: map['email'],
      role: toUserRole(map['role']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'role': role?.name};
  }

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, email: $email, role: $role)';
}
