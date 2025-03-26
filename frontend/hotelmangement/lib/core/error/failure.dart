import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnAuthorizedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NotFound extends Failure {
  @override
  List<Object?> get props => [];
}
