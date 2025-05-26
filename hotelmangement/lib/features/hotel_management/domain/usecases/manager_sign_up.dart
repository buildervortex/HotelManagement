import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/manager.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/manager_repository.dart';

class ManagerSignUp extends Usecase<Manager, Params> {
  final ManagerRepository repository;

  ManagerSignUp({required this.repository});

  @override
  Future<Either<Failure, Manager>> call(Params params) async {
    return repository.addManager(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
