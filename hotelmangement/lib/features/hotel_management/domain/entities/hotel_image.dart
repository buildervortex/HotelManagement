import 'package:hotelmangement/features/hotel_management/domain/entities/image.dart';

class HotelImage extends Image {
  final String hotelId;

  const HotelImage(
      {required super.id, required super.imagePath, required this.hotelId});

  @override
  List<Object?> get props => [id, imagePath, hotelId];

  // @override
  // HotelImage copyWith({String? hotelId}) {
  //   return HotelImage(
  //       id: id, imagePath: imagePath, hotelId: hotelId ?? this.hotelId);
  // }
  @override
  Image copyWith({String? id, String? imagePath, String? hotelId}) {
    return HotelImage(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      hotelId: hotelId ?? this.hotelId,
    );
  }
}
