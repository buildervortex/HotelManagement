part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoggingUser extends AuthState {
  final String userId;
  final bool isManager;

  const LoggingUser({required this.userId, required this.isManager});

  @override
  List<Object> get props => [userId, isManager];
}

final class LogOut extends AuthState {}