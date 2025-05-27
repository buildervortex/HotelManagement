import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/file_data_source.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FileRepositoryImpl implements FileRepository {
  final FileDataSource fileDataSource;

  FileRepositoryImpl({required this.fileDataSource});

  @override
  Future<Either<Failure, String>> getFileAuthUrl(
      String filePath, String bucketName) async {
    try {
      final response = await fileDataSource.getFileUrl(bucketName, filePath);
      return Right(response);
    } on StorageException catch (e) {
      return Left(ServerFailure());
    }
  }
}
