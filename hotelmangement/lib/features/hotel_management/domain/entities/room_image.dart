import 'package:hotelmangement/features/hotel_management/domain/entities/image.dart';

class RoomImage extends Image {
  final String roomId;
  const RoomImage(
      {required this.roomId,
      required super.id,
      required super.imagePath,
      super.imageUrl});

  @override
  List<Object?> get props => [id, imagePath, roomId];

  // RoomImage copyWith({String? roomId}) {
  //   return RoomImage(
  //       roomId: roomId ?? this.roomId, id: id, imagePath: imagePath);
  // }

  @override
  Image copyWith({String? id, String? imagePath, String? imageUrl}) {
    return RoomImage(
      roomId: roomId,
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
