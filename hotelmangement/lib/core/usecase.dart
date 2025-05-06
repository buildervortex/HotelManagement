import 'package:equatable/equatable.dart';
import "package:dartz/dartz.dart";
import 'package:hotelmangement/core/error/failure.dart';

abstract class Usecase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
