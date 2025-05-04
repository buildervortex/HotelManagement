import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_room_image_auth_url.dart';
import 'package:mockito/annotations.dart';

import 'get_room_image_auth_url_test.mocks.dart';

@GenerateMocks([FileRepository])
void main() {
  late FileRepository repository;
  late GetRoomImageAuthUrl usecase;

  setUp(() {
    repository = MockFileRepository();
    usecase = GetRoomImageAuthUrl(repository: repository);
  });
}
