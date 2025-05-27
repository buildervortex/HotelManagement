import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class FileDataSource {
  Future<void> uploadFile(File file, String imageName, String bucketName);
  Future<String> getFileUrl(String bucketName, String fileName);
  Future<String> deleteFile(String bucketName, String fileName);
}

class FileDataSourceImpl implements FileDataSource {
  final SupabaseClient client;
  final expiryDurationSeconds = 60 * 60 * 1; // 1 hour

  FileDataSourceImpl({required this.client});

  @override
  Future<void> uploadFile(
      File file, String imageName, String bucketName) async {
    final fileBytes = await file.readAsBytes();
    await client.storage.from(bucketName).updateBinary(imageName, fileBytes);
  }

  @override
  Future<String> getFileUrl(String bucketName, String fileName) async {
    return await client.storage
        .from(bucketName)
        .createSignedUrl(fileName, expiryDurationSeconds);
  }

  @override
  Future<String> deleteFile(String bucketName, String fileName) async {
    await client.storage.from(bucketName).remove([fileName]);
    return fileName;
  }
}
