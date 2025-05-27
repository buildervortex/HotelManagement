import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FileRepositoryImpl implements FileRepository {
  final SupabaseClient supabaseClient;
  final expiryDurationSeconds = 60 * 60 * 1; // 1 hour

  FileRepositoryImpl({required this.supabaseClient});

  @override
  Future<Either<Failure, String>> getFileAuthUrl(
      String filePath, String bucketName) async {
    try {
      final response = await supabaseClient.storage
          .from(bucketName)
          .createSignedUrl(filePath, expiryDurationSeconds);
      return Right(response);
    } on StorageException catch (e) {
      return Left(ServerFailure());
    }
  }
}
