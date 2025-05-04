import 'package:hotelmangement/features/hotel_management/domain/entities/image.dart';

class RoomImage extends Image {
  final String roomId;
  const RoomImage(
      {required this.roomId, required super.id, required super.imagePath});

  @override
  List<Object?> get props => [id, imagePath, roomId];
}
