import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/manager_data_source.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/manager.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/manager_repository.dart';

class ManagerRepositoryImpl implements ManagerRepository {
  final ManagerDataSource dataSource;

  ManagerRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Manager>> addManager(String id) async {
    try {
      final manager = await dataSource.addManager(id);
      return Right(manager);
    } catch (e) {
      print("Error adding manager: $e");
      return Left(ServerFailure());
    }
  }
}
