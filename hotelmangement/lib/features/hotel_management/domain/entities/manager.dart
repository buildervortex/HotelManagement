import 'package:equatable/equatable.dart';

class Manager extends Equatable {
  final String id;
  final String username;
  final String phoneNumber;
  final String email;
  final String role;
  final String name;
  final String? bio;

  const Manager({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.bio,
    required this.name,
  });

  @override
  List<Object?> get props =>
      [id, username, phoneNumber, email, role, bio, name];
}
