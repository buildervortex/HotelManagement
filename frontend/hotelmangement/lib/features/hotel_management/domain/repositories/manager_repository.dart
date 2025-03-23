import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/manager.dart';

abstract class ManagerRepository {
  Future<Either<Failure, Manager>> updateManager(
      String role, String username, String phoneNumber);
}
