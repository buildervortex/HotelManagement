import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';

abstract class FileRepository {
  Future<Either<Failure, String>> getFileAuthUrl(
      String filePath, String bucketName);
}
