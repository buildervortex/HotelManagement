import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_room_images.dart';
import 'package:mockito/annotations.dart';

import 'get_room_images.mocks.dart';

@GenerateMocks([HotelRoomRepository])
void main() {
  late HotelRoomRepository repository;
  late GetRoomImages usecase;

  setUp(() {
    repository = MockHotelRoomRepository();
    usecase = GetRoomImages(repository: repository);
  });
}
