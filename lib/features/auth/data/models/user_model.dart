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

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, email: $email, role: $role)';
}
