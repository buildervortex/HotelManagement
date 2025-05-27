import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:supabase/supabase.dart';

class FileRepositoryImpl implements FileRepository {
  final SupabaseClient supabaseClient;
  @override
  Future<Either<Failure, String>> getFileAuthUrl(
      String filePath, String bucketName) {
    throw UnimplementedError();
  }
}
