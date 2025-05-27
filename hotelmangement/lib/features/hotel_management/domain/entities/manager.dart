import 'package:equatable/equatable.dart';

class Manager extends Equatable {
  final String id;
  final String username;
  final String phoneNumber;
  final String email;

  const Manager(
      {required this.id,
      required this.username,
      required this.phoneNumber,
      required this.email,});

  @override
  List<Object?> get props => [id, username, phoneNumber, email];
}
