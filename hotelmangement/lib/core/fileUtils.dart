import 'package:uuid/v1.dart';

class Fileutils {
  static String uuidRenamedFile(String fileBaseName) {
    final uuid = UuidV1().generate();
    final fileExtension = fileBaseName.split('.').last;
    return '$uuid.$fileExtension';
  }
}
