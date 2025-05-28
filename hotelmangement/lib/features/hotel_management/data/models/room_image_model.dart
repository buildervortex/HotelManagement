import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';

class RoomImageModel extends RoomImage {
  const RoomImageModel(
      {required super.roomId, required super.id, required super.imagePath});
  factory RoomImageModel.fromJson(Map<String, dynamic> json) {
    return RoomImageModel(
      id: json['id'] as String,
      imagePath: json['file'] as String,
      roomId: json['room_id'] as String,
    );
  }
}
